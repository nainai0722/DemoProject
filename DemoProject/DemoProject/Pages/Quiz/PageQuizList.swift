//
//  PageQuizList.swift
//  DemoProject
//
//  Created by 指原奈々 on 2025/01/29.
//

import SwiftUI

struct PageQuizList: View {
    @ObservedObject var viewModel = RealmQuizCategoryListModel()
    var body: some View {
        //クイズの一覧画面を表示する
        NavigationView{
            ScrollView(.vertical, showsIndicators: false) {
                VStack(spacing:0) {
                    ForEach(viewModel.categories) { category in
                        SubPageQuizRow(isAnimating: false, quizCategory: category)
                    }
                }
                .frame(maxWidth: .infinity)
            }
        }
        .onAppear(perform: viewModel.fetch)
    }
    
}

#Preview {
    PageQuizList()
}
