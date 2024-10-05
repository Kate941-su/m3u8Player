//
//  DummyData.swift
//  m3u8player
//
//  Created by Kaito Kitaya on 03.10.24.
//

import Foundation

let baseVideoName = "sample"
let baseVideoURL = "https://sample/player"
var dummyVideoDataList: [VideoData] = {getDummyVideoModel()}()

func getDummyVideoModel() -> [VideoData] {
    var tempList:[VideoData] = []
    for i in 0...10 {
        tempList.append(VideoData(title: "\(baseVideoName)\(i)",
                                  url: URL(string: "\(baseVideoURL)/\(i)")!))
    }
    return tempList
}


