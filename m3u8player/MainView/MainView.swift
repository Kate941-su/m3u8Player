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
    let store: StoreOf<VideoDataFeature>
    
    init(store: StoreOf<VideoDataFeature>) {
        self.store = store
    }
    
    var body: some View {
        NavigationStack {
            WithViewStore(self.store) { viewStore in
                SubView(viewStore: viewStore)
                AddButton()
                DebugButton(viewStore: viewStore)
            }
        }
    }
}

struct SubView: View {
    let viewStore: ViewStore<VideoDataFeature.State, VideoDataFeature.Action>
    
    var body: some View {
        ZStack(alignment: .bottomTrailing) {
            VStack {
                List {
                    ForEach(viewStore.state.videoDataList) { videoData in
                        Card(title: videoData.title, urlString: videoData.url.absoluteString)
                            .swipeActions(edge: .trailing, allowsFullSwipe: false) {
                                Button(role: .destructive) {
                                    print("[Before List Size]\(viewStore.videoDataList.count)")
                                    viewStore.send(.trashButtonTapped(id: videoData.id))
                                    print("[After List Size]\(viewStore.videoDataList.count)")
                                } label: {
                                    Image(systemName: "trash")
                                }
                            }
                            .listRowSeparator(.hidden)
                            .listRowBackground(
                                RoundedRectangle(cornerRadius: 5)
                                    .stroke(.black, lineWidth: 2)  // Adds a blue border with 2 points thickness
                                    .background(.clear)
                                    .foregroundStyle(.white)
                                    .padding(EdgeInsets(top: 5,
                                                        leading: 10,
                                                        bottom: 5,
                                                        trailing: 10))
                            )
                    }
                }.listStyle(.plain)
                    .navigationTitle("Radios")
                    .navigationDestination(for: UUID.self) { value in
                        EditView(
                            videoFeatureStore: Store(initialState: VideoDataFeature.State()) {
                                VideoDataFeature()
                            }
                        )
                    }
            }
            
            
        }
    }
}

struct AddButton: View {
    var body: some View {
        NavigationLink(
            destination: AddView(
                store: Store(initialState: VideoDataFeature.State(),
                             reducer: {VideoDataFeature()}))) {
                                 Image(systemName: "plus")
                                     .padding()
                                     .foregroundStyle(.white)
                                     .background(.blue)
                                     .clipShape(.circle)
                             }.offset(x: -25, y: -10)
    }
}

struct DebugButton: View {
    
    let viewStore: ViewStore<VideoDataFeature.State, VideoDataFeature.Action>
    
    var body: some View {
        Button {
            viewStore.state.videoDataList.forEach {
                print($0)
            }
        }label: {
            Image(systemName: "eye")
                .padding()
                .foregroundStyle(.white)
                .background(.red)
                .clipShape(.circle)
        }.offset(x: -50, y: -50)
    }
}

#Preview {
    AddButton()
}



#Preview {
    MainView(store: Store(initialState: VideoDataFeature.State(),
                          reducer: {VideoDataFeature()}))
}
