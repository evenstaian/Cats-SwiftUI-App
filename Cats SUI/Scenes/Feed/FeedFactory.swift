//
//  FeedFactory.swift
//  Cats SUI
//
//  Created by Evens Taian on 06/02/25.
//

import Foundation
import SwiftUI

enum FeedFactory {
    static func makeModule() -> some View {
        let viewModel = FeedViewModel()
        let controller = FeedSwiftUIView(viewModel: viewModel)
        return controller
    }

}
