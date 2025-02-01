//
//  QuizListModel.swift
//  DemoProject
//
//  Created by 指原奈々 on 2025/01/28.
//

import SwiftUI
import Combine

final class QuizListModel: ObservableObject {
    @Published var quizzes: [Quiz] = []
    // TODO: @Publisherに必要だったはず。ひとまず置いておく
//    var cancellables: Set<AnyCancellable> = []
//    var categoryTitle: String = ""
    
    func fetch(categoryTitle:String) {
        // 検証用のクイズカテゴリを取得する
        fetchMockQuizByTitle(by:categoryTitle) { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let quizzes):
                    self.quizzes = quizzes
                case .failure(let error):
//                    print("エラーが発生しました: \(error.localizedDescription)")
                    print("[\(NSString(string: #file).lastPathComponent):\(#line) \(#function)] エラーが発生しました: \(error.localizedDescription)")
                }
            }
        }
    }
    
    
    
    func fetchMyQuizByCategoryId(by id:Int) {
        // Previews閲覧しやすいようにQuiz型にする
        print("fetchMyQuizByCategoryIdを呼び出す")
        print("categoryId : \(id)")
        quizzes = RealmQuizRepository().getQuizByCategoryId(by: id)
        for quiz in quizzes {
            print("クイズタイトル" + quiz.title)
        }
        print(quizzes)
    }
    
    private func fetchMockQuizByTitle(by categoryTitle: String,completion: @escaping (Result<[Quiz], Error>) -> Void) {
        var  sampleQuizzes: [Quiz] = []
        // サンプルデータを返すフェッチ処理
        switch categoryTitle {
        case "漢字":
            sampleQuizzes = QuizCategoryListModel().wordQuiz
        case "ことわざ":
            sampleQuizzes = QuizCategoryListModel().kotowazaQuiz
        case "動物":
            sampleQuizzes = QuizCategoryListModel().animalQuiz
        case "生活":
            sampleQuizzes = QuizCategoryListModel().lifeQuiz
        case "有名人":
            sampleQuizzes = QuizCategoryListModel().famousPersonQuiz
        default:
            sampleQuizzes = []
        }
        completion(.success(sampleQuizzes))
    }
}
