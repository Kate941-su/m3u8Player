//
//  VideoDataFeature.swift
//  m3u8player
//
//  Created by Kaito Kitaya on 05.10.24.
//

import Foundation
import ComposableArchitecture

@Reducer
struct VideoDataFeature {
    @ObservableState
    struct State: Equatable {
        var videoDataList: [VideoData] = {getDummyVideoModel()}()
    }
    
    enum Action {
        case addButtonTapped(data: VideoData)
        case trashButtonTapped(id: UUID)
    }
    
    var body: some Reducer<State, Action> {
        Reduce { state, action in
            switch action {
            case let .addButtonTapped(data):
                var newList = state.videoDataList
                newList.append(data)
                state.videoDataList = newList
                return .none
            
            case let .trashButtonTapped(id):
                var newList = state.videoDataList
                newList.removeAll { $0.id == id}
                state.videoDataList = newList
                return .none
            }
        }
    }
}
