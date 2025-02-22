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


/// DB側からクイズのデータを取得するクラス
//final class RealmQuizCategoryListModel: ObservableObject {
//    // 変更を監視する仕組みが足りない。View側での変更を監視するが、Realm側のオブジェクト変更を検知できていない。
//    @Published var categories: [QuizCategory] = []
//    
//    init() {
//        fetch()
//    }
//
//    func fetch() {
//        categories = RealmQuizRepository().getQuizCategoryArray()
//    }
//}

//import RealmSwift

final class RealmQuizCategoryListModel: ObservableObject {
    @Published var categories: [QuizCategory] = []
    
    private var notificationToken: NotificationToken?
    private var realm: Realm?
    private var results: Results<RealmQuizCategory>?

    init() {
        realm = try? Realm()
        setupObservation()
    }

    private func setupObservation() {
        guard let realm = realm else { return }
        
        results = realm.objects(RealmQuizCategory.self)
        updateCategories()
        
        // KVOを利用して変更を監視
        notificationToken = results?.observe { [weak self] _ in
            self?.updateCategories()
        }
    }

    private func updateCategories() {
        guard let results = results else { return }
        categories = QuizConverter.toQuizCategoryList(categories: results)
    }

    deinit {
        notificationToken?.invalidate()
    }
}
