//
//  MusicPlayer.swift
//  m3u8player
//
//  Created by Kaito Kitaya on 12.10.24.
//
import AVFoundation


class MusicPlayer {
    
    static let shared = MusicPlayer()
    
    private init(){}
    
    private let player = AVPlayer(playerItem: nil)
    
    func activateAVAudionSession() {
        try? AVAudioSession.sharedInstance().setCategory(AVAudioSession.Category.playback)
        try? AVAudioSession.sharedInstance().setActive(true)
    }
    
    func deactivate() {
        player.pause()
        try? AVAudioSession.sharedInstance().setActive(false)
        player.replaceCurrentItem(with: nil)
    }
    
    func changeItem(url: URL) {
        player.replaceCurrentItem(with: AVPlayerItem(url: url))
    }
    
    func play() {
        player.play()
    }
    
    func stop() {
        player.pause()
    }
    
}
