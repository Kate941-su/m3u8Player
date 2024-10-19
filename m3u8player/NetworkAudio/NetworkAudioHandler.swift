//
//  NetworkAudioHandler.swift
//  m3u8player
//
//  Created by Kaito Kitaya on 13.10.24.
//
import Foundation
import AVFoundation

class NetworkAudioHandler: NSObject, URLSessionDataDelegate  {
    
    private var dataTask: URLSessionDataTask?
    
    let fetchAudioDataDelegate: ((Data) -> Void)?
    
    init(delegate: ((Data) -> Void)? = nil){
        self.fetchAudioDataDelegate = delegate
    }
    
    func urlSession(_ session: URLSession, dataTask: URLSessionDataTask, didReceive data: Data) {
        processAudioData(data)
    }
    
    private func processAudioData(_ data: Data) {
        guard let delegate = fetchAudioDataDelegate else {
            return
        }
        delegate(data)
    }
    
    func startStreaming(streamingURL: URL) {
        let session = URLSession(configuration: .default, delegate: self, delegateQueue: nil)
        dataTask = session.dataTask(with: streamingURL)
        dataTask?.resume()
    }
    
    // Test
    func test() {

    }
    
    // Test
    func stopStreaming() {
        dataTask?.cancel()
    }
    
    
}

