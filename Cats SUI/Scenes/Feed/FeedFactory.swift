//
//  FeedFactory.swift
//  Cats SUI
//
//  Created by Evens Taian on 06/02/25.
//

import Foundation
import SwiftUI

struct FeedFactory {
    static func makeModule() -> some View {
        let API = MockApiRequests()
        let service = FeedService(API: API)
        let coordinator = FeedCoordinator()
        let viewModel = FeedViewModel(service: service, coordinator: coordinator)
        return FeedSwiftUIView(viewModel: viewModel)
    }
}
