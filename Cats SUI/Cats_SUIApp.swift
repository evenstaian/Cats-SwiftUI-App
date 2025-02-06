//
//  Cats_SUIApp.swift
//  Cats SUI
//
//  Created by Evens Taian on 06/02/25.
//

import SwiftUI

@main
struct Cats_SUIApp: App {
    var body: some Scene {
        WindowGroup {
            NavigationStack {
                FeedFactory.makeModule()
            }
        }
    }
}
