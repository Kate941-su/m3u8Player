//
//  AudioData.swift
//  m3u8player
//
//  Created by Kaito Kitaya on 03.10.24.
//

import Foundation

struct AudioData: Identifiable, Equatable {
    let id = UUID()
    let title: String
    let url: URL
    let type: AudioType
}

enum AudioType {
    case Static
    case Streaming
}
