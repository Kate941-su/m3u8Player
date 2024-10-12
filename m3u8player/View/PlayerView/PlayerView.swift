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
                if !viewStore.isLoading {
                    PlayerComponent(store: store)
                } else {
                    ProgressView()
                }
            }.onAppear {
                store.send(.checkURL(URL(string: "https://cast.crn.fm:8000/radio.mp3")!))
            }
        }
    }
}

struct PlayerComponent : View {
    let store: StoreOf<PlayerFeature>
    
    init(store: StoreOf<PlayerFeature>) {
        self.store = store
    }
    
    var body: some View {
        WithViewStore(self.store, observe: {$0}) { viewStore in
            VStack{
                HStack {
                        CustomSlider(store: store, frequency: MusicPlayer.cutoffFrequencies[0])
                        CustomSlider(store: store, frequency: MusicPlayer.cutoffFrequencies[0])
                        CustomSlider(store: store, frequency: MusicPlayer.cutoffFrequencies[0])
                        CustomSlider(store: store, frequency: MusicPlayer.cutoffFrequencies[0])
                        CustomSlider(store: store, frequency: MusicPlayer.cutoffFrequencies[0])
                        CustomSlider(store: store, frequency: MusicPlayer.cutoffFrequencies[0])
                        CustomSlider(store: store, frequency: MusicPlayer.cutoffFrequencies[0])
                        CustomSlider(store: store, frequency: MusicPlayer.cutoffFrequencies[0])
                }
                Text("Music title")
                Button() {
                    viewStore.isPlay ?
                    store.send(.pause) : store.send(.play)
                } label: {
                    viewStore.isPlay ?
                    Image(systemName: "pause.fill") :
                    Image(systemName: "play.fill")
                }
            }
        }
    }
}

#Preview {
    PlayerComponent(store: Store(initialState: PlayerFeature.State()) {
        
    })
}
