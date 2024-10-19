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
    
    func urlSession(_ session: URLSession, dataTask: URLSessionDataTask, didReceive data: Data) {
        processAudioData(data)
    }
    
    private func processAudioData(_ data: Data) {
        // Convert Data to AVAudioPCMBuffer and schedule it for playback
        let format = AVAudioFormat(standardFormatWithSampleRate: 44100, channels: 2)!
        let buffer = AVAudioPCMBuffer(pcmFormat: format, frameCapacity: AVAudioFrameCount(data.count / MemoryLayout<Float>.size))
        
        // Fill the buffer with the audio data (ensure data is in correct format)
        buffer?.frameLength = buffer!.frameCapacity
        let channelData = buffer?.floatChannelData?[0]
        
        // Check if the buffer is valid and copy data into it
        if let channelData = channelData {
            data.copyBytes(to: UnsafeMutableBufferPointer(start: channelData, count: data.count / MemoryLayout<Float>.size))
        }
        
        debugPrint("[Audio Buffer]: \(buffer?.format)")
        // TODO: Hand over channelData for MusicPlayer buffer.
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

