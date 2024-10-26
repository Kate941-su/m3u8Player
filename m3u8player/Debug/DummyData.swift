//
//  DummyData.swift
//  m3u8player
//
//  Created by Kaito Kitaya on 03.10.24.
//

import Foundation

let demoURL = URL(string: "https://cast.crn.fm:8000/radio.mp3")!
let baseVideoName = "sample"
let baseVideoURL = "https://sample/player"
var dummyVideoDataList: [AudioData] = {getDummyVideoModel()}()

func getDummyVideoModel() -> [AudioData] {
    var tempList:[AudioData] = []
    for i in 0...10 {
        tempList.append(AudioData(title: "\(baseVideoName)\(i)",
                                  url: demoURL,
                                  type: .Streaming))
    }
    return tempList
}


