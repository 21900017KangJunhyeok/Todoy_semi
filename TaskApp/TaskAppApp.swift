//
//  TaskAppApp.swift
//  TaskApp
//
//  Created by junhyeok KANG on 2023/02/01.
//

import SwiftUI

@main
struct TaskAppApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
