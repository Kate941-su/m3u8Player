//
//  m3u8playerApp.swift
//  m3u8player
//
//  Created by Kaito Kitaya on 03.10.24.
//

import SwiftUI
import ComposableArchitecture

@main
struct m3u8playerApp: App {
    let videoDataReducer = VideoDataFeature()
    let videoDataStore = Store(initialState: VideoDataFeature.State(),
                               reducer: {VideoDataFeature()})
    var body: some Scene {
        WindowGroup {
            MainView(store: videoDataStore)
        }
    }
}
