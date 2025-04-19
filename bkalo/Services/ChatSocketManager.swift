//
//  ChatSocketManager.swift
//  bkalo
//
//  Created by Nguyen Minh Tam on 21/2/25.
//

import UIKit
import Starscream
import MessageKit

struct Media: MediaItem {
    var url: URL?
    var image: UIImage?
//    var image: UIImage? {
//        guard let url = url else { return nil }
//        if let data = try? Data(contentsOf: url) {
//            return UIImage(data: data)
//        }
//        return nil
//    }
    var placeholderImage: UIImage
    var size: CGSize
}

final class ChatSocketManager {
    
    static let shared = ChatSocketManager()
    private var socket: WebSocket?
    private var isConnected: Bool = false
    
    var onReceiveMessage: ((Message) -> Void)?
    
    private init() {}
    
    func createSocket(url: URL) {
        var request = URLRequest(url: url)
        request.timeoutInterval = 5
        request.setValue("websocket", forHTTPHeaderField: "Upgrade")
        request.setValue("Upgrade", forHTTPHeaderField: "Connection")
        socket = WebSocket(request: request)
        socket?.delegate = self
        socket?.connect()
        
        NotificationCenter.default.addObserver(self, selector: #selector(connectSocket), name: UIApplication.willEnterForegroundNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(disconnectSocket), name: UIApplication.didEnterBackgroundNotification, object: nil)
    }
    
    func handleError(_ error: Error?) {
        if let e = error as? WSError {
            print("websocket encountered an error: \(e.message)")
        } else if let e = error {
            print("websocket encountered an error: \(e.localizedDescription)")
        } else {
            print("websocket encountered an error")
        }
    }
    
    func sendMessage(data: Data) {
        guard isConnected else {
            print("Socket not connected. Message not sent.")
            return
        }
        
        if let jsonString = String(data: data, encoding: .utf8) {
            socket?.write(string: jsonString)
        }
    }
    
    @objc private func connectSocket() {
        socket?.connect()
    }
    
    @objc private func disconnectSocket() {
        socket?.disconnect()
    }
}

extension ChatSocketManager: WebSocketDelegate {
    func didReceive(event: Starscream.WebSocketEvent, client: Starscream.WebSocketClient) {
        switch event {
        case .connected(let headers):
            isConnected = true
            print("websocket is connected: \(headers)")
        case .disconnected(let reason, let code):
            isConnected = false
            print("websocket is disconnected: \(reason) with code: \(code)")
        case .text(let string):
            print("Received text message: \(string)")
            if let data = string.data(using: .utf8),
               let json = try? JSONSerialization.jsonObject(with: data) as? [String: Any],
               let rawMessage = json["message"] as? String,
               let person = json["person"] as? [String: Any],
               let senderId = person["id"] as? Int,
               let displayName = person["full_name"] as? String {
                
                let avatarURL = person["avatar_url"] as? String
                let sender = ChatMember(
                    senderId: "\(senderId)",
                    displayName: displayName,
                    avatarURL: avatarURL
                )
                let messageType = json["message_type"] as? String ?? "text"

                // Text message — no URL needed
                if messageType == "text" {
                    let message = Message(
                        sender: sender,
                        messageId: UUID().uuidString,
                        sentDate: Date(),
                        kind: .text(rawMessage)
                    )
                    onReceiveMessage?(message)
                    return
                }
                
                getPublicFile(key: rawMessage) { success, result in
                    if success {
                        var msg: Message
                        guard let url = result else { return }
                        switch messageType {
                        case "image", "sticker":
                            let media = Media(url: url, placeholderImage: UIImage(), size: CGSize(width: 240, height: 240))
                            msg = Message(sender: sender, messageId: UUID().uuidString, sentDate: Date(), kind: .photo(media))
                        case "video":
                            let media = Media(url: url, placeholderImage: UIImage(), size: CGSize(width: 240, height: 240))
                            msg = Message(sender: sender, messageId: UUID().uuidString, sentDate: Date(), kind: .video(media))
                        case "file":
                            msg = Message(sender: sender, messageId: UUID().uuidString, sentDate: Date(), kind: .text("[File] \(url.lastPathComponent)\n\(url.absoluteString)"))
                        default:
                            msg = Message(sender: sender, messageId: UUID().uuidString, sentDate: Date(), kind: .text("[Unsupported message type!"))
                        }
                        
                        DispatchQueue.main.async {
                            self.onReceiveMessage?(msg)
                        }
                    }
                }
            }
        case .binary(let data):
            print("Received data: \(data.count)")
        case .ping, .pong, .viabilityChanged, .reconnectSuggested, .peerClosed:
            break
        case .cancelled:
            isConnected = false
        case .error(let error):
            isConnected = false
            handleError(error)
        }
    }
}

extension ChatSocketManager {
    
    func getGroupPrivate(friendId: Int, completion: @escaping (Bool, Int?) -> Void) {
        guard let request = chatRequest.getGroupId(id: friendId) else {
            completion(false, nil)
            return
        }
        
        NetworkService.shared.sendRequest(request, parse: { data -> Int? in
            guard let json = try? JSONSerialization.jsonObject(with: data) as? [String: Any],
                  let dataDict = json["data"] as? [String: Any],
                  let id = dataDict["id"] as? Int else {
                return nil
            }
            return id
        }) { result in
            switch result {
            case .success(let groupId):
                print("Group ID found: \(groupId)")
                completion(true, groupId)
            case .failure(let error):
                switch error {
                case .server(let message):
                    print("Error message: \(message)")
                case .statusCode(let code):
                    print("Error code: \(code)")
                default:
                    break
                }
                completion(false, nil)
            }
        }
    }
    
