//
//  NameJarApp.swift
//  NameJar
//
//  Created by Kari Groszewska on 1/11/25.
//

import SwiftUI
import SwiftData

@main
struct NameJarApp: App {
    var sharedModelContainer: ModelContainer = {
        let schema = Schema([
            NameList.self,
        ])
        let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)

        do {
            return try ModelContainer(for: schema, configurations: [modelConfiguration])
        } catch {
            fatalError("Could not create ModelContainer: \(error)")
        }
    }()

    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(sharedModelContainer)
        .modelContext(ModelContext(sharedModelContainer))
    }
}
