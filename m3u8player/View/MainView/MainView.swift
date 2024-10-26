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
    
    init(store: StoreOf<AudioDataFeature>) {
        self.store = store
    }
    
    var body: some View {
        WithViewStore(self.store, observe: {$0}) { viewStore in
            Text("List Num: \(viewStore.audioDataList.count)")
            VStack {
                SubView(store: store, viewStore: viewStore)
            }
        }
    }
}

struct SubView: View {
    
    let store: StoreOf<AudioDataFeature>
    let viewStore: ViewStore<AudioDataFeature.State, AudioDataFeature.Action>
    
    var body: some View {
        NavigationStack {
            ZStack(alignment: .bottomTrailing) {
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
                        SmallPlayerView()
                    }
            }
        }
    }
}

struct AddButton: View {
    let store: StoreOf<AudioDataFeature>
    var body: some View {
        NavigationLink(
            destination: AddView(store: store)) {
                Image(systemName: "plus")
                    .padding()
                    .foregroundStyle(.white)
                    .background(.blue)
                    .clipShape(.circle)
            }.offset(x: -5, y: -5)
    }
}

struct DebugButton: View {
    let viewStore: ViewStore<AudioDataFeature.State, AudioDataFeature.Action>
    
    var body: some View {
        Button {
            viewStore.state.audioDataList.forEach {
                print($0)
            }
        } label: {
            Image(systemName: "eye")
                .padding()
                .foregroundStyle(.white)
                .background(.red)
                .clipShape(.circle)
        }.offset(x: -50, y: -50)
    }
}

#Preview {
    MainView(store:Store(initialState: AudioDataFeature.State(),
                         reducer: {AudioDataFeature()}))
}
