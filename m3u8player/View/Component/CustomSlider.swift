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
    let candidate: FrequencyCandidates
    
    @State private var sliderValue: Double = 0
    
    init(store: StoreOf<PlayerFeature>, candidate: FrequencyCandidates) {
        self.store = store
        self.candidate = candidate
    }
    
    var body: some View {
        WithViewStore(self.store, observe: {$0}) { viewStore in
            VStack{
                Slider(value: $sliderValue, in: -12...12)
                    .rotationEffect(.degrees(-90))
                    .frame(width: 120, height: 20)
                    .padding(EdgeInsets(top: 50, leading: 0, bottom: 50, trailing: 0))
                    .padding(EdgeInsets(top: 50, leading: 0, bottom: 50, trailing: 0))
                    .scaleEffect(x: 1.0, y: 1.0, anchor: .center)
                Text(candidate.label).fontWeight(.bold).frame(width: 50)
            }.frame(width: 30).onChange(of: sliderValue) {
                switch candidate {
                case .gain60(_):
                    viewStore.send(.changeSliderValue(.gain60(sliderValue)))
                case .gain170(_):
                    viewStore.send(.changeSliderValue(.gain170(sliderValue)))
                case .gain310(let double):
                    viewStore.send(.changeSliderValue(.gain310(sliderValue)))
                case .gain600(let double):
                    viewStore.send(.changeSliderValue(.gain600(sliderValue)))
                case .gain1k(let double):
                    viewStore.send(.changeSliderValue(.gain1k(sliderValue)))
                case .gain3k(let double):
                    viewStore.send(.changeSliderValue(.gain3k(sliderValue)))
                case .gain6k(let double):
                    viewStore.send(.changeSliderValue(.gain6k(sliderValue)))
                case .gain12k(let double):
                    viewStore.send(.changeSliderValue(.gain12k(sliderValue)))
                }
            }
        }
    }
}

#Preview {
    CustomSlider(store: Store(initialState: PlayerFeature.State()){}, candidate: .gain1k(0))
}
