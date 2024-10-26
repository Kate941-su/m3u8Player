//
//  MainPlayerView.swift
//  m3u8player
//
//  Created by Kaito Kitaya on 26.10.24.
//
import ComposableArchitecture
import SwiftUI

struct MainPlayerView : View {
    let store: StoreOf<PlayerFeature>
    init(store: StoreOf<PlayerFeature>) {
        self.store = store
    }
    
    var body: some View {
        WithViewStore(self.store, observe: {$0}) { viewStore in
            VStack(){
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
