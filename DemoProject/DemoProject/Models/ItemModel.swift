//
//  QuizCategoryModel.swift
//  DemoProject
//
//  Created by 指原奈々 on 2025/01/26.
//

import SwiftUI
import Combine
import Foundation

class QuizCategoryModel: ObservableObject {
    @Published var items:[QuizCategory] = []
    
    func fetch() {
        // 検証用のカテゴリを取得する
        fetchMockItems { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let items):
                    self.items = items
                case .failure(let error):
//                    print("エラーが発生しました: \(error.localizedDescription)")
                    print("[\(NSString(string: #file).lastPathComponent):\(#line) \(#function)] エラーが発生しました: \(error.localizedDescription)")

                }
            }
        }
    }
    
    private func fetchMockItems(completion: @escaping (Result<[QuizCategory], Error>) -> Void) {
        // サンプルデータを返すフェッチ処理
        let quizCategories: [QuizCategory] = [
//            QuizCategory(id: 1, title: "時間", starCount: 3, questions: [], completed: false, correctCount: 0, createdAt: "2025-01-28"),
//            QuizCategory(id: 2, title: "食べ物", starCount: 5, questions: [], completed: false, correctCount: 0, createdAt: "2025-01-28"),
//            QuizCategory(id: 3, title: "生活", starCount: 2, questions: [], completed: false, correctCount: 0, createdAt: "2025-01-28"),
//            QuizCategory(id: 4, title: "生き物", starCount: 0, questions: [], completed: false, correctCount: 0, createdAt: "2025-01-28"),
//            QuizCategory(id: 5, title: "時間", starCount: 4, questions: [], completed: false, correctCount: 0, createdAt: "2025-01-28"),
//            QuizCategory(id: 6, title: "食べ物", starCount: 1, questions: [], completed: false, correctCount: 0, createdAt: "2025-01-28"),
//            QuizCategory(id: 7, title: "生活", starCount: 5, questions: [], completed: false, correctCount: 0, createdAt: "2025-01-28"),
//            QuizCategory(id: 8, title: "生き物", starCount: 2, questions: [], completed: false, correctCount: 0, createdAt: "2025-01-28"),
//            QuizCategory(id: 9, title: "時間", starCount: 3, questions: [], completed: false, correctCount: 0, createdAt: "2025-01-28"),
//            QuizCategory(id: 10, title: "食べ物", starCount: 4, questions: [], completed: false, correctCount: 0, createdAt: "2025-01-28")
        ]
        completion(.success(quizCategories))
    }
    
    let quizData = [Quiz(id: 1, title: "らっこはどうやってねる？", detail: "海で暮らすラッコは、どのようにしてねむるでしょうか？", answerNumber: 2, quizOptions: ["海の底で眠る","階層を巻き付けて眠る"])]
}
