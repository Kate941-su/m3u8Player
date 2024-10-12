//
//  EditView.swift
//  m3u8player
//
//  Created by Kaito Kitaya on 05.10.24.
//

import Foundation
import SwiftUI
import ComposableArchitecture

struct EditView: View {
    @State private var title: String = ""
    @State private var url: String = ""
    @State private var isAddAlertShown = false
    @State private var isDiscardAlertShown = false
    
    let videoFeatureStore: StoreOf<VideoDataFeature>
    
    init(videoFeatureStore: StoreOf<VideoDataFeature>) {
        self.videoFeatureStore = videoFeatureStore
    }
    
    var body: some View {
        NavigationStack {
            VStack(alignment: .leading) {
                Text("Edit")
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
        }
    }
}

#Preview {
    EditView(videoFeatureStore: Store(initialState: VideoDataFeature.State(),
                                      reducer: {VideoDataFeature()}))
}
