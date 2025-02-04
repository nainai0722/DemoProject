//
//  PageMyQuizEditList.swift
//  DemoProject
//
//  Created by 指原奈々 on 2025/02/02.
//

import SwiftUI
struct PageMyQuizEditList: View {
    @State var isPresented: Bool = false

    var body: some View {
        ZStack {
            MyQuizEditMainView(isPresented: $isPresented)
            
            HowToUseView(isPresented: $isPresented)
                .animation(.easeIn.delay(0.5), value: isPresented)
                .opacity(isPresented ? 1 : 0)
        }
    }
}

#Preview("List") {
    PageMyQuizEditList()
}

#Preview("Main") {
    // プレビューの？ボタンタップ時のモーダルはこのビューより上の層なので、表示されない
    MyQuizEditMainView(isPresented: .constant(false))
}

struct EditQuizModalView: View {
    @Binding var quiz: Quiz?
    @Binding var categoryId: Int?
    @State var isEditMode: Bool = true

    var body: some View {
        ZStack {
            VStack {
                PageCreateQuiz(
                    isEditMode: $isEditMode,
                    editQuiz: $quiz,
                    editCategoryId: $categoryId
                )
                .padding(.top, 30)
            }
        }
    }
}

struct HowToUseView: View {
    @Binding var isPresented : Bool
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 0)
                .fill(Color.gray.opacity(0.3))
                .ignoresSafeArea(.all)
                
            
            RoundedRectangle(cornerRadius: 10)
                .fill(Color.white)
                .frame(width: 300, height: 200)
            VStack {
                Spacer()
                Text("リストを横スワイプすると、削除できます。")
                    .frame(width: 270)
                Text("リストをタップすると、編集画面が開きます")
                    .frame(width: 270)
                Spacer()
                Divider()
                Button(action:{
                    isPresented = false
                }){
                    Text("閉じる")
                }
                .frame(height: 50)
            }
            .frame(width: 300, height: 200)
        }
    }
}

struct MyQuizEditMainView: View {
    @ObservedObject var viewModel = RealmQuizCategoryListModel()
//    @ObservedObject var viewModel = QuizCategoryListModel() 検証用
    @State private var isEditModalPresented: Bool = false
    @State private var selectedQuiz: Quiz? = nil
    @State private var selectedCategoryId: Int? = nil
    @State private var expandedCategories: [Int: Bool] = [:] // 各カテゴリごとの表示状態
    @Binding var isPresented:Bool
    var body: some View {
        VStack {
            // タイトル部分
            QuizPageTopTitle(isPresented: $isPresented)
            
            List {
                ForEach(viewModel.categories) { category in
                    Section(header:
                        HStack {
                            Text(category.title)
                            if category.quizItems.count == 0 {
                                Text("このカテゴリはデータがない")
                                    .font(.caption)
                            } else {
                                Spacer()
                                Button(action:{
                                        expandedCategories[category.id, default: true].toggle()
                                    }
                                ){
                                    if expandedCategories[category.id, default: true] {
                                        Image(systemName: "arrow.down.and.line.horizontal.and.arrow.up")
                                    } else {
                                        Image(systemName: "arrow.up.and.line.horizontal.and.arrow.down")
                                    }
                                }
                            }
                        }
                    ) {
                        if expandedCategories[category.id, default: true] {
                            ForEach(category.quizItems) { quizItem in
                                HStack{
                                    Text(quizItem.title)
                                    Spacer()
                                }
                                .frame(width: .infinity, height: 40)
                                .contentShape(Rectangle()) // 全体をタップ可能にする
                                .onTapGesture {
                                    selectedCategoryId = category.id
                                    selectedQuiz = quizItem
                                }
                                .transition(.slide)
                            }
                        }
                    }
                }
                .headerProminence(.standard)
            }
            .listStyle(.insetGrouped)
            .onChange(of: selectedQuiz) { oldValue, newValue in
                //                    print("selectedQuiz 変更: \(oldValue) → \(newValue)")
                if newValue != nil {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                        isEditModalPresented = true
                        //                            print("isEditModalPresented を true に設定")
                    }
                }
            }
            
            .sheet(isPresented: $isEditModalPresented) {
                if let quiz = selectedQuiz, let categoryId = selectedCategoryId {
                    EditQuizModalView(quiz: .constant(quiz), categoryId: .constant(categoryId))
                        .onAppear(){
                            //                                print("EditQuizModalView が表示された")
                        }
                        .onDisappear {
                            //                                print("EditQuizModalView が閉じられた")
                            selectedQuiz = nil
                            selectedCategoryId = nil
                        }
                }
            }
        }
        .onAppear {
            viewModel.fetch()
            expandedCategories = viewModel.categories.reduce(into: [:]) { $0[$1.id] = true }
        }
//        (perform: viewModel.fetch)
    }
}
