//
//  RealmQuiz.swift
//  DemoProject
//
//  Created by 指原奈々 on 2025/01/29.
//

import Foundation
import RealmSwift

class RealmQuiz: Object, Identifiable {
    @Persisted(primaryKey: true) var id: Int
    @Persisted var title: String
    @Persisted var detail: String
    @Persisted var answerNumber: Int
    @Persisted var quizOptions: RealmSwift.List<String> // 配列は List<T> を使う
    
    override init() {
        super.init()  // 親クラスの初期化を先に呼び出す
    }
    
    init(id: Int, title: String, detail: String, answerNumber: Int, quizOptions: List<String>) {
        super.init()
        print("初期化")
        let realm = try! Realm()
        let maxId = realm.objects(RealmQuiz.self).max(ofProperty: "id") as Int?
        print("最大値を取得:\(String(describing: maxId))")
        self.id = (maxId ?? 0) + 1
        self.title = title
        self.detail = detail
        self.answerNumber = answerNumber
        self.quizOptions = quizOptions
    }
}
