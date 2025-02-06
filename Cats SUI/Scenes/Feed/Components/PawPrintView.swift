//
//  ListComponent.swift
//  Cats SUI
//
//  Created by Evens Taian on 06/02/25.
//

import SwiftUI

struct PawPrintView: View {
    let progress: CGFloat
    
    var body: some View {
        Image(systemName: "pawprint.fill")
            .font(.system(size: 40))
            .foregroundColor(.black)
            .rotationEffect(.degrees(progress * 360))
            .scaleEffect(progress)
            .opacity(progress)
    }
}

#Preview {
    PawPrintView(progress: 1.0)
} 
