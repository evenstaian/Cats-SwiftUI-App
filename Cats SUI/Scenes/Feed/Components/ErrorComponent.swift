//
//  ErrorComponent.swift
//  Cats SUI
//
//  Created by Evens Taian on 06/02/25.
//

import SwiftUI

struct ErrorView: View {
    let message: String
    let onDismiss: () -> Void
    
    var body: some View {
        VStack(spacing: 16) {
            Image(systemName: "exclamationmark.triangle.fill")
                .font(.system(size: 50))
                .foregroundColor(.red)
            
            Text(message)
                .multilineTextAlignment(.center)
                .foregroundColor(.gray)
            
            Button(action: onDismiss) {
                Text("Dismiss")
                    .foregroundColor(.white)
                    .padding(.horizontal, 24)
                    .padding(.vertical, 12)
                    .background(Color.blue)
                    .cornerRadius(8)
            }
        }
        .padding(24)
        .background(Color.white)
        .cornerRadius(16)
        .shadow(radius: 8)
        .padding(24)
    }
} 