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
        var videoDataList: [VideoData] = []
    }
    
    enum Action {
        case addButtonTapped(data: VideoData)
    }
    
    var body: some Reducer<State, Action> {
        Reduce { state, action in
            switch action {
            case .addButtonTapped:
                print("addButtonTapped")
                return .none
            }
        }
    }
}
