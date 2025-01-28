//
//  QuizCategoryListModel.swift
//  DemoProject
//
//  Created by 指原奈々 on 2025/01/28.
//

import SwiftUI
import Combine

final class QuizCategoryListModel: ObservableObject {
    @Published var categories: [QuizCategory] = []
    
    func fetch() {
        // ニュースを取得する
//        fetchNews { result in
//            DispatchQueue.main.async {
//                switch result {
//                case .success(let news):
//                    self.newsList = news
//                case .failure(let error):
//                    print("エラーが発生しました: \(error.localizedDescription)")
//                }
//            }
//        }
        // 検証用のニュースを取得する
        fetchMockNews { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let news):
                    self.categories = news
                case .failure(let error):
                    print("エラーが発生しました: \(error.localizedDescription)")
                }
            }
        }
    }
    
    private func fetchMockNews(completion: @escaping (Result<[QuizCategory], Error>) -> Void) {
        // サンプルデータを返すフェッチ処理
        let quizCategories: [QuizCategory] = [
            QuizCategory(id: 1, title: "時間", starCount: 3, questions: [], completed: false, correctCount: 0, createdAt: "2025-01-28"),
            QuizCategory(id: 2, title: "食べ物", starCount: 5, questions: [], completed: false, correctCount: 0, createdAt: "2025-01-28"),
            QuizCategory(id: 3, title: "生活", starCount: 2, questions: [], completed: false, correctCount: 0, createdAt: "2025-01-28"),
            QuizCategory(id: 4, title: "生き物", starCount: 0, questions: [], completed: false, correctCount: 0, createdAt: "2025-01-28"),
            QuizCategory(id: 5, title: "時間", starCount: 4, questions: [], completed: false, correctCount: 0, createdAt: "2025-01-28"),
            QuizCategory(id: 6, title: "食べ物", starCount: 1, questions: [], completed: false, correctCount: 0, createdAt: "2025-01-28"),
            QuizCategory(id: 7, title: "生活", starCount: 5, questions: [], completed: false, correctCount: 0, createdAt: "2025-01-28"),
            QuizCategory(id: 8, title: "生き物", starCount: 2, questions: [], completed: false, correctCount: 0, createdAt: "2025-01-28"),
            QuizCategory(id: 9, title: "時間", starCount: 3, questions: [], completed: false, correctCount: 0, createdAt: "2025-01-28"),
            QuizCategory(id: 10, title: "食べ物", starCount: 4, questions: [], completed: false, correctCount: 0, createdAt: "2025-01-28")
        ]

        completion(.success(quizCategories))
    }
}
