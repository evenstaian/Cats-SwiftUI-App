//
//  FeedSwiftUIView.swift
//  Cats SUI
//
//  Created by Evens Taian on 06/02/25.
//

import SwiftUI

struct FeedSwiftUIView<VM>: View where VM: FeedViewmodeling {
    
    @ObservedObject private var viewModel: VM
    @State private var selectedFeedData: FeedData?
        
    init(viewModel: VM){
        self.viewModel = viewModel
    }
    
    var body: some View {
        NavigationStack {
            ZStack {
                VStack(spacing: 0) {
                    HeaderComponent()
                    
                    ListComponent(
                        feedData: viewModel.feedData,
                        onTapDetails: { feedData in
                            selectedFeedData = feedData
                        },
                        onRefresh: {
                            viewModel.refresh()
                        },
                        onLoadMore: {
                            viewModel.loadMore()
                        },
                        isLoadingMore: viewModel.isLoadingMore
                    )
                    .accessibilityIdentifier("FeedList")
                }
                
                if viewModel.isLoading {
                    LoaderView()
                        .accessibilityIdentifier("LoaderView")
                }
                
                if let errorMessage = viewModel.errorMessage {
                    Color.black.opacity(0.4)
                        .ignoresSafeArea()
                    
                    ErrorView(
                        message: errorMessage,
                        onDismiss: viewModel.dismissError
                    )
                    .accessibilityIdentifier("ErrorView")
                }
            }
            .navigationBarHidden(true)
            .navigationDestination(item: $selectedFeedData) { feedData in
                viewModel.goToDetails(feedData: feedData)
                    .accessibilityIdentifier("DetailsView")
            }
        }
    }
}

#Preview {
    FeedFactory.makeModule()
}
