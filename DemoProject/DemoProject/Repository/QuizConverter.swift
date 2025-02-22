//
//  QuizConverter.swift
//  DemoProject
//
//  Created by 指原奈々 on 2025/02/01.
//

import Foundation
import RealmSwift

struct QuizConverter {
    
    /// RealmQuiz型からQuiz型へ変換する
    /// - Parameter realmQuiz: データベース用の型
    /// - Returns: 画面用の型
    static func toQuiz(realmQuiz:RealmQuiz)-> Quiz {
        return Quiz(id: realmQuiz.id, title: realmQuiz.title, detail: realmQuiz.detail, answerNumber: realmQuiz.answerNumber, quizOptions: toQuizOption(quizOptions: realmQuiz.quizOptions) )
    }
    
    static func DefaultRealmQuizToQuiz(defaultRealmQuiz:DefaultRealmQuiz)-> Quiz {
        return Quiz(id: defaultRealmQuiz.id, title: defaultRealmQuiz.title, detail: defaultRealmQuiz.detail, answerNumber: defaultRealmQuiz.answerNumber, quizOptions: toQuizOption(quizOptions: defaultRealmQuiz.quizOptions) )
    }
    
    static func toRealmQuiz(quiz:Quiz) -> RealmQuiz {
        let realmQuiz = RealmQuiz(id: quiz.id, title: quiz.title, detail: quiz.detail, answerNumber: quiz.answerNumber, quizOptions:List<String>())
        realmQuiz.quizOptions.append(objectsIn: quiz.quizOptions)
        
        return realmQuiz
    }
    
    static func toDefaultRealmQuiz(quiz:Quiz) -> DefaultRealmQuiz {
        let realmQuiz = DefaultRealmQuiz(id: quiz.id, title: quiz.title, detail: quiz.detail, answerNumber: quiz.answerNumber, quizOptions:List<String>())
        realmQuiz.quizOptions.append(objectsIn: quiz.quizOptions)
        
        return realmQuiz
    }
    
    static func quizListToDefaultRealmQuizList(quizList:[Quiz]) -> List<DefaultRealmQuiz> {
        let defaultRealmQuizList = List<DefaultRealmQuiz>()
        for quiz in quizList {
            defaultRealmQuizList.append(toDefaultRealmQuiz(quiz: quiz))
        }
        return defaultRealmQuizList
    }
    
    
    static func toQuizList(quizItems:List<RealmQuiz>) -> [Quiz] {
        // `RealmQuiz` のリストを `Quiz` に変換する
        let quizArray: [Quiz] = quizItems.map { realmQuiz in
            toQuiz(realmQuiz: realmQuiz)
        }
        return quizArray
    }
    
    static func toRealmQuizOption(quizOptions: [String]) -> RealmSwift.List<String>  {
        let options = RealmSwift.List<String>()
        options.append(objectsIn: quizOptions)
        return options
    }
    
    static func toQuizOption(quizOptions:List<String>) -> [String] {
        return Array(quizOptions)
    }
        
    // TODO: `QuizCategory` を受け取って `RealmQuizCategory` に変換する処理を追加
    static func toRealmQuizCategory(category: QuizCategory) -> RealmQuizCategory {
        
        let realmQuizCategory = RealmQuizCategory()
        realmQuizCategory.id = category.id
        realmQuizCategory.title = category.title
        realmQuizCategory.starCount = category.starCount
//        realmQuizCategory.createdAt = category.createdAt
        
//        var item:Results<RealmQuiz>
//        for category.quizItems in item {
//            
//        }
//        toRealmQuiz()
//        realmQuizCategory.quizItems = RealmSwift.List<RealmQuiz>()
//        
//        
//        
//        quizOptions:List<String>())
//        realmQuiz.quizOptions.append(objectsIn: quiz.quizOptions)
        
        fatalError("未実装: QuizCategory を RealmQuizCategory に変換する処理を実装する")
    }


