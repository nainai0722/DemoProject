//
//  PageQuizList.swift
//  DemoProject
//
//  Created by 指原奈々 on 2025/01/29.
//

import SwiftUI
import RealmSwift

struct PageMyQuizList: View {
    @StateObject var viewModel = RealmQuizCategoryListModel()
    @State private var selectedCategory: QuizCategory? = nil
    let myQuizFlag = true
    var body: some View {
        //クイズの一覧画面を表示する
        NavigationStack{
            ScrollView(.vertical, showsIndicators: false) {
                VStack(spacing:0) {
                    ForEach(viewModel.categories, id: \.self){ category in
                        SubPageQuizRow(isAnimating: true, quizCategory: category, myQuizFlag: true, onSelect: { category in
                            self.selectedCategory = category
                        })
                    }
                }
                .frame(maxWidth: .infinity)
            }
        }
    }
}

#Preview {
    PageMyQuizList()
}
