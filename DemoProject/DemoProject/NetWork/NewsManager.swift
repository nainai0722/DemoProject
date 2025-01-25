//
//  NewsManager.swift
//  DemoProject
//
//  Created by 指原奈々 on 2025/01/24.
//

import Foundation

//func fetchNews(completion: @escaping (Result<[ModelNews], Error>) -> Void) {
//    guard let url = URL(string: "http://localhost:8000/getNews.php") else {
//        completion(.failure(NSError(domain: "Invalid URL", code: 0, userInfo: nil)))
//        return
//    }
//
//    let task = URLSession.shared.dataTask(with: url) { data, response, error in
//        if let error = error {
//            completion(.failure(error)) // ネットワークエラー
//            return
//        }
//
//        guard let data = data else {
//            completion(.failure(NSError(domain: "No data received", code: 0, userInfo: nil)))
//            return
//        }
//
//        do {
//            let news = try JSONDecoder().decode([ModelNews].self, from: data)
//            completion(.success(news)) // デコード成功
//        } catch {
//            completion(.failure(error)) // デコードエラー
//        }
//    }
//    task.resume()
//}
