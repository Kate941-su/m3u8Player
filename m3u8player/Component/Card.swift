//
//  Card.swift
//  m3u8player
//
//  Created by Kaito Kitaya on 03.10.24.
//

import Foundation
import SwiftUI

struct Card: View {
    let title: String
    let urlString: String
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(title)
                .foregroundStyle(.red)
                .font(.system(size: 36))
                .font(.headline)
            Text(urlString)
                .foregroundStyle(.gray)
                .font(.system(size: 18))
   }
        .frame(
            maxWidth: .infinity,
            maxHeight: 36,
            alignment: .leading)
        .padding(EdgeInsets(
                top: 25,
                leading: 5,
                bottom: 25,
                trailing: 5
        ))
    }
}

#Preview {
    Card(title: "Kaito Kitaya", urlString: "https://sample.com")
}
