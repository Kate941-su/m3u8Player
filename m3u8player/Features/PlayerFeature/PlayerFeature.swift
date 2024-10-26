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
        var playerStatus: PlayerStatus = .Loading
        var isMute: Bool = false
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
        case mute
        case unMute
        case changeSliderValue(FrequencyCandidates)
    }
    
    var body: some Reducer<State, Action> {
        Reduce { state, action in
            switch action {
            case .changeSliderValue(let value):
                // TODO: For the future feature
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
                    let result = await networkRepository.checkIsValidURL(url: url)
                    await send(.responseCheckURL(result))
                }
            case .responseCheckURL(let result):
                switch result {
                case .success(let urlResponse):
                    MusicPlayer.shared.setItem(url: urlResponse.url!)
                    state.playerStatus = .Enable
                 case .failure(let error):
                    state.playerStatus = .Disable
                    print("Error is happening: \(error.localizedDescription)")
                }
                return .none
                case .mute:
                    state.isMute = true
                    MusicPlayer.shared.changeMute(isMute: true)
                    return .none
                case .unMute:
                    state.isMute = false
                    MusicPlayer.shared.changeMute(isMute: false)
                    return .none
            }
        }
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

enum PlayerStatus {
    case Loading
    case Disable
    case Enable
}