    func getChatHistory(groupId: Int, completion: @escaping (Bool, [Message]?) -> Void) {
        guard let request = chatRequest.getChatList(groupId: groupId) else {
            completion(false, nil)
            return
        }

        NetworkService.shared.sendRequestWithoutParsing(request) { result in
            switch result {
            case .success(let data):
                guard
                    let json = try? JSONSerialization.jsonObject(with: data) as? [String: Any],
                    let dataArray = json["data"] as? [[String: Any]]
                else {
                    completion(false, nil)
                    return
                }

                let formatter = DateFormatter()
                formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSSSS"
                formatter.locale = Locale(identifier: "en_US_POSIX")
                formatter.timeZone = TimeZone(secondsFromGMT: 0)

                var allMessages: [Message] = []
                var mediaMessages: [Message] = []
                let dispatchGroup = DispatchGroup()

                for dict in dataArray {
                    guard
                        let person = dict["person"] as? [String: Any],
                        let senderId = person["id"] as? Int,
                        let senderName = person["full_name"] as? String,
                        let messageContent = dict["message"] as? String,
                        let messageType = dict["message_type"] as? String,
                        let timeString = dict["time"] as? String,
                        let date = formatter.date(from: timeString)
                    else { continue }

                    let sender = ChatMember(senderId: "\(senderId)", displayName: senderName, avatarURL: person["avatar_url"] as? String)

                    var reactions: [ChatReaction] = []
                    if let reactionArray = dict["reactions"] as? [[String: Any]] {
                        for r in reactionArray {
                            if let emoji = r["reaction"] as? String,
                               let count = r["count"] as? Int,
                               let reactorName = r["full_name"] as? String,
                               let reactorId = r["id"] as? Int {
                                let reactor = ChatMember(senderId: "\(reactorId)", displayName: reactorName, avatarURL: r["avatar_url"] as? String)
                                reactions.append(ChatReaction(emoji: emoji, count: count, reactors: [reactor]))
                            }
                        }
                    }

                    if messageType == "text" {
                        let message = Message(sender: sender, messageId: UUID().uuidString, sentDate: date, kind: .text(messageContent), reactions: reactions.isEmpty ? nil : reactions)
                        allMessages.append(message)
                    } else {
                        dispatchGroup.enter()
                        self.getPublicFile(key: messageContent) { success, result in
                            if success, let url = result {
                                switch messageType {
                                case "image", "sticker":
                                    URLSession.shared.dataTask(with: url) { data, _, _ in
                                        defer { dispatchGroup.leave() }
                                        guard let data = data, let image = UIImage(data: data) else { return }

                                        let media = Media(
                                            url: url,
                                            image: image,
                                            placeholderImage: UIImage(),
                                            size: CGSize(width: 240, height: 240)
                                        )
                                        let message = Message(sender: sender, messageId: UUID().uuidString, sentDate: date, kind: .photo(media), reactions: reactions.isEmpty ? nil : reactions)
                                        mediaMessages.append(message)
                                    }.resume()

                                case "video":
                                    URLSession.shared.dataTask(with: url) { data, _, _ in
                                        defer { dispatchGroup.leave() }
                                        guard let data = data, let image = UIImage(data: data) else { return }

                                        let media = Media(
                                            url: url,
                                            image: image,
                                            placeholderImage: UIImage(),
                                            size: CGSize(width: 240, height: 240)
                                        )
                                        let message = Message(sender: sender, messageId: UUID().uuidString, sentDate: date, kind: .video(media), reactions: reactions.isEmpty ? nil : reactions)
                                        mediaMessages.append(message)
                                    }.resume()

                                case "file":
                                    let message = Message(sender: sender, messageId: UUID().uuidString, sentDate: date, kind: .text("[File] \(url.lastPathComponent)\n\(url.absoluteString)"), reactions: reactions.isEmpty ? nil : reactions)
                                    mediaMessages.append(message)
                                    dispatchGroup.leave()

                                default:
                                    let message = Message(sender: sender, messageId: UUID().uuidString, sentDate: date, kind: .text("[Unsupported message type]"), reactions: reactions.isEmpty ? nil : reactions)
                                    mediaMessages.append(message)
                                    dispatchGroup.leave()
                                }
                            } else {
                                dispatchGroup.leave()
                            }
                        }
                    }
                }

                dispatchGroup.notify(queue: .main) {
                    let mergedMessages = (allMessages + mediaMessages).sorted(by: { $0.sentDate < $1.sentDate })
                    completion(true, mergedMessages)
                }

            case .failure(let error):
                switch error {
                case .server(let message):
                    print("Server error: \(message)")
                case .statusCode(let code):
                    print("HTTP error: \(code)")
                default:
                    print("Other error: \(error)")
                }
                completion(false, nil)
            }
        }
    }
    
    func getPublicFile(key: String, isPublic: Bool = true, completion: @escaping (Bool, URL?) -> Void) {
        guard let request = chatRequest.getPublicFile(key: key, isPublic: isPublic) else {
            completion(false, nil)
            return
        }
        
        NetworkService.shared.sendRequest(request, parse: { data -> URL? in
            guard let json = try? JSONSerialization.jsonObject(with: data) as? [String: Any],
                  let dataDict = json["data"] as? [String: Any],
                  let urlString = dataDict["url"] as? String,
                  let url = URL(string: urlString) else {
                return nil
            }
            return url
        }) { result in
            switch result {
            case .success(let url):
                print("URL string found: \(url)")
                completion(true, url)
            case .failure(let error):
                switch error {
                case .server(let message):
                    print("Error message: \(message)")
                case .statusCode(let code):
                    print("Error code: \(code)")
                default:
                    break
                }
                completion(false, nil)
            }
        }
    }
}
