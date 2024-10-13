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
    static let shared = MusicPlayer()

    private let audioEngine = AVAudioEngine()
    private let equalizer = AVAudioUnitEQ(numberOfBands: MusicPlayer.cutoffFrequencies.count)
    private let defaultGain = Float(0) // db -12db ~ 12db
    private let playerNode = AVAudioPlayerNode()
    
    private init(){}

    func initializeAudioEngine() {
        do {
            try AVAudioSession.sharedInstance().setCategory(AVAudioSession.Category.playback)
            try AVAudioSession.sharedInstance().setActive(true)
            for (index, frequency) in MusicPlayer.cutoffFrequencies.enumerated() {
                let band = equalizer.bands[index]
                band.filterType = .parametric
                band.frequency = Float(frequency)
                band.bypass = false
                band.gain = -12
            }
            audioEngine.attach(equalizer)
            audioEngine.attach(playerNode)
            audioEngine.connect(playerNode, to: equalizer, format: nil)
            audioEngine.connect(equalizer, to: audioEngine.outputNode, format: nil)
        } catch {
            print("Error: \(error.localizedDescription)")
        }
    }
    
    func setGain(frequencyCandidate: FrequencyCandidates) {
        switch frequencyCandidate {
        case .gain60(let value):
            equalizer.bands[0].gain = value
        case .gain170(let value):
            equalizer.bands[1].gain = value
        case .gain310(let value):
            equalizer.bands[2].gain = value
        case .gain600(let value):
            equalizer.bands[3].gain = value
        case .gain1k(let value):
            equalizer.bands[4].gain = value
        case .gain3k(let value):
            equalizer.bands[5].gain = value
        case .gain6k(let value):
            equalizer.bands[6].gain = value
        case .gain12k(let value):
            equalizer.bands[7].gain = value
        case .gain14k(let value):
            equalizer.bands[8].gain = value
        case .gain16k(let value):
            equalizer.bands[9].gain = value
        }
    }
    
    func deactivate() {
        try? AVAudioSession.sharedInstance().setActive(false)
    }
    
    func changeItem(url: URL) {
//        player.replaceCurrentItem(with: AVPlayerItem(url: url))
    }
    
    func play() {
        audioEngine.prepare()
        do {
            try audioEngine.start()
            playerNode.play()
//            player.play()
        } catch {
          print("[Error] \(error)")
        }

    }
    
    func stop() {
//        player.pause()
    }
    
}
