//
//  RealmQuizCategoryListModel.swift
//  DemoProject
//
//  Created by 指原奈々 on 2025/01/29.
//

import Foundation
import SwiftUI
import Combine
import RealmSwift

final class RealmQuizCategoryListModel: ObservableObject {
    @Published var categories: [RealmQuizCategory] = []
    
    func fetch() {
        //RealmQuizCategoryのデータが取れたら、categoriesに格納する
        do {
            let realm = try Realm()
            let results = realm.objects(RealmQuizCategory.self)
            categories = Array(results) // 取得したデータを配列に変換
            if categories.isEmpty {
                RealmQuizRepository().initializeDefaultCategoriesIfNeeded()
            }
        } catch {
            print("Realmのデータ取得に失敗: \(error.localizedDescription)")
        }
    }
}
