//
//  TabViewIndex.swift
//  DemoProject
//
//  Created by 指原奈々 on 2025/01/26.
//

import SwiftUI

struct TabViewIndex: View {
    @State var mockQuiz:Quiz? = Quiz.mockQuizData
    @State var isEditeMode = false
    var body: some View {
        TabView {
            PageCreateQuiz(isEditMode:$isEditeMode, editQuiz:$mockQuiz,editCategoryId: .constant(Int(1)))
                .tabItem {
                    Image(systemName: "rectangle.and.pencil.and.ellipsis")
                    Text("つくる")
                }
            
            PageQuizList()
                .tabItem {
                    Image(systemName: "list.dash")
                    Text("クイズ")
                }
            
            PageMyQuizList()
                .tabItem {
                    Image(systemName: "list.dash")
                    Text("自作クイズ")
                }
            
            PageMyQuizEditList()
                .tabItem {
                    Image(systemName: "checklist")
                    Text("自作クイズの編集")
                }
        }
    }
}

#Preview {
    TabViewIndex()
}

