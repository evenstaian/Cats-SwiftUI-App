//
//  HeaderComponent.swift
//  Cats SUI
//
//  Created by Evens Taian on 06/02/25.
//

import SwiftUI

struct HeaderComponent: View {
    var body: some View {
        VStack(spacing: 4) {
            HStack {
                Image(systemName: "pawprint.fill")
                    .font(.title2)
                Text("Cats Images")
                    .font(.title2.bold())
            }
            Text("Discover Adorable Feline Companions")
                .font(.subheadline)
        }
        .foregroundColor(.white)
        .padding(.vertical, 12)
        .frame(maxWidth: .infinity)
        .background {
            Rectangle()
                .fill(Color.black)
                .ignoresSafeArea()
        }
    }
}

#Preview {
    HeaderComponent()
}
