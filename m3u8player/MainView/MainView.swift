//
//  ContentView.swift
//  m3u8player
//
//  Created by Kaito Kitaya on 03.10.24.
//

import SwiftUI

struct MainView: View {
    
    @State private var cardList: [VideoData] = dummyVideoDataList
    @State private var showAlert = false
    
    var body: some View {
        ZStack(alignment: .bottomTrailing) {
            Button{
                print("Hello World")
            }label: {
                    Image(systemName: "plus")
                    .padding()
                    .foregroundStyle(.white)
                    .background(.blue)
                    .clipShape(.circle)
            }.offset(x: -25, y: -10)
            VStack {
                Text("Title")
                List {
                    ForEach(cardList) { videoData in
                        NavigationLink(destination: PlayerView()) {
                            Card(title: videoData.title, urlString: videoData.url.absoluteString)
                                .swipeActions(edge: .trailing, allowsFullSwipe: false) {
                                    Button(role: .destructive) {
                                        print("Hello")
                                        showAlert = true
                                    } label: {
                                        Image(systemName: "trash")
                                    }.alert(isPresented: $showAlert) {
                                        Alert(
                                            title: Text("Confirm"),
                                            message: Text("Are you sure to delete this itme?"),
                                            primaryButton: .default(
                                                Text("Yes"),
                                                action: {print("execute delete")}
                                            ),
                                            secondaryButton: .destructive(
                                                Text("No"),
                                                action: {print("do nothing")}
                                            )
                                        )
                                    }
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
                    .navigationTitle("List of your registered radios")
                    .toolbar {
                        Button {
                            cardList.append(VideoData(title: "appended!", url: URL(string: "appended!")!))
                        } label: {
                            Image(systemName: "plus")
                        }
                    }
            }
        }

    }
}

#Preview {
    MainView()
}
