//
//  RSI_GeneratorApp.swift
//  RSI Generator
//
//  Created by Tim Randall on 24/4/22.
//

import SwiftUI

@main
struct RSI_GeneratorApp: App {
    @StateObject var viewRouter = ViewRouter()
    var body: some Scene {
        WindowGroup {
            GameView()
        }
    }
}

class ViewRouter: ObservableObject {
    @Published var view: Int = 0
}
