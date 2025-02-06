//
//  FeedSwiftUIView.swift
//  Cats SUI
//
//  Created by Evens Taian on 06/02/25.
//

import SwiftUI

struct FeedSwiftUIView<VM>: View where VM: FeedViewmodeling {
    
    @ObservedObject private var viewModel: VM
        
    init(viewModel: VM){
        self.viewModel = viewModel
    }
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 0) {
                HeaderComponent()
                
                ListComponent(
                    feedData: viewModel.feedData,
                    onTapDetails: viewModel.goToDetails,
                    onRefresh: {
                        await viewModel.refresh()
                    }
                )
            }
            .navigationBarHidden(true)
        }
    }
}

#Preview {
    FeedFactory.makeModule()
}
