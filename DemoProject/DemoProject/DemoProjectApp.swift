//
//  DemoProjectApp.swift
//  DemoProject
//
//  Created by 指原奈々 on 2025/01/23.
//

import SwiftUI

@main
struct DemoProjectApp: App {
    init() {
        MigrateRealmDB().migrateRealmDB(schemaVersion: 3)
    }
    var body: some Scene {
        WindowGroup {
            TabViewIndex()
        }
    }
}
