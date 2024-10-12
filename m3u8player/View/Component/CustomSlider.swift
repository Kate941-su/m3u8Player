//
//  CustomSlider.swift
//  m3u8player
//
//  Created by Kaito Kitaya on 12.10.24.
//

import Foundation
import SwiftUI
import ComposableArchitecture

struct CustomSlider : View {
    let store: StoreOf<PlayerFeature>
    let frequency: Int
    
    @State private var sliderValue: Double = 0
    
    init(store: StoreOf<PlayerFeature>, frequency: Int) {
        self.store = store
        self.frequency = frequency
    }
    
    var body: some View {
        WithViewStore(self.store, observe: {$0}) { viewStore in
            VStack{
                
//#if DEBUG
//                Text("\(sliderValue)")
//#endif
                Slider(value: $sliderValue, in: -12...12)
                    .rotationEffect(.degrees(-90))
                    .frame(width: 120, height: 20)
                    .padding(EdgeInsets(top: 50, leading: 0, bottom: 50, trailing: 0))
                    .padding(EdgeInsets(top: 50, leading: 0, bottom: 50, trailing: 0))
                    .scaleEffect(x: 1.0, y: 1.0, anchor: .center)
                if frequency > 1000 {
                    Text("\(Int(frequency / 1000))K").fontWeight(.bold).frame(width: 30)
                }
            }.frame(width: 30)
        }
    }
}

#Preview {
    CustomSlider(store: Store(initialState: PlayerFeature.State()){}, frequency: 2000)
}
