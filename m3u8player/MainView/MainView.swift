//
//  ContentView.swift
//  m3u8player
//
//  Created by Kaito Kitaya on 03.10.24.
//

import SwiftUI
import ComposableArchitecture

struct MainView: View {
    
    @State private var cardList: [VideoData] = dummyVideoDataList
    @State private var showAlert = false
    
    var body: some View {
        NavigationStack {
            ZStack(alignment: .bottomTrailing) {
                VStack {
                    List {
                        ForEach(cardList) { videoData in
                            Card(title: videoData.title, urlString: videoData.url.absoluteString)
                                .swipeActions(edge: .trailing, allowsFullSwipe: false) {
                                    Button(role: .destructive) {
                                        print("[Before List Size]\(cardList.count)")
                                        cardList.removeAll(where: { $0.id == videoData.id })
                                        print("[After List Size]\(cardList.count)")
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
                                editStore: Store(initialState: EditFeature.State()) {
                                    EditFeature()
                                }
                            )
                        }
                }
                NavigationLink(
                    destination: AddView(
                        addStore: Store(initialState: VideoDataFeature.State(),
                                         reducer: {VideoDataFeature()}))) {
                                             Image(systemName: "plus")
                                                 .padding()
                                                 .foregroundStyle(.white)
                                                 .background(.blue)
                                                 .clipShape(.circle)
                                         }.offset(x: -25, y: -10)
            }
        }
    }
}

#Preview {
    MainView()
}
