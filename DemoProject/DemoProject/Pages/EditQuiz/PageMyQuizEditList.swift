//
//  PageMyQuizEditList.swift
//  DemoProject
//
//  Created by 指原奈々 on 2025/02/02.
//

import SwiftUI
struct PageMyQuizEditList: View {
    @ObservedObject var viewModel = RealmQuizCategoryListModel()
    @State private var isEditModalPresented: Bool = false
    @State private var selectedQuiz: Quiz? = nil
    @State private var selectedCategoryId: Int? = nil
    @State var isPresented: Bool = false

    var body: some View {
        ZStack {
            VStack {
                // タイトル部分
                QuizPageTopTitle(isPresented: $isPresented)
                
                List {
                    ForEach(viewModel.categories) { category in
                        Section(header:
                            VStack {
                                Text(category.title)
//                            if category.quizItems.count == 0 {
//                                Text("このカテゴリはデータがない")
//                            }
                        }
                        ) {
                            ForEach(category.quizItems) { quizItem in
                                Text(quizItem.title)
                                    .onTapGesture {
                                        selectedCategoryId = category.id
                                        selectedQuiz = quizItem
                                    }
                            }
                        }
                    }
                    .headerProminence(.increased)
                }
                .listStyle(.insetGrouped)
                .onChange(of: selectedQuiz) { oldValue, newValue in
                    print("selectedQuiz 変更: \(oldValue) → \(newValue)")
                    
                    if newValue != nil {
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                            isEditModalPresented = true
                            print("isEditModalPresented を true に設定")
                        }
                    }
                }

                .sheet(isPresented: $isEditModalPresented) {
                    if let quiz = selectedQuiz, let categoryId = selectedCategoryId {
                        EditQuizModalView(quiz: .constant(quiz), categoryId: .constant(categoryId))
                            .onAppear(){
                                print("EditQuizModalView が表示された")
                            }
                            .onDisappear {
                                print("EditQuizModalView が閉じられた")
                                selectedQuiz = nil
                                selectedCategoryId = nil
                            }
                    }
                }
            }
            .onAppear(perform: viewModel.fetch)
            
            HowToUseView(isPresented: $isPresented)
                .animation(.easeIn.delay(0.5), value: isPresented)
                .opacity(isPresented ? 1 : 0)
        }
    }
    
    func methodTest()  {
        selectedQuiz = nil
        selectedCategoryId = nil
    }
}

#Preview {
    PageMyQuizEditList()
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
