//
//  ModelTutorialList.swift
//  DemoProject
//
//  Created by 指原奈々 on 2025/01/24.
//

import Foundation
//　検証用
class ModelTutorialList: NSObject {
    var items :[Tutorial]
    
    override init() {
        let tutorials = [
            Tutorial(id: 1, status: .none, title: "SwiftUIの基礎", subTitle: "@Stateと@Bindingについて", startCount: 4, fireCount: 2, favoriteCount: 1),
            Tutorial(id: 2, status: .completed, title: "リスト表示とデータバインディング", subTitle: "ForEachとListの使い方", startCount: 3, fireCount: 3, favoriteCount: 2),
            Tutorial(id: 3, status: .undone, title: "アニメーションの基礎", subTitle: "withAnimationを使った簡単な動き", startCount: 5, fireCount: 1, favoriteCount: 4),
            Tutorial(id: 4, status: .none, title: "ネットワーク通信", subTitle: "URLSessionでデータを取得", startCount: 0, fireCount: 0, favoriteCount: 5),
            Tutorial(id: 5, status: .completed, title: "カスタムビューの作成", subTitle: "再利用可能なコンポーネントの設計", startCount: 1, fireCount: 4, favoriteCount: 6)
        ]

        self.items = tutorials
    }
}
