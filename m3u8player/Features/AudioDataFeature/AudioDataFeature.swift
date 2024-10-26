//
//  AudioDataFeature.swift
//  m3u8player
//
//  Created by Kaito Kitaya on 05.10.24.
//

import Foundation
import ComposableArchitecture

@Reducer
struct AudioDataFeature {
    @ObservableState
    struct State: Equatable {
        var audioDataList: [AudioData] = {getDummyVideoModel()}()
    }
    
    enum Action {
        case addButtonTapped(data: AudioData)
        case trashButtonTapped(id: UUID)
    }
    
    var body: some Reducer<State, Action> {
        Reduce { state, action in
            switch action {
            case let .addButtonTapped(data):
                var newList = state.audioDataList
                newList.append(data)
                state.audioDataList = newList
                return .none
            
            case let .trashButtonTapped(id):
                var newList = state.audioDataList
                newList.removeAll { $0.id == id}
                state.audioDataList = newList
                return .none
            }
        }
    }
}
