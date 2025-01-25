//
//  TutorialListModel.swift
//  DemoProject
//
//  Created by 指原奈々 on 2025/01/25.
//

import Foundation

class TutorialListModel: ObservableObject {
    @Published var items: [Tutorial] = []
    
    func fetch() {
        // チュートリアルを取得する
        fetchTutorials { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let items):
                    self.items = items
                case .failure(let error):
                    print("エラーが発生しました: \(error.localizedDescription)")
                }
            }
        }
    }
    
    func fetchTutorials(completion: @escaping (Result<[Tutorial], Error>) -> Void) {
        guard let url = URL(string: "http://localhost:8000/getTutorial.php") else {
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
                let items = try JSONDecoder().decode([Tutorial].self, from: data)
                completion(.success(items)) // デコード成功
            } catch {
                completion(.failure(error)) // デコードエラー
            }
        }
        task.resume()
    }
}
