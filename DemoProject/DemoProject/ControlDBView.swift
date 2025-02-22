//
//  ControlDBView.swift
//  DemoProject
//
//  Created by 指原奈々 on 2025/01/29.
//

import SwiftUI

/// DB操作するための画面　ボタンからRealmQuizRepositoryクラスのメソッドを呼び出ししている
struct ControlDBView: View {
    
    @ObservedObject var viewModel = RealmQuizCategoryListModel()
    
    @ObservedObject var viewModel2 = QuizCategoryListModel()
    
    var body: some View {
        VStack {
            Button(action:{
                RealmQuizRepository().deleteAllData()
            }){
                Text("すべてのデータを削除")
            }
            Spacer()
            
            Button(action:{
                RealmQuizRepository().deleteDefaultQuizCategory()
            }){
                Text("DefaultQuizCategoryデータを削除")
            }
            Spacer()
            
            Button(action:{
                RealmQuizRepository().showLocalQuiz()
            }){
                Text("ローカルクイズを出力")
            }
            Spacer()
            
            Button(action:{
                RealmQuizRepository().defaultRealmQuizInit()
            }){
                Text("初期化")
            }
            Spacer()
            
            
            Button(action:{
                RealmQuizRepository().loadLocalQuizIfNeed()
            }){
                Text("ローカルクイズをDBに追加")
            }
            Spacer()
            
            Button(action:{
                RealmQuizRepository().initializeDefaultCategoriesIfNeeded()
            }){
                Text("自作クイズ用のデフォルトカテゴリを追加")
            }
            Spacer()
            
            Button(action:{
                RealmQuizRepository().getTableList()}){
                Text("テーブル一覧")
            }
            Spacer()
            
            Button(action:{
                RealmQuizRepository().printDebugDBElementFromTable()
            }){
                Text("テーブルの中身")
            }
            Spacer()
            
            Button(action:{
                let quizArray = RealmQuizRepository().getQuizByCategoryId(by:8)
                for quiz in quizArray{
                    print("\(quiz.id)")
                    print("\(quiz.title)\(quiz.detail)")
                }
            }){
                Text("CategoryQuiz型で取得")
            }
            Spacer()
            
            
            Button(action:{
                RealmQuizRepository().addFirstMockData()
            }){
                Text("カテゴリとクイズ新規追加")
            }
            Spacer()
            Button(action:{
                RealmQuizRepository().addMockQuizByCategory(categoryId: 1)
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
                RealmQuizRepository().addInputQuiz(quiz: quiz1, categoryId: 1)
            }){
                Text("ビュー側で設定したクイズの追加")
            }
            Spacer()
            Button(action:{
                let quiz1 = RealmQuiz()
                quiz1.id = 2
                quiz1.title = "いつでも漢字クイズ"
                quiz1.detail = "いきものをつかまえたりする「わな」の正しい漢字は？"
                quiz1.answerNumber = 3
                quiz1.quizOptions.append(objectsIn: ["縄", "和名", "罠", "輪名"])
                RealmQuizRepository().updateInputQuiz(quiz: quiz1, categoryId: 1)
            }){
                Text("クイズの変更")
            }
            
            Spacer()
            Button(action:{
                let quiz1 = RealmQuiz()
                quiz1.id = 2
                quiz1.title = "いつでも漢字クイズ"
                quiz1.detail = "いきものをつかまえたりする「わな」の正しい漢字は？"
                quiz1.answerNumber = 3
                quiz1.quizOptions.append(objectsIn: ["縄", "和名", "罠", "輪名"])
                let realmQuiz = QuizConverter.toQuiz(realmQuiz: quiz1)
                RealmQuizRepository().deleteQuiz(quiz: realmQuiz, categoryId: 1)
            }){
                Text("クイズの削除")
            }
            
            
            // 項目選択
            // 入力した内容を表示する
            ForEach(viewModel.categories){ category in
                Text("\(category.id) : \(category.title)")
                ForEach(category.quizItems){ quiz in
                    HStack {
                        Text("\(quiz.id)")
                        Text(quiz.title)
                        Text(quiz.detail)
                    }
                }
            }
        }
//        .onAppear(perform: viewModel.fetch)
    }

}

#Preview {
    ControlDBView()
}
