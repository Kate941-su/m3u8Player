//
//  MusicPlayer.swift
//  m3u8player
//
//  Created by Kaito Kitaya on 12.10.24.
//
import AVFoundation

class MusicPlayer {
    
    // This values are inspired by Winamp
    static let shared = MusicPlayer()
    private let player = AVPlayer()
    private(set) var currentItem: AVPlayerItem? = nil
    
    private init(){
        do {
            try AVAudioSession.sharedInstance().setCategory(AVAudioSession.Category.playback)
            try AVAudioSession.sharedInstance().setActive(true)
        } catch {
            debugPrint("[ERROR]: \(error)")
        }
     }
    
    func deactivate() {
        do {
            try AVAudioSession.sharedInstance().setActive(false)
        } catch {
            debugPrint("[ERROR]: \(error)")
        }
    }
    
    func setItem(url: URL) {
        currentItem = AVPlayerItem(url: url)
        player.replaceCurrentItem(with: currentItem!)
    }
    
    func play() {
        player.play()
    }
    
    func stop() {
        player.pause()
    }
}
