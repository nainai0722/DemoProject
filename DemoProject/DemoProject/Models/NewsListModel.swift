//
//  NewsListModel.swift
//  DemoProject
//
//  Created by 指原奈々 on 2025/01/25.
//

import SwiftUI
import Combine

class NewsViewModel: ObservableObject {
    @Published var newsList: [News] = []

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
                    self.newsList = news
                case .failure(let error):
                    print("[\(NSString(string: #file).lastPathComponent):\(#line) \(#function)] エラーが発生しました: \(error.localizedDescription)")

                }
            }
        }
    }
    
    func fetchNews(completion: @escaping (Result<[News], Error>) -> Void) {
        guard let url = URL(string: "http://localhost:8000/getNews.php") else {
            completion(.failure(NSError(domain: "Invalid URL", code: 0, userInfo: nil)))
            return
        }

        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                completion(.failure(error)) // ネットワークエラー
                return
            }

            guard let data = data else {
                completion(.failure(NSError(domain: "No data received", code: 0, userInfo: nil)))
                return
            }

            do {
                let news = try JSONDecoder().decode([News].self, from: data)
                completion(.success(news)) // デコード成功
            } catch {
                completion(.failure(error)) // デコードエラー
            }
        }
        task.resume()
    }
    
    private func fetchMockNews(completion: @escaping (Result<[News], Error>) -> Void) {
        // サンプルデータを返すフェッチ処理
        let sampleData = [
            News(id: 1, title: "ニュースタイトル1", subTile: "ニュース詳細", postDate: "2025-1-25 13:34"),
            News(id: 2, title: "ニュースタイトル2", subTile: "ニュース詳細", postDate: "2025-1-25 13:34"),
            News(id: 3, title: "ニュースタイトル3", subTile: "ニュース詳細", postDate: "2025-1-25 13:34"),
            News(id: 4, title: "ニュースタイトル4", subTile: "ニュース詳細", postDate: "2025-1-25 13:34"),
            News(id: 5, title: "ニュースタイトル5", subTile: "ニュース詳細", postDate: "2025-1-25 13:34"),
        ]
        completion(.success(sampleData))
    }

}
