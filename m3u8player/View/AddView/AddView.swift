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
    
    let store: StoreOf<AudioDataFeature>
    
    init(store: StoreOf<AudioDataFeature>) {
        self.store = store
    }
    
    var body: some View {
        NavigationStack {
            WithViewStore(store, observe: {$0}) { viewStore in
#if DEBUG
                Text("List Num: \(viewStore.audioDataList.count)")
#endif

                VStack(alignment: .leading) {
                    Text("Add")
                        .fontWeight(.bold)
                        .font(.system(size: 36))
                        .padding(.bottom)
                    Text("Title")
                        .fontWeight(.bold)
                    TextField("Title", text: $title)
                        .padding(.bottom)
                        .textFieldStyle(.roundedBorder)
                    Text("URL")
                        .fontWeight(.bold)
                    TextField("URL", text: $url)
                        .textFieldStyle(.roundedBorder)
                }.frame(maxWidth: .infinity, alignment: .leading)
                    .padding(32)
                HStack {
                    Button {
                        print("[URL] \(url)")
                        isAddAlertShown = true
                        if let strongURL = URL(string: url),
                           UIApplication.shared.canOpenURL(strongURL) {
                            if title.isEmpty {
                                title = "No Title"
                            }
                            addViewAlert = .valid
                            store.send(.addButtonTapped(data: AudioData(
                                                                title: title,
                                                                url: strongURL,
                                                                type: .Streaming
                            )))
                            title = ""
                            url = ""
                        } else {
                            addViewAlert = .invalid
                            return
                        }
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
}

#Preview {
    AddView(
        store: Store(initialState: AudioDataFeature.State(),reducer: {AudioDataFeature()}))
}