    static func toQuizCategoryList(categories : Results<RealmQuizCategory>) -> [QuizCategory] {
        var categoriesArray : [QuizCategory] = []
        for category in categories {
            // `RealmQuiz` のリストを `Quiz` に変換する
            let quizArray: [Quiz] = category.quizItems.map { realmQuiz in
                Quiz(id: realmQuiz.id, title: realmQuiz.title, detail: realmQuiz.detail, answerNumber: realmQuiz.answerNumber, quizOptions: Array(realmQuiz.quizOptions))
            }

            // `createdAt` を `String` に変換
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd"
            let createdAtString = dateFormatter.string(from: category.createdAt)
            // category.createdAtをDate型からString型へ
            let tempQuizCategory = QuizCategory(id: category.id, title: category.title, starCount: category.starCount, quizItems: quizArray, completed: category.completed, correctCount: category.correctCount, createdAt:createdAtString)
            categoriesArray.append(tempQuizCategory)
        }
        return categoriesArray
    }
    
    static func defaultRealmQuizCategoryToQuizCategoryList(categories : Results<DefaultRealmQuizCategory>) -> [QuizCategory] {
        var categoriesArray : [QuizCategory] = []
        for category in categories {
            // `RealmQuiz` のリストを `Quiz` に変換する
            let quizArray: [Quiz] = category.quizItems.map { realmQuiz in
                Quiz(id: realmQuiz.id, title: realmQuiz.title, detail: realmQuiz.detail, answerNumber: realmQuiz.answerNumber, quizOptions: Array(realmQuiz.quizOptions))
            }

            // `createdAt` を `String` に変換
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd"
            let createdAtString = dateFormatter.string(from: category.createdAt)
            // category.createdAtをDate型からString型へ
            let tempQuizCategory = QuizCategory(id: category.id, title: category.title, starCount: category.starCount, quizItems: quizArray, completed: category.completed, correctCount: category.correctCount, createdAt:createdAtString)
            categoriesArray.append(tempQuizCategory)
        }
        return categoriesArray
    }
    
    static func quizCategoryToDefaultRealmQuizCategory (categories : [QuizCategory]) -> [DefaultRealmQuizCategory] {
        var defaultCategories: [DefaultRealmQuizCategory] = []
        for category in categories {
            let defaultCategory = DefaultRealmQuizCategory()
            defaultCategory.id = category.id
            defaultCategory.title = category.title
            defaultCategory.starCount = category.starCount
            
            var quizItems: [DefaultRealmQuiz] = []
            for quizItem in category.quizItems {
                let defaultQuizItem = DefaultRealmQuiz()
                let realm = try! Realm()
                let maxId = realm.objects(DefaultRealmQuiz.self).max(ofProperty: "id") as Int?
//                print("最大値を取得:\(String(describing: maxId))")
//                defaultQuizItem.id = (maxId ?? 0) + 1
//                print("更新したid\(defaultQuizItem.id)")
                defaultQuizItem.id = quizItem.id
                defaultQuizItem.title = quizItem.title
                defaultQuizItem.detail = quizItem.detail
                
                defaultQuizItem.quizOptions.append(objectsIn:quizItem.quizOptions)
                defaultQuizItem.answerNumber = quizItem.answerNumber
                defaultQuizItem.quizType = quizItem.quizType
                quizItems.append(defaultQuizItem)
            }
            defaultCategory.quizItems.append(objectsIn: quizItems)
            
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd" // フォーマットを指定
            dateFormatter.locale = Locale(identifier: "ja_JP") // 日本向けのロケールを設定
            // dateFormatter.date(from:String)は返り値がDate?なので、if letで受け取る
            if let date = dateFormatter.date(from: category.createdAt) {
                defaultCategory.createdAt = date
            } else {
                print("⚠️ 日付の変換に失敗: \(category.createdAt)")
            }
//                print("\(defaultCategory.title)を追加しました")
//            print("\(defaultCategory.title)のクイズ詳細")
//            print("\(defaultCategory.quizItems)")
            defaultCategories.append(defaultCategory)
        }
        return defaultCategories
    }
}
