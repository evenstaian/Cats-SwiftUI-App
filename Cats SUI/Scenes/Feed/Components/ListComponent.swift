//
//  ListComponent.swift
//  Cats SUI
//
//  Created by Evens Taian on 06/02/25.
//

import SwiftUI

struct ListComponent: View {
    let feedData: [FeedData]
    let onTapDetails: (FeedData) -> Void
    let onRefresh: () -> Void
    let onLoadMore: () -> Void
    let isLoadingMore: Bool
    
    @State private var isRefreshing = false
    
    var body: some View {
        ScrollView(showsIndicators: false) {
            RefreshableView(
                coordinateSpaceName: "pullToRefresh",
                onRefresh: { progress in
                    onRefresh()
                },
                refreshingView: {
                    PawPrintView(progress: $0)
                        .frame(height: 50)
                }
            ) {
                LazyVStack(spacing: 24) {
                    ForEach(feedData) { item in
                        FeedItemView(feedData: item) {
                            onTapDetails(item)
                        }
                        .onAppear {
                            if item.id == feedData.last?.id {
                                onLoadMore()
                            }
                        }
                    }
                    
                    if isLoadingMore {
                        LoadingMoreView()
                    }
                }
                .padding(.horizontal)
                .padding(.top, 16)
            }
        }
        .coordinateSpace(name: "pullToRefresh")
        .background(Color(.systemGroupedBackground))
    }
}

struct RefreshableView<Content: View, RefreshContent: View>: View {
    let coordinateSpaceName: String
    let onRefresh: (CGFloat) -> Void
    let refreshingView: (CGFloat) -> RefreshContent
    let content: Content
    
    @State private var refreshState = RefreshState.waiting
    @State private var progress: CGFloat = 0
    
    init(
        coordinateSpaceName: String,
        onRefresh: @escaping (CGFloat) -> Void,
        refreshingView: @escaping (CGFloat) -> RefreshContent,
        @ViewBuilder content: () -> Content
    ) {
        self.coordinateSpaceName = coordinateSpaceName
        self.onRefresh = onRefresh
        self.refreshingView = refreshingView
        self.content = content()
    }
    
    var body: some View {
        VStack(spacing: 0) {
            GeometryReader { geo in
                Color.clear
                    .onChange(of: geo.frame(in: .named(coordinateSpaceName)).minY) { value in
                        handleScroll(value)
                    }
            }
            .frame(height: 0)
            
            refreshingView(progress)
                .opacity(progress)
                .frame(height: 50 * progress)
            
            content
        }
    }
    
    private func handleScroll(_ scrollOffset: CGFloat) {
        let threshold: CGFloat = 50
        
        switch refreshState {
        case .waiting:
            progress = min(max(scrollOffset / threshold, 0), 1)
            if scrollOffset > threshold {
                refreshState = .primed
            }
        case .primed:
            if scrollOffset < threshold {
                refreshState = .refreshing
                progress = 1
                Task {
                    onRefresh(progress)
                    refreshState = .waiting
                    withAnimation {
                        progress = 0
                    }
                }
            }
        case .refreshing:
            break
        }
    }
    
    private enum RefreshState {
        case waiting
        case primed
        case refreshing
    }
}

private struct FeedItemView: View {
    let feedData: FeedData
    let onTapDetails: () -> Void
    @State private var isLiked = false
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            AsyncImage(url: URL(string: feedData.url)) { image in
                image
                    .resizable()
                    .aspectRatio(contentMode: .fit)
            } placeholder: {
                ProgressView()
                    .frame(height: 300)
                    .frame(maxWidth: .infinity)
                    .background(Color.gray.opacity(0.1))
            }
            .clipShape(RoundedRectangle(cornerRadius: 16))
            
            HStack(spacing: 16) {
                Button(action: {
                    withAnimation(.spring(response: 0.3, dampingFraction: 0.6)) {
                        isLiked.toggle()
                    }
                }) {
                    Image(systemName: isLiked ? "heart.fill" : "heart")
                        .foregroundColor(isLiked ? .red : .primary)
                        .font(.title2)
                        .symbolEffect(.bounce, value: isLiked)
                }
                
                Button(action: onTapDetails) {
                    HStack(spacing: 4) {
                        Text("See details")
                            .fontWeight(.medium)
                        Image(systemName: "chevron.right")
                            .font(.caption.bold())
                    }
                    .foregroundColor(.blue)
                    .padding(.horizontal, 12)
                    .padding(.vertical, 6)
                    .background(
                        Capsule()
                            .fill(Color.blue.opacity(0.1))
                    )
                }
                
                Spacer()
            }
            .padding(.horizontal, 8)
            .padding(.bottom, 8)
        }
        .background(
            RoundedRectangle(cornerRadius: 20)
                .fill(Color(.systemBackground))
                .shadow(color: .black.opacity(0.1), radius: 10, x: 0, y: 2)
        )
        .padding(.horizontal)
    }
}
