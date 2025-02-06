//
//  DetailsFactory.swift
//  Cats SUI
//
//  Created by Evens Taian on 06/02/25.
//

import Foundation
import SwiftUI

enum DetailsFactory {
    static func makeModule() -> Void {
        let API = MockApiRequests()
        let service = DetailsService(API: API)
    }
}
