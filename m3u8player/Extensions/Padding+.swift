//
//  Padding+.swift
//  m3u8player
//
//  Created by Kaito Kitaya on 26.10.24.
//

import SwiftUI

struct PaddingOnly: ViewModifier {
    var top: CGFloat
    var leading: CGFloat
    var bottom: CGFloat
    var trailing: CGFloat
    
    func body(content: Content) -> some View {
        content.padding(EdgeInsets(top: top,
                                   leading: leading,
                                   bottom: bottom,
                                   trailing: trailing))
    }
}

extension View {
    func paddingOnly(top: CGFloat = 0, leading: CGFloat = 0, bottom: CGFloat = 0 , trailing: CGFloat = 0) -> some View {
        self.modifier(
            PaddingOnly(
                top: top,
                leading: leading,
                bottom: bottom,
                trailing: trailing))
    }
}
