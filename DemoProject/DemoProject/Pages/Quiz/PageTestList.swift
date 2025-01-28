//
//  PageTest.swift
//  DemoProject
//
//  Created by 指原奈々 on 2025/01/26.
//

import SwiftUI

struct PageTestList: View {
    @ObservedObject var viewModel = QuizCategoryModel()
    var body: some View {
        //クイズの一覧画面を表示する
        // クイズデータをローカルに置いておく場合、アプリを家の中でしか使えない。
        // クイズデータを別サーバを立てると、その分の学習コストがかかる。Firebaseでいいのか。
        //
        ScrollView{
            VStack {
                ForEach(viewModel.items) { item in
                    SubPageTestRow(isAnimating: false, quizCategory: item)
                }
            }
        }
        .onAppear(perform: viewModel.fetch)
    }
    
}

#Preview {
    PageTestList()
}
