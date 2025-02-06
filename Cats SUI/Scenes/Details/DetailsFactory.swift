//
//  DetailsFactory.swift
//  Cats SUI
//
//  Created by Evens Taian on 06/02/25.
//

import Foundation
import SwiftUI

enum DetailsFactory {
    static func makeModule(id: String) -> some View {
        let API = MockApiRequests()
        let service = DetailsService(API: API)
        let viewModel = DetailsViewModel(id: id, service: service)
        let controller = DetailsSwiftUIView(viewModel: viewModel)
        return controller
    }
}
