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
    @Published var realmQuizzes: [RealmQuiz] = []
    // TODO: @Publisherに必要だったはず。ひとまず置いておく
//    var cancellables: Set<AnyCancellable> = []
    var categoryTitle: String = ""
    
    func fetch(categoryTitle:String) {
        // 検証用のクイズカテゴリを取得する
        fetchMockQuiz(categoryTitle:categoryTitle) { result in
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
    
    
    
    func fetchRealmData(categoryId:Int) {
        realmQuizzes = RealmQuizRepository().getQuizByCategoryId(by: categoryId)
        print(realmQuizzes)
    }
    
    private func fetchMockQuiz(categoryTitle: String,completion: @escaping (Result<[Quiz], Error>) -> Void) {
        var  sampleQuizzes: [Quiz] = []
        // サンプルデータを返すフェッチ処理
        switch categoryTitle {
        case "漢字":
            sampleQuizzes = QuizCategoryListModel().wordQuiz
        case "ことわざ":
            sampleQuizzes = QuizCategoryListModel().kotowazaQuiz
        default:
            sampleQuizzes = []
        }
        completion(.success(sampleQuizzes))
        
    }
}
