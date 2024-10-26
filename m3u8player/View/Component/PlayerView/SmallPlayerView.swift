//
//  SmallPlayerView.swift
//  m3u8player
//
//  Created by Kaito Kitaya on 26.10.24.
//

import Foundation
import SwiftUI

struct SmallPlayerView: View {
    
    var body: some View {
        HStack() {
            RoundedRectangle(cornerRadius: 4)
                .fill(.blue)
                .frame(width: 56, height: 56)
            Spacer()
            Text("Title here Title here!")
                .padding(8)
            Spacer()
            Button{
                
            }label: {
                Image(systemName: "play.fill")
                    .resizable()
                    .frame(width: 24, height: 24)
            }
        }.frame(width: .infinity, height: 64, alignment: .leading)
         .padding(16)
         .background(.white)
    }
}

#Preview {
    SmallPlayerView()
}
