//
//  NetworkService.swift
//  bkalo
//
//  Created by Nguyen Minh Tam on 14/4/25.
//

import Foundation

enum NetworkError: Error {
    case network(Error)
    case invalidResponse
    case noData
    case parsingFailed
    case server(String)
    case statusCode(Int)
}

final class NetworkService {
    static let shared = NetworkService()

    private init() {}

    func sendRequest<T>(_ request: URLRequest, parse: @escaping (Data) -> T?, completion: @escaping (Result<T, NetworkError>) -> Void) {
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                return self.completeOnMain(.failure(.network(error)), completion)
            }

            guard let httpResponse = response as? HTTPURLResponse else {
                return self.completeOnMain(.failure(.invalidResponse), completion)
            }

            guard let data = data else {
                return self.completeOnMain(.failure(.noData), completion)
            }
            
//            if let rawResponse = String(data: data, encoding: .utf8) {
//                print("🔽 Raw response body (\(data.count) bytes):")
//                print(rawResponse)
//            } else {
//                print("⚠️ Could not decode response body as UTF-8")
//            }

            switch httpResponse.statusCode {
            case 200:
                if let result = parse(data) {
                    self.completeOnMain(.success(result), completion)
                } else {
                    self.completeOnMain(.failure(.parsingFailed), completion)
                }
            case 404:
                let errorMessage = self.parseErrorDetail(from: data) ?? "User not found"
                self.completeOnMain(.failure(.server(errorMessage)), completion)
            default:
                self.completeOnMain(.failure(.statusCode(httpResponse.statusCode)), completion)
            }
        }

        task.resume()
    }

    private func parseErrorDetail(from data: Data) -> String? {
        guard let json = try? JSONSerialization.jsonObject(with: data) as? [String: Any],
              let detail = json["detail"] as? String else {
            return nil
        }
        return detail
    }

    private func completeOnMain<T>(_ result: Result<T, NetworkError>, _ completion: @escaping (Result<T, NetworkError>) -> Void) {
        DispatchQueue.main.async {
            completion(result)
        }
    }
}

extension NetworkService {
    func sendRequestWithoutParsing(_ request: URLRequest, completion: @escaping (Result<Data, NetworkError>) -> Void) {
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                return self.completeOnMain(.failure(.network(error)), completion)
            }

            guard let httpResponse = response as? HTTPURLResponse else {
                return self.completeOnMain(.failure(.invalidResponse), completion)
            }

            guard let data = data else {
                return self.completeOnMain(.failure(.noData), completion)
            }

            switch httpResponse.statusCode {
            case 200:
                self.completeOnMain(.success(data), completion)
            case 404:
                let errorMessage = self.parseErrorDetail(from: data) ?? "User not found"
                self.completeOnMain(.failure(.server(errorMessage)), completion)
            default:
                self.completeOnMain(.failure(.statusCode(httpResponse.statusCode)), completion)
            }
        }

        task.resume()
    }
}
