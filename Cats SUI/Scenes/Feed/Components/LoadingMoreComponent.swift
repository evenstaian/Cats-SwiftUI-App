//
//  LoadingMoreComponent.swift
//  Cats SUI
//
//  Created by Evens Taian on 06/02/25.
//

import SwiftUI

struct LoadingMoreView: View {
    var body: some View {
        HStack(spacing: 8) {
            ProgressView()
                .progressViewStyle(CircularProgressViewStyle())
            Text("Fetching more kitties...")
                .foregroundColor(.gray)
        }
        .frame(maxWidth: .infinity)
        .padding()
    }
} 