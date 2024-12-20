//
//  RootView.swift
//  m3u8player
//
//  Created by Kaito Kitaya on 12.10.24.
//

import SwiftUI
import ComposableArchitecture

struct RootView : View {
    let videoDataStore = Store(initialState: AudioDataFeature.State()) {
        AudioDataFeature()
    }
    
    let playerStore = Store(initialState: PlayerFeature.State()) {
        PlayerFeature(networkRepository: NetworkRepositoryImpl())
    }
    var body: some View {
        if #available(iOS 18.0, *) {
            TabView {
                Tab(AppTabItem.Home.tabName, systemImage: AppTabItem.Home.rawValue) {
                    MainView(store: videoDataStore, playerStore: playerStore)
                }
                Tab(AppTabItem.Add.tabName, systemImage: AppTabItem.Add.rawValue) {
                    AddView(store: videoDataStore)
                }
                Tab(AppTabItem.Search.tabName, systemImage: AppTabItem.Search.rawValue) {
                    PlaceholderView()
                }
                Tab(AppTabItem.Settings.tabName, systemImage: AppTabItem.Settings.rawValue) {
                    PlaceholderView()
                }
#if DEBUG
                Tab(AppTabItem.DebugPlayer.tabName, systemImage: AppTabItem.DebugPlayer.rawValue) {
                    PlayerView(store: playerStore)
                }
#endif
            }
            // TODO: Deprecated from iOS 18.0
        } else {
            TabView{
                MainView(store: videoDataStore, playerStore: playerStore).tabItem{
                    Label(AppTabItem.Home.tabName, systemImage: AppTabItem.Home.rawValue)
                }
                AddView(store: videoDataStore).tabItem{
                    Label(AppTabItem.Add.tabName, systemImage: AppTabItem.Add.rawValue)
                }
                PlaceholderView().tabItem{
                    Label(AppTabItem.Search.tabName, systemImage: AppTabItem.Search.rawValue)
                }
                PlaceholderView().tabItem{
                    Label(AppTabItem.Settings.tabName, systemImage: AppTabItem.Settings.rawValue)
                }
#if DEBUG
                PlayerView(store: playerStore).tabItem{
                    Label(AppTabItem.DebugPlayer.tabName, systemImage: AppTabItem.DebugPlayer.rawValue)
                }
#endif
            }

        }
    }
}

#Preview {
    RootView()
}
