//
//  WebSocketManager.swift
//  Sinc
//
//  Created by shadi bou zin eddin on 20/01/1446 AH.
//

import Foundation

final class WebSocketManager:ObservableObject{
    
    private var webSocketTask: URLSessionWebSocketTask?
    
    
    func connectWebSocket() {
            let url = URL(string: "ws://your-server-url:8080")!
            webSocketTask = URLSession.shared.webSocketTask(with: url)
            webSocketTask?.resume()
            receiveMessages()
        }
    
    func receiveMessages() {
            webSocketTask?.receive { [weak self] result in
                switch result {
                case .success(let message):
                    switch message {
                    case .data(let data):
                        self?.handleData(data)
                    case .string(let string):
                        self?.handleString(string)
                    @unknown default:
                        fatalError()
                    }
                case .failure(let error):
                    print("WebSocket error: \(error)")
                }
                self?.receiveMessages()
            }
        }
    
    func handleData(_ data: Data) {
            // Parse and update your data
        }

        func handleString(_ string: String) {
            // Parse and update your data
        }

        func sendMessage(_ message: String) {
            webSocketTask?.send(.string(message)) { error in
                if let error = error {
                    print("WebSocket send error: \(error)")
                }
            }
        }

        func close() {
            webSocketTask?.cancel(with: .goingAway, reason: nil)
        }
    
}
