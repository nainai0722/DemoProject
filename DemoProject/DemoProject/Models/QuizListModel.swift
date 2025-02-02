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
    
    func fetch(by id:Int) {
        // 検証用のクイズカテゴリを取得する
        fetchMockQuizByTitle(by:id) { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let quizzes):
                    self.quizzes = quizzes
                case .failure(let error):
                    print("[\(NSString(string: #file).lastPathComponent):\(#line) \(#function)] エラーが発生しました: \(error.localizedDescription)")
                }
            }
        }
    }
    
    
    ///  Realmデータベースの中からidが一致するQuiz型の配列をプロパティに格納する
    /// - Parameter id: クイズカテゴリのID
    func fetchMyQuizByCategoryId(by id:Int) {
//        print("fetchMyQuizByCategoryIdを呼び出す")
//        print("categoryId : \(id)")
        // Previews閲覧しやすいようにQuiz型にする
        quizzes = RealmQuizRepository().getQuizByCategoryId(by: id)
//        for quiz in quizzes {
//            print("クイズタイトル" + quiz.title)
//        }
        print(quizzes)
    }
    
    
    /// アプリ内で用意しているカテゴリクイズにアクセスし、idが一致するQuiz型の配列をコールバックする
    /// - Parameters:
    ///   - id: クイズのid
    ///   - completion: 完了したら、idが一致するQuiz型の配列をコールバックする
    private func fetchMockQuizByTitle(by id:Int,completion: @escaping (Result<[Quiz], Error>) -> Void) {
        var  sampleQuizzes: [Quiz] = []
        // サンプルデータを返すフェッチ処理
        switch id {
        case 1: //"漢字"
            sampleQuizzes = QuizCategoryListModel().wordQuiz
        case 2: //"ことわざ"
            sampleQuizzes = QuizCategoryListModel().kotowazaQuiz
        case 3: //"動物"
            sampleQuizzes = QuizCategoryListModel().animalQuiz
        case 4: //"生活"
            sampleQuizzes = QuizCategoryListModel().lifeQuiz
        case 5: //"有名人"
            sampleQuizzes = QuizCategoryListModel().famousPersonQuiz
        default:
            sampleQuizzes = []
        }
        completion(.success(sampleQuizzes))
    }
}
