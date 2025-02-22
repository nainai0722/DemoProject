//
//  MigrateRealmDB.swift
//  DemoProject
//
//  Created by 指原奈々 on 2025/02/19.
//

import RealmSwift
import Foundation

struct MigrateRealmDB {
    func migrateRealmDB(schemaVersion: UInt64) {
        let config = Realm.Configuration(
            schemaVersion: schemaVersion,
            migrationBlock: { migration, oldSchemaVersion in
                print("⚡ Realm migration started: oldSchemaVersion = \(oldSchemaVersion)")
                if oldSchemaVersion < 2 {
                    migration.enumerateObjects(ofType: RealmQuiz.className()) { oldObject, newObject in
                        print("🔄 Migrating object: \(oldObject)")
                        newObject?["quizType"] = QuizType.defaultQuiz.rawValue
                        newObject?["imageName"] = ""
                    }
                }
                if oldSchemaVersion < 3 {
                // 追加したDefaultQuizCategoryは特にmigration処理は不要
                    print("🔄 Migrating")
                }
            },
            deleteRealmIfMigrationNeeded: true // ★ 追加
        )

        Realm.Configuration.defaultConfiguration = config

        do {
            let realm = try Realm()
            print("✅ Realm initialized: \(realm.configuration.fileURL!)")
        } catch {
            print("❌ Realm initialization failed: \(error.localizedDescription)")
        }
    }
}
