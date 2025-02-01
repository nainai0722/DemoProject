//
//  PageTest.swift
//  DemoProject
//
//  Created by 指原奈々 on 2025/01/26.
//

import SwiftUI

struct PageQuizList: View {
    @ObservedObject var viewModel = QuizCategoryListModel()
    @State private var selectedCategory: QuizCategory? = nil
    let myQuizFlag = false
    var body: some View {
        //クイズの一覧画面を表示する
        NavigationView {
            ScrollView(.vertical, showsIndicators: false)  {
                VStack(spacing:0) {
                    ForEach(viewModel.categories) { categories in
                        SubPageQuizRow(isAnimating: false, quizCategory: categories,
                                       myQuizFlag: self.myQuizFlag){ category in
                            self.selectedCategory = category
                            
                        }
                    }
                }
                .frame(maxWidth: .infinity)
            }
            VStack{
                Text("左上のアイコンを押してクイズを選んでね")
                    .font(.system(size: 40))
            }
        }
        .onAppear(perform: viewModel.fetch)
    }
}

#Preview {
    PageQuizList()
}
