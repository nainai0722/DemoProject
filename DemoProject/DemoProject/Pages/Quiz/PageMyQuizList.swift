//
//  PageQuizList.swift
//  DemoProject
//
//  Created by 指原奈々 on 2025/01/29.
//

import SwiftUI

struct PageMyQuizList: View {
    @ObservedObject var viewModel = RealmQuizCategoryListModel()
    @State private var selectedCategory: QuizCategory? = nil
    let myQuizFlag = true
    var body: some View {
        // NavigationViewはiOS18.2より非推奨のためコメントアウト
//        NavigationView{
//            ScrollView(.vertical, showsIndicators: false) {
//                VStack(spacing:0) {
//                    ForEach(viewModel.categories) { category in
//                        SubPageQuizRow(isAnimating: true, quizCategory: category, myQuizFlag: true, onSelect: { category in self.selectedCategory = category})
//                    }
//                }
//                .frame(maxWidth: .infinity)
//            }
//            MasterView()
//        }
//        .onAppear(perform: viewModel.fetch)
        //クイズの一覧画面を表示する
        ZStack {
            if UIDevice.current.userInterfaceIdiom == .phone {
                NavigationStack{
                    ScrollView(.vertical, showsIndicators: false) {
                        VStack(spacing:0) {
                            ForEach(viewModel.categories) { category in
                                SubPageQuizRow(isAnimating: true, quizCategory: category, myQuizFlag: true, onSelect: { category in self.selectedCategory = category})
                            }
                        }
                        .frame(maxWidth: .infinity)
                    }
                }
            } else {
                NavigationSplitView(
                    sidebar:{
                        ScrollView(.vertical, showsIndicators: false) {
                            VStack(spacing:0) {
                                ForEach(viewModel.categories) { category in
                                    SubPageQuizRow(isAnimating: true, quizCategory: category, myQuizFlag: true, onSelect: { category in self.selectedCategory = category})
                                }
                            }
                            .frame(maxWidth: .infinity)
                        }
                    },
                    detail: {
                        MasterView()
                    }
                )
            }
            
        }
        .onAppear(perform: viewModel.fetch)
    }
    
}

#Preview {
    PageMyQuizList()
}

struct MasterView: View {
    var body: some View {
        VStack{
            Text("左上のアイコンを押してクイズを選んでね")
                .font(.system(size: 40))
        }
    }
}
