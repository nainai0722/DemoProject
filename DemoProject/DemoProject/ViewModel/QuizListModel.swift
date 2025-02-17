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
    
    func fetch(by id:Int)  async throws{
        // 検証用のクイズカテゴリを取得する
//        await fetchMockQuizByTitle(by:id) { result in
//            DispatchQueue.main.async {
//                switch result {
//                case .success(let quizzes):
//                    self.quizzes = quizzes
//                case .failure(let error):
//                    print("[\(NSString(string: #file).lastPathComponent):\(#line) \(#function)] エラーが発生しました: \(error.localizedDescription)")
//                }
//            }
//        }
    }
    
    
    ///  Realmデータベースの中からidが一致するQuiz型の配列をプロパティに格納する
    /// - Parameter id: クイズカテゴリのID
    func fetchMyQuizByCategoryId(by id:Int) {
        // Previews閲覧しやすいようにQuiz型にする
        quizzes = RealmQuizRepository().getQuizByCategoryId(by: id)
        print(quizzes)
    }
    
    
//    func fetchQuizByCategoryId(by id:Int) async {
//        // Previews閲覧しやすいようにQuiz型にする
//        let categories = await QuizCategoryListModel().getCategoryList()
//        print(quizzes)
//    }
    /// アプリ内で用意しているカテゴリクイズにアクセスし、idが一致するQuiz型の配列をコールバックする
    /// - Parameters:
    ///   - id: クイズのid
    ///   - completion: 完了したら、idが一致するQuiz型の配列をコールバックする
//    private func fetchMockQuizByTitle(by id:Int,completion: @escaping (Result<[Quiz], Error>) -> Void) async {
//        
//        let categories = await QuizCategoryListModel().getCategoryList()
//        
//        if let sampleQuizzes = categories.first(where: { $0.id == id }){
//            
//            completion(.success(sampleQuizzes.quizItems))
//        } else {
//            print("idで検索する\(id)")
//        }
//        
////        var  sampleQuizzes: [Quiz] = []
////        // サンプルデータを返すフェッチ処理
////        switch id {
////        case 1: //"漢字"
////            sampleQuizzes = QuizCategoryListModel().wordQuiz
////        case 2: //"ことわざ"
////            sampleQuizzes = QuizCategoryListModel().kotowazaQuiz
////        case 3: //"動物"
////            sampleQuizzes = QuizCategoryListModel().animalQuiz
////        case 4: //"生活"
////            sampleQuizzes = QuizCategoryListModel().lifeQuiz
////        case 5: //"有名人"
////            sampleQuizzes = QuizCategoryListModel().famousPersonQuiz
////        case 6:
////            sampleQuizzes = QuizCategoryListModel().wordQuiz2
////        case 7:
////            sampleQuizzes = QuizCategoryListModel().wordQuiz3
////        case 8:
////            sampleQuizzes = QuizCategoryListModel().wordQuiz4
////        default:
////            sampleQuizzes = []
////        }
////        completion(.success(sampleQuizzes))
//    }
}
