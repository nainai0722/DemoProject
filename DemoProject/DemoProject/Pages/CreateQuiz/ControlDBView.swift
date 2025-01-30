//
//  ControlDBView.swift
//  DemoProject
//
//  Created by 指原奈々 on 2025/01/29.
//

import SwiftUI

struct ControlDBView: View {
    
    @ObservedObject var viewModel = RealmQuizCategoryListModel()
    
    var body: some View {
        VStack {
            SubPageTopTitle(title: "戻る", withArrow: true)
            Divider()
            Button(action:{
                RealmQuizRepository().deleteAllData()
            }){
                Text("すべてのデータを削除")
            }
            Spacer()
            
            Button(action:{
                RealmQuizRepository().initializeDefaultCategoriesIfNeeded()
            }){
                Text("デフォルトカテゴリを追加")
            }
            Spacer()
            
            Button(action:{
                RealmQuizRepository().getTableList()}){
                Text("テーブル一覧")
            }
            Spacer()
            
            Button(action:{
                RealmQuizRepository().printDebugDBElementFromTable()}){
                Text("テーブルの中身")
            }
            Spacer()
            
            
            
            Button(action:{
                RealmQuizRepository().addFirstMockData()
            }){
                Text("カテゴリとクイズ新規追加")
            }
            Spacer()
            Button(action:{
                RealmQuizRepository().addQuizByCategory(categoryId: 0)
            }){
                Text("指定したカテゴリにクイズのみ追加")
            }
            Spacer()
            
            Button(action:{
                let quiz1 = RealmQuiz()
                quiz1.title = "漢字クイズ"
                quiz1.detail = "いきものをつかまえたりする「わな」の正しい漢字は？"
                quiz1.answerNumber = 3
                quiz1.quizOptions.append(objectsIn: ["縄", "和名", "罠", "輪名"])
                RealmQuizRepository().addInputQuizData(quiz: quiz1, categoryId: 0)
            }){
                Text("ビュー側で設定したクイズの追加")
            }
            
            
            // 項目選択
            // 入力した内容を表示する
            ForEach(viewModel.categories){ category in
                Text("\(category.id) : \(category.title)")
                ForEach(category.quizItems){ quiz in
                    HStack {
                        Text("\(quiz.id)")
                        Text(quiz.detail)
                    }
                }
            }
        }
        .onAppear(perform: viewModel.fetch)
    }

}

#Preview {
    ControlDBView()
}
