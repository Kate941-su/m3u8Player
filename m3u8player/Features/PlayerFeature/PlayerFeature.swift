//
//  PlayerFeature.swift
//  m3u8player
//
//  Created by Kaito Kitaya on 12.10.24.
//

import Foundation
import ComposableArchitecture

@Reducer
struct PlayerFeature {
    
    let networkRepository: NetworkRepository
    
    @ObservableState
    struct State: Equatable {
        var isPlay: Bool = false
        var isLoading: Bool = true
        var gain60: Float = 0.0
        var gain170: Float = 0.0
        var gain310: Float = 0.0
        var gain600: Float = 0.0
        var gain1k: Float = 0.0
        var gain3k: Float = 0.0
        var gain6k: Float = 0.0
        var gain12k: Float = 0.0
        var gain14k: Float = 0.0
        var gain16k: Float = 0.0
    }
    
    enum Action {
        case checkURL(URL)
        case responseCheckURL(Result<HTTPURLResponse, Error>)
        case play
        case pause
        case changeSliderValue(FrequencyCandidates)
    }
    
    var body: some Reducer<State, Action> {
        Reduce { state, action in
            switch action {
            case .changeSliderValue(let value):
                MusicPlayer.shared.setGain(frequencyCandidate: value)
                switch value{
                case .gain60(let gain):
                    state.gain60 = gain
                    print("[Frequency] 60/ [Gain] \(gain)")
                case .gain170(let gain):
                    print("[Frequency] 130/ [Gain] \(gain)")
                    state.gain170 = gain
                case .gain310(let gain):
                    print("[Frequency] 310/ [Gain] \(gain)")
                    state.gain310 = gain
                case .gain600(let gain):
                    print("[Frequency] 600/ [Gain] \(gain)")
                    state.gain600 = gain
                case .gain1k(let gain):
                    print("[Frequency] 1k/ [Gain] \(gain)")
                    state.gain1k = gain
                case .gain3k(let gain):
                    print("[Frequency] 3k/ [Gain] \(gain)")
                    state.gain3k = gain
                case .gain6k(let gain):
                    print("[Frequency] 6k/ [Gain] \(gain)")
                    state.gain6k = gain
                case .gain12k(let gain):
                    print("[Frequency] 12k/ [Gain] \(gain)")
                    state.gain12k = gain
                case .gain14k(let gain):
                    print("[Frequency] 14k/ [Gain] \(gain)")
                    state.gain14k = gain
                case .gain16k(let gain):
                    print("[Frequency] 16k/ [Gain] \(gain)")
                    state.gain16k = gain
                }
            // TODO: write handling how to change gain in Music Player
                return .none
            case .play:
                MusicPlayer.shared.play()
                state.isPlay = true
                return .none
            case .pause:
                MusicPlayer.shared.stop()
                state.isPlay = false
                return .none
            case let .checkURL(url):
                return .run { send in
                        let result = await checkisValidURL(url: url)
                        await send(.responseCheckURL(result))
                }
            case .responseCheckURL(let result):
                state.isLoading = false
                switch result {
                case .success(let urlResponse):
                    MusicPlayer.shared.initializeAudioEngine()
                    MusicPlayer.shared.changeItem(url: urlResponse.url!)
                    MusicPlayer.shared.play()
                    state.isPlay = true
                 case .failure(let error):
                    print("Error is happening: \(error.localizedDescription)")
                }
                return .none
            }
        }
    }
    
    private func checkisValidURL(url: URL) async  -> Result<HTTPURLResponse, Error> {
        let urlSession = URLSession.shared
        var request = URLRequest(url: url)
        request.httpMethod = "HEAD"
        guard let (_, response) = try? await urlSession.data(for: request) else {
            // TODO: Need to verify this error code is good or not
            return .failure(URLError(URLError.badURL))
        }
            if let httpResponse = response as? HTTPURLResponse {
                if (200...299).contains(httpResponse.statusCode) {
                    return .success(httpResponse)
                }
            } else {
                // TODO: Need to verify this error code is good or not
                return .failure(URLError(URLError.badURL))
            }
        // TODO: Need to verify this error code is good or not
        return .failure(URLError(URLError.badURL))
    }
    
    
}

enum FrequencyCandidates {
    case gain60(Float)
    case gain170(Float)
    case gain310(Float)
    case gain600(Float)
    case gain1k(Float)
    case gain3k(Float)
    case gain6k(Float)
    case gain12k(Float)
    case gain14k(Float)
    case gain16k(Float)
    
    var label: String {
        switch self {
        case .gain60(_):
            return "60"
        case .gain170(_):
            return "170"
        case .gain310(_):
            return "310"
        case .gain600(_):
            return "600"
        case .gain1k(_):
            return "1K"
        case .gain3k(_):
            return "3K"
        case .gain6k(_):
            return "6K"
        case .gain12k(_):
            return "12K"
        case .gain14k(_):
            return "14K"
        case .gain16k(_):
            return "16K"
        }
    }
}
