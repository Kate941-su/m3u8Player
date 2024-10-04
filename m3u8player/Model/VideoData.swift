//
//  VideoData.swift
//  m3u8player
//
//  Created by Kaito Kitaya on 03.10.24.
//

import Foundation

struct VideoData: Identifiable {
    let id = UUID()
    let title: String
    let url: URL
}
