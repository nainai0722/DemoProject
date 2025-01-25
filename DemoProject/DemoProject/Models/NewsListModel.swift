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
        fetchNews { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let news):
                    self.newsList = news
                case .failure(let error):
                    print("エラーが発生しました: \(error.localizedDescription)")
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
    
    //    private func fetchMockNews(completion: @escaping (Result<[ModelNews], Error>) -> Void) {
    //        // サンプルデータを返すフェッチ処理
    //        let sampleData = [
    //            ModelNews(title: "ニュース1", subTile: "詳細1", postDate: "2025-01-25"),
    //            ModelNews(title: "ニュース2", subTile: "詳細2", postDate: "2025-01-25"),
    //            ModelNews(title: "ニュース3", subTile: "詳細3", postDate: "2025-01-25"),
    //        ]
    //        completion(.success(sampleData))
    //    }

}
