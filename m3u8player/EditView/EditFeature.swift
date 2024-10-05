//
//  EditFeature.swift
//  m3u8player
//
//  Created by Kaito Kitaya on 05.10.24.
//

import Foundation
import ComposableArchitecture

@Reducer
struct EditFeature {
    
    @ObservableState
    struct State: Equatable {
        
    }

    enum Action {
        case addButtonTapped
    }
    
    var body: some Reducer<State, Action> {
        Reduce { state, action in
            switch action {
            // You can write side effects only in the action
            case .addButtonTapped:
                print("addButtonTapped")
                return .none
            }
        }
    }
    
}
