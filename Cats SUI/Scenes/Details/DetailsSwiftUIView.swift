//
//  DetailsSwiftUIView.swift
//  Cats SUI
//
//  Created by Evens Taian on 06/02/25.
//

import SwiftUI

struct DetailsSwiftUIView<VM>: View where VM: DetailsViewmodeling {
    
    @ObservedObject private var viewModel: VM
        
    init(viewModel: VM){
        self.viewModel = viewModel
    }
    
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

#Preview {
    DetailsFactory.makeModule(id: "1")
}
