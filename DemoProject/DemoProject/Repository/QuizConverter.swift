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
    
    static func toRealmQuiz(quiz:Quiz) -> RealmQuiz {
        let realmQuiz = RealmQuiz(id: quiz.id, title: quiz.title, detail: quiz.detail, answerNumber: quiz.answerNumber, quizOptions:List<String>())
        realmQuiz.quizOptions.append(objectsIn: quiz.quizOptions)
        
        return realmQuiz
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
        
    // TODO: `[QuizCategory]` を受け取って `RealmQuizCategory` に変換する処理を追加
    static func toRealmQuizCategory(categories: [QuizCategory]) -> RealmQuizCategory {
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
            dateFormatter.dateFormat = "yyyy-MM-dd HH:mm"
            let createdAtString = dateFormatter.string(from: category.createdAt)
            // category.createdAtをDate型からString型へ
            let tempQuizCategory = QuizCategory(id: category.id, title: category.title, starCount: category.starCount, quizItems: quizArray, completed: category.completed, correctCount: category.correctCount, createdAt:createdAtString)
            categoriesArray.append(tempQuizCategory)
        }
        return categoriesArray
    }
    
}


