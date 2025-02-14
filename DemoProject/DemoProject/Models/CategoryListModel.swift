//
//  CategoryListModel.swift
//  DemoProject
//
//  Created by 指原奈々 on 2025/01/25.
//

import SwiftUI
import Combine

class CategoryListModel: ObservableObject {
    @Published var items:[CategoryItem] = []

    func fetch() {
        // 検証用のカテゴリを取得する
        fetchMockItems { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let items):
                    self.items = items
                case .failure(let error):
                    print("[\(NSString(string: #file).lastPathComponent):\(#line) \(#function)] エラーが発生しました: \(error.localizedDescription)")

                }
            }
        }
    }
    
    private func fetchMockItems(completion: @escaping (Result<[CategoryItem], Error>) -> Void) {
        // サンプルデータを返すフェッチ処理
        let sampleData = [
            CategoryItem(id: 1, type: .expense, color: .red, title: "子ども銀行", num: 4),
            CategoryItem(id: 2, type: .expense, color: .blue, title: "忘れ物チェッカー", num: 3),
            CategoryItem(id: 3, type: .expense, color: .orange, title: "娯楽", num: 2),
            CategoryItem(id: 4, type: .expense, color: .red, title: "食費", num: 4),
            CategoryItem(id: 5, type: .expense, color: .blue, title: "交通費", num: 3),
            CategoryItem(id: 6, type: .expense, color: .orange, title: "娯楽", num: 2)

        ]
        completion(.success(sampleData))
    }

}
