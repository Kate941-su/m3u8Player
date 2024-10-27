//
//  PlayerView.swift
//  m3u8player
//
//  Created by Kaito Kitaya on 03.10.24.
//
import Foundation
import SwiftUI
import ComposableArchitecture

struct PlayerView : View {
    let store: StoreOf<PlayerFeature>
    
    init(store: StoreOf<PlayerFeature>) {
        self.store = store
    }
    
    var body: some View {
        WithViewStore(self.store, observe: {$0}) { viewStore in
            VStack{
                switch viewStore.playerStatus {
                    case .Loading:
                        ProgressView()
                    case .Disable:
                        Text("TODO: make when receiving disable state")
                    case .Enable:
                        MainPlayerView(store: store, height: UIScreen.main.bounds.height)
                }
            }.onAppear {
                if viewStore.playerStatus == .Loading {
                    store.send(.checkURL(URL(string: "https://cast.crn.fm:8000/radio.mp3")!))
                }
            }
        }
    }
}

#Preview {
    MainPlayerView(store: Store(initialState: PlayerFeature.State()){},
                   height: UIScreen.main.bounds.height)
}
