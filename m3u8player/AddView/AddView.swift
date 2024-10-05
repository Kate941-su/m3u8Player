//
//  AddView.swift
//  m3u8player
//
//  Created by Kaito Kitaya on 05.10.24.
//

import Foundation
import SwiftUI
import ComposableArchitecture

struct AddView: View {
    @State private var title: String = ""
    @State private var url: String = ""
    @State private var isAddAlertShown = false
    @State private var isDiscardAlertShown = false
    
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
                    print("add")
                    isAddAlertShown = true
                    addStore.send(.addButtonTapped(data: VideoData(title: title, url: URL(string: url)!)))
                    title = ""
                    url = ""
                }label: {
                    Text("Add")
                }.padding(16)
                    .alert(isPresented: $isAddAlertShown) {
                        Alert(title: Text("Added"), message: Text("Succeeded to add the item 👍🏼"))
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
