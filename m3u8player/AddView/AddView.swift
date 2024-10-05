//
//  AddView.swift
//  m3u8player
//
//  Created by Kaito Kitaya on 05.10.24.
//

import Foundation
import SwiftUI
import ComposableArchitecture

enum AddViewAlertCase {
    case valid
    case invalid
}

struct AddView: View {
    @State private var title: String = ""
    @State private var url: String = ""
    @State private var isAddAlertShown = false
    @State private var isDiscardAlertShown = false
    @State private var addViewAlert = AddViewAlertCase.valid
    
    let addStore: StoreOf<VideoDataFeature>
    
    init(addStore: StoreOf<VideoDataFeature>) {
        self.addStore = addStore
    }
    
    var body: some View {
        NavigationStack {
            VStack(alignment: .leading) {
                Text("Add")
                    .fontWeight(.bold)
                    .font(.system(size: 36))
                    .padding(.bottom)
                Text("Title")
                    .fontWeight(.bold)
                TextField("Title", text: $title)
                    .padding(.bottom)
                Text("URL")
                    .fontWeight(.bold)
                TextField("URL", text: $url)
                
            }.frame(maxWidth: .infinity, alignment: .leading)
                .padding(32)
            HStack {
                Button {
                    print("[URL] \(url)")
                    isAddAlertShown = true
                    guard let validURL = URL(string: url) else {
                        addViewAlert = .invalid
                        return
                    }
                    if title.isEmpty {
                        title = "No Title"
                    }
                    addStore.send(.addButtonTapped(data: VideoData(title: title, url: validURL)))
                    title = ""
                    url = ""
                }label: {
                    Text("Add")
                }.padding(16)
                    .alert(isPresented: $isAddAlertShown) {
                        Alert(
                            title: Text("Added"),
                            message: Text( addViewAlert == .valid ? "Succeeded to add the item 👍🏼" : "Invalid URL"))
                    }
            }
        }
    }
}

#Preview {
    AddView(
        addStore: Store(initialState: VideoDataFeature.State(),
                        reducer: {VideoDataFeature()}))
}
