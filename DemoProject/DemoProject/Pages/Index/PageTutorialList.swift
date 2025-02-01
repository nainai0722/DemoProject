//
//  PageTutorialList.swift
//  DemoProject
//
//  Created by 指原奈々 on 2025/01/24.
//

import SwiftUI
//検索ワードをtitleに入れて、一覧を表示する
struct PageTutorialList: View {
    let title: String
    var body: some View {
        Text(title)
    }
}

#Preview {
    PageTutorialList(title: "検索ワード")
}
