//
//  AddQuizLogic.swift
//  DemoProject
//
//  Created by 指原奈々 on 2025/01/29.
//

import Foundation
import RealmSwift


struct DataInserUpdateLogic {
    
    func getTableList() {
        let realm = try! Realm()
        if let objectTypes = realm.configuration.objectTypes {
            for type in objectTypes {
                print("テーブル名: \(type)")
            }
        }
    }
    
    func printDebugDBElementFromTable()  {
        let realm = try! Realm()
        let categories = realm.objects(RealmQuizCategory.self)

//        for category in categories {
//            print("ID: \(category.id), タイトル: \(category.title), クイズ数: \(category.quizItems.count)")
//        }
        
//        let quizzes = realm.objects(RealmQuiz.self)

//        for quiz in quizzes {
//            print("ID: \(quiz.id), タイトル: \(quiz.title), 問題: \(quiz.detail), 解答番号: \(quiz.answerNumber)")
//            print("選択肢: \(quiz.quizOptions.joined(separator: ", "))")
//        }
        
        for category in categories {
            print("カテゴリ: \(category.id)\(category.title)")
            
            for quiz in category.quizItems {
                print("  - クイズ: \(quiz.id):\(quiz.title), 問題: \(quiz.detail)")
            }
        }
    }
    
    /// カテゴリー情報を配列で返す
    /// - Returns: 配列型のカテゴリ情報
    func getCategories() -> [RealmQuizCategory] {
        let realm = try! Realm()
        let categories = realm.objects(RealmQuizCategory.self)
        
        var categoryArray:[RealmQuizCategory] = []
        
        for category in categories {
            categoryArray.append(category)
        }
        return categoryArray
    }
    
    
    /// 指定したカテゴリidと一致するクイズ情報を取得する
    /// - Parameter id: カテゴリーidを指定する
    /// - Returns: 配列型のクイズ情報
    func getQuizByCategoryId(by id :Int) -> [RealmQuiz]  {
        let realm = try! Realm()
        let categories = realm.objects(RealmQuizCategory.self)
//        let quizzes = realm.objects(RealmQuiz.self)　使っていないのでコメントアウトした
        
        var quizArray:[RealmQuiz] = []
        
        for category in categories {
            if (category.id == id) {
                for quiz in category.quizItems {
//                    print("  - クイズ: \(quiz.id):\(quiz.title), 問題: \(quiz.detail)")
                    quizArray.append(quiz)
                }
            }
        }
        return quizArray
    }
    
    func deleteAllData() {
        let realm = try! Realm()
        try! realm.write {
            realm.deleteAll()
            print("削除しました")
        }
    }
    
    func addFirstMockData() {
        let realm = try! Realm()

        let quiz1 = RealmQuiz()
        let maxId = realm.objects(RealmQuiz.self).max(ofProperty: "id") as Int?
        print("最大値を取得:\(String(describing: maxId))")
        quiz1.id = (maxId ?? 0) + 1
        quiz1.title = "漢字クイズ"
        quiz1.detail = "「こうぞう」の正しい漢字は？"
        quiz1.answerNumber = 3
        quiz1.quizOptions.append(objectsIn: ["耕造", "幸三", "公造", "構造"])
        print(quiz1)

        let category = RealmQuizCategory()
        let max2Id = realm.objects(RealmQuizCategory.self).max(ofProperty: "id") as Int?
        //        print("最大値を取得:\(String(describing: max2Id))")
        category.id = (max2Id ?? 0) + 1
        category.title = "漢字クイズ"
        category.starCount = 3
        category.quizItems.append(quiz1)
        category.completed = false
        category.correctCount = 0
        category.createdAt = Date()
        print(category)

        do{
            try realm.write {
                realm.add(quiz1)
                realm.add(category)
                print("追加しました")
            }
        }catch{
            print("Realm書き込みエラー: \(error.localizedDescription)")
        }
        
    }
    
    func addInputQuizData(quiz:RealmQuiz, categoryId: Int) {
        let realm = try! Realm()
        
        let maxId = realm.objects(RealmQuiz.self).max(ofProperty: "id") as Int?
        quiz.id = (maxId ?? 0) + 1
        print("上書きした\(quiz.id)")
        // 引数categoryIdに一致するidのRealmQuizCategoryを取得
        if let category = realm.objects(RealmQuizCategory.self).filter("id == %@", categoryId).first {
            // 一致するカテゴリが見つかった場合、quizItemsに新しいクイズを追加
            try! realm.write {
                realm.add(quiz)
                category.quizItems.append(quiz)
            }
        } else {
            print("指定したカテゴリIDが見つかりませんでした")
        }
    }
        
    func addQuizByCategory(categoryId: Int) {
        print(categoryId)
        print("DB接続")
    
        let realm = try! Realm()

        let quiz1 = RealmQuiz()
        let maxId = realm.objects(RealmQuiz.self).max(ofProperty: "id") as Int?
        print("最大値を取得:\(String(describing: maxId))")
        quiz1.id = (maxId ?? 0) + 1
        quiz1.title = "漢字クイズ"
        quiz1.detail = "「こうぞう」の正しい漢字は？"
        quiz1.answerNumber = 3
        quiz1.quizOptions.append(objectsIn: ["耕造", "幸三", "公造", "構造"])

        // 引数categoryIdに一致するidのRealmQuizCategoryを取得
        if let category = realm.objects(RealmQuizCategory.self).filter("id == %@", categoryId).first {
            print("一致する")
            // 一致するカテゴリが見つかった場合、quizItemsに新しいクイズを追加
            try! realm.write {
                realm.add(quiz1)
                category.quizItems.append(quiz1)
            }
        } else {
            print("指定したカテゴリIDが見つかりませんでした")
        }
    }
    
    func fetchQuizDataByCategoryId(categoryId: Int) -> [RealmQuiz] {
        let realm = try! Realm()
        // 引数categoryIdに一致するidのRealmQuizCategoryを取得
        if let category = realm.objects(RealmQuizCategory.self).filter({ $0.id == categoryId }).first {
            // List<RealmQuiz>型をを[RealQuiz]型にする
            var  quizDataArray: [RealmQuiz] = []
            for quiz in category.quizItems {
                quizDataArray.append(quiz)
            }
            return quizDataArray
        } else {
            print("指定したカテゴリIDが見つかりませんでした")
            return []
        }
    }
    
}

