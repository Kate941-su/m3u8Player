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
    @ObservableState
    struct State: Equatable {
        var isPlay: Bool = false
    }
    
    enum Action {
        case play
        case pause
    }
    
    var body: some Reducer<State, Action> {
        Reduce { state, action in
            switch action {
            case .play:
                state.isPlay = true
                return .none
            case .pause:
                state.isPlay = false
                return .none
            }
        }
    }
}
