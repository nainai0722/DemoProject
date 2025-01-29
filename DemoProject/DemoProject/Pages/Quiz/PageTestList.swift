//
//  PageTest.swift
//  DemoProject
//
//  Created by 指原奈々 on 2025/01/26.
//

import SwiftUI

struct PageTestList: View {
    @ObservedObject var viewModel = QuizCategoryListModel()
    var body: some View {
        //クイズの一覧画面を表示する
        NavigationView{
            ScrollView{
                VStack {
                    ForEach(viewModel.categories) { categories in
                        SubPageTestRow(isAnimating: false, quizCategory: categories)
                    }
                }
            }
        }
        .onAppear(perform: viewModel.fetch)
    }
    
}

#Preview {
    PageTestList()
}
