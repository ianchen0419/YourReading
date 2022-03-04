//
//  YourReadingApp.swift
//  YourReading
//
//  Created by Yi An Chen on 2022/2/20.
//

import SwiftUI

@main
struct YourReadingApp: App {
    @StateObject private var dataController = DataController()
    
    var body: some Scene {
        WindowGroup {
            AppView()
                .environment(\.managedObjectContext, dataController.container.viewContext)
        }
    }
}
