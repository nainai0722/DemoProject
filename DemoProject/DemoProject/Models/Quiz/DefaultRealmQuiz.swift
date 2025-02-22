//
//  DefaultRealmQuiz.swift
//  DemoProject
//
//  Created by 指原奈々 on 2025/02/20.
//

import Foundation
import RealmSwift

class DefaultRealmQuiz: Object, Identifiable {
    @Persisted(primaryKey: true) var id: Int
    @Persisted var title: String
    @Persisted var detail: String
    @Persisted var answerNumber: Int
    @Persisted var quizOptions: RealmSwift.List<String> // 配列は List<T> を使う
    @Persisted var quizType : QuizType
    @Persisted var imageName : String
    
    override init() {
        super.init()  // 親クラスの初期化を先に呼び出す
    }
    
    init(id: Int, title: String, detail: String, answerNumber: Int, quizOptions: List<String>,quizType:QuizType = .defaultQuiz,imageName:String = "") {
        super.init()
        print("初期化")
        let realm = try! Realm()
        let maxId = realm.objects(RealmQuiz.self).max(ofProperty: "id") as Int?
        print("最大値を取得:\(String(describing: maxId))")
        self.id = (maxId ?? 0) + 1
        print("idは:\(String(describing: self.id))")
//        self.id = id //ここで、おそらくミスっている。データ設計としてミスっている。
        self.title = title
        self.detail = detail
        self.answerNumber = answerNumber
        self.quizOptions = quizOptions
        self.quizType = quizType
        self.imageName = imageName
    }
}
