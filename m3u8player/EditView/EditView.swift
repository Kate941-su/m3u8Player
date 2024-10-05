//
//  EditView.swift
//  m3u8player
//
//  Created by Kaito Kitaya on 05.10.24.
//

import Foundation
import SwiftUI

struct EditView: View {
    
    private let itemNumber: Int
    
    init(itemNumber: Int) {
        self.itemNumber = itemNumber
    }
    
    var body: some View {
        VStack {
            Text("Item Number is \(itemNumber)")
        }
    }
}

#Preview {
    EditView(itemNumber: 1)
}
