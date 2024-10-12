//
//  BottomNavigationTabItem.swift
//  m3u8player
//
//  Created by Kaito Kitaya on 12.10.24.
//
enum AppTabItem: String, CaseIterable {
    case Home = "house"
    case Add = "plus.circle"
    case Search = "magnifyingglass"
    case Settings = "gearshape"
    case DebugPlayer = "music.note"
    
    var tabName: String {
        switch self {
        case .Home:
            return "Home"
        case .Search:
            return "Search"
        case .Settings:
            return "Settings"
        case .Add:
            return "Add"
        case .DebugPlayer:
            return "Player"
        }
    }
}
