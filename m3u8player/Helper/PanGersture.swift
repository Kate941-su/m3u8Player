//
//  PanGersture.swift
//  m3u8player
//
//  Created by Kaito Kitaya on 27.10.24.
//

import SwiftUI

struct PanGersture: UIGestureRecognizerRepresentable {
    
    var onChange: (Value) -> ()
    var onEnd: (Value) -> ()
    
    func makeUIGestureRecognizer(context: Context) -> UIGestureRecognizer {
        let gesture = UIPanGestureRecognizer()
        return gesture
    }
    
    func updateUIGestureRecognizer(_ recognizer: UIGestureRecognizerType, context: Context) {
        
    }
    
    func handleUIGestureRecognizerAction(_ recognizer: UIPanGestureRecognizer, context: Context) {
        debugPrint("Gesture detected!")
        let state = recognizer.state
        let translation = recognizer.translation(in: recognizer.view).toSize()
        let velocity = recognizer.velocity(in: recognizer.view).toSize()
        let value = Value(translation: translation, velocity: velocity)
        if state == .began || state == .changed {
            onChange(value)
        } else {
            onEnd(value)
        }
    }
    
    struct Value {
        var translation: CGSize
        var velocity: CGSize
    }
}

extension CGPoint {
    func toSize() -> CGSize {
        return .init(width: x, height: y)
    }
}
