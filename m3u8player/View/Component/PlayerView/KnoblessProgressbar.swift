//
//  KnoblessProgressbar.swift
//  m3u8player
//
//  Created by Kaito Kitaya on 26.10.24.
//

import Foundation
import SwiftUI

struct KnoblessProgressbar: View {
        @Binding var percentage: Float // or some value binded
        let height: CGFloat?
    
    init(percentage: Binding<Float>, height: CGFloat? = nil) {
        self._percentage = percentage
        self.height = height
    }
    
        var body: some View {
            GeometryReader { geometry in
                // TODO: - there might be a need for horizontal and vertical alignments
                ZStack(alignment: .leading) {
                    Rectangle()
                        .foregroundColor(.gray)
                    Rectangle()
                        .foregroundColor(.accentColor)
                        .frame(width: geometry.size.width * CGFloat(self.percentage / 100))
                }
                .cornerRadius(12)
                .gesture(DragGesture(minimumDistance: 0)
                    .onChanged({ value in
                        // TODO: - maybe use other logic here
                        self.percentage = min(max(0, Float(value.location.x / geometry.size.width * 100)), 100)
                    }))
            }.frame(height: height)
        }
}
