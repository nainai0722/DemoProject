//
//  RealmQuizCategory.swift
//  DemoProject
//
//  Created by 指原奈々 on 2025/01/29.
//

import Foundation
import RealmSwift

class RealmQuizCategory: Object, Identifiable {
    @Persisted(primaryKey: true) var id: Int
    @Persisted var title: String
    @Persisted var starCount: Int
    @Persisted var quizItems: RealmSwift.List<RealmQuiz>
    @Persisted var completed: Bool
    @Persisted var correctCount: Int
    @Persisted var createdAt: Date // Date型に変更
    
    override init() {
        super.init()  // 親クラスの初期化を先に呼び出す
    }
    
    init(id: Int, title: String, starCount: Int, quizItems: List<RealmQuiz>, completed: Bool, correctCount: Int, createdAt: Date) {
        super.init()
        let realm = try! Realm()
        let maxId = realm.objects(RealmQuizCategory.self).max(ofProperty: "id") as Int?
        self.id = (maxId ?? 0) + 1
        self.title = title
        self.starCount = starCount
        self.quizItems = quizItems
        self.completed = completed
        self.correctCount = correctCount
        self.createdAt = createdAt
    }
    
    // 便利な初期化メソッド
    convenience init(id: Int, title: String, starCount: Int, createdAt: Date) {
        self.init()
        self.id = id
        self.title = title
        self.starCount = starCount
        self.quizItems = List<RealmQuiz>() // 空のリストを作成
        self.completed = false
        self.correctCount = 0
        self.createdAt = createdAt
    }
    
}
