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
    @State var currentTime: Double = 0
    @State var volume: Float = 0
    
    var body: some View {
        WithViewStore(self.store, observe: {$0}) { viewStore in
            VStack {
                Image("Images/musicSymbol")
                    .resizable()
                    .frame(width: UIScreen.main.bounds.size.width * 0.5, height: UIScreen.main.bounds.size.width * 0.5)
                    .scaledToFit()
                    .shadow(radius: 20)
                VStack(){
                    Text("Music title")
                }.frame(maxWidth: .infinity, alignment: .leading)
                 .paddingOnly(top: 30)
                VStack {
                    Slider(value: $currentTime, in: 0...100)
                        .paddingOnly(top: 30)
                    HStack {
                        Text("--:--")
                        Spacer()
                        Text("--:--")
                    }
                }
                HStack {
                    Button() {

                    } label: {
                        Image(systemName: "backward.fill")
                            .resizable()
                            .frame(width: 30, height: 30)
                            .paddingOnly(trailing: 60)
                    }
                    Button() {
                        viewStore.isPlay ?
                        store.send(.pause) : store.send(.play)
                    } label: {
                        Image(systemName:
                                viewStore.isPlay ? "pause.fill" : "play.fill")
                        .resizable()
                        .frame(width: 30, height: 30)
                    }
                    Button() {

                    } label: {
                        Image(systemName: "forward.fill")
                            .resizable()
                            .frame(width: 30, height: 30)
                            .paddingOnly(leading: 60)
                    }
                }.paddingOnly(top: 30)
//                HStack() {
//                    Image(systemName: "speaker.fill")
//                    KnoblessProgressbar(percentage: $volume, height: 20)
//                    Image(systemName: "speaker.wave.3.fill")
//                }.paddingOnly(top: 30)

            }.padding(32)
        }
    }
}

#Preview {
    MainPlayerView(store: Store(initialState: PlayerFeature.State()){})
}
