//
//  ChatSocketManager.swift
//  bkalo
//
//  Created by Nguyen Minh Tam on 21/2/25.
//

import UIKit
import Starscream

final class ChatSocketManager {
    
    static let shared = ChatSocketManager()
    private var socket: WebSocket?
    private var isConnected: Bool = false
    
    private init() {}
    
    func createSocket(url: URL) {
        var request = URLRequest(url: URL(string: "http://localhost:8080")!)
        request.timeoutInterval = 5
        socket = WebSocket(request: request)
        socket?.delegate = self
        
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
            print("Received text: \(string)")
        case .binary(let data):
            print("Received data: \(data.count)")
        case .ping(_):
            break
        case .pong(_):
            break
        case .viabilityChanged(_):
            break
        case .reconnectSuggested(_):
            break
        case .cancelled:
            isConnected = false
        case .error(let error):
            isConnected = false
            handleError(error)
        case .peerClosed:
            break
        }
    }
}
