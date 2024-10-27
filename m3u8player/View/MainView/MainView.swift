//
//  ContentView.swift
//  m3u8player
//
//  Created by Kaito Kitaya on 03.10.24.
//

import SwiftUI
import ComposableArchitecture

struct MainView: View {
    @State private var showAlert = false
    let store: StoreOf<AudioDataFeature>
    let playerStore: StoreOf<PlayerFeature>
    
    init(store: StoreOf<AudioDataFeature>, playerStore: StoreOf<PlayerFeature>) {
        self.store = store
        self.playerStore = playerStore
    }
    
    var body: some View {
        VStack {
            SubView(store: store,
                    playerStore: playerStore
            )
        }
    }
}

struct SubView: View {
    
    let store: StoreOf<AudioDataFeature>
    let playerStore: StoreOf<PlayerFeature>
    
    @State private var isExpandPlayer: Bool = false
    @State private var offsetY: CGFloat = 0
    var body: some View {
        GeometryReader {
            let size = $0.size
            let miniPlayerHeight = 48
            ZStack(alignment: .top) {
                VStack {
//                    if !isExpandPlayer {
//                        MusicListComponent()
//                        MiniPlayer()
//                    }
                    MusicListComponent()
                        .opacity(isExpandPlayer ? 0 : 1)
                    MiniPlayer(height: CGFloat(isExpandPlayer ? 0 : miniPlayerHeight))
                        .opacity(isExpandPlayer ? 0 : 1)
                    if isExpandPlayer {
                        ExpandedPlayer(size: size)
                            .opacity(isExpandPlayer ? 1 : 0)
                    }
                }
            }.gesture(
                DragGesture().onChanged { value in
                    let translation = max(value.translation.height, 0)
                    offsetY = translation
                }.onEnded { value in
                    let translation = max(value.translation.height, 0)
                    let velocity = value.velocity.height / 5
                    withAnimation(.smooth(duration: 0.3, extraBounce: 0)) {
                        if (translation + velocity) > (size.height * 0.5) {
                            isExpandPlayer = false
                        }
                        offsetY = 0
                    }
                }
            )
        }
    }
    
    @ViewBuilder
    func MusicListComponent() -> some View {
        WithViewStore(self.store, observe: {$0}) { viewStore in
            VStack {
                List {
                    ForEach(viewStore.state.audioDataList) { videoData in
                        Card(title: videoData.title, urlString: videoData.url.absoluteString)
                            .swipeActions(edge: .trailing, allowsFullSwipe: false) {
                                Button(role: .destructive) {
                                    print("[Before List Size]\(viewStore.audioDataList.count)")
                                    viewStore.send(.trashButtonTapped(id: videoData.id))
                                    print("[After List Size]\(viewStore.audioDataList.count)")
                                } label: {
                                    Image(systemName: "trash")
                                }
                            }
                            .listRowSeparator(.hidden)
                            .listRowBackground(
                                RoundedRectangle(cornerRadius: 5)
                                    .stroke(.black, lineWidth: 2)
                                    .background(.clear)
                                    .foregroundStyle(.white)
                                    .padding(EdgeInsets(top: 5, leading: 10, bottom: 5, trailing: 10))
                            )
                    }
                }.listStyle(.plain)
                    .navigationTitle("Radios")
            }
        }
    }
    
    @ViewBuilder
    func MiniPlayer(height: CGFloat) -> some View {
        HStack() {
            RoundedRectangle(cornerRadius: 4)
                .fill(.blue)
                .frame(width: 36, height: 36)
            Spacer()
            Text("Title here Title here!")
                .padding(8)
            Spacer()
            Button{
                
            }label: {
                Image(systemName: "play.fill")
                    .resizable()
                    .frame(width: 24, height: 24)
            }
        }.frame(height: height, alignment: .leading)
            .padding(16)
            .background(.white)
            .shadow(radius: 4)
            .onTapGesture {
                withAnimation(.smooth(duration: 2, extraBounce: 0)) {
                    isExpandPlayer = true
                    debugPrint("isExpandPlayer: \(isExpandPlayer)")
                }
            }
    }
    
    @ViewBuilder
    func ExpandedPlayer(size: CGSize) -> some View {
        VStack {
            MainPlayerView(store: playerStore, height: size.height)
        }
    }
}

#Preview {
    RootView()
}
