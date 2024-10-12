//
//  MusicPlayer.swift
//  m3u8player
//
//  Created by Kaito Kitaya on 12.10.24.
//
import AVFoundation


class MusicPlayer {
    
    // This values are inspired by Winamp
    static let cutoffFrequencies = [60, 170, 310, 600, 1000, 3000, 6000, 12000, 14000, 16000]
    private let defaultGain = 0 // db -12db ~ 12db
    static let shared = MusicPlayer()
    
    private init(){}
    
    private let player = AVPlayer(playerItem: nil)
    private let audioEngine = AVAudioEngine()
    private let equalizer = AVAudioUnitEQ(numberOfBands: 6)
    
    func setupAudioEngine() {
        let band = equalizer.bands
    }
    
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
