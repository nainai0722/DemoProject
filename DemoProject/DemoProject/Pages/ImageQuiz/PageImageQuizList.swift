//
//  PageImageQuizList.swift
//  DemoProject
//
//  Created by 指原奈々 on 2025/01/31.
//

import SwiftUI
/*
 NavigationSplitView {
     List(colors, id: \.self, selection: $selection) { color in
         NavigationLink(color.description, value: color)
     }
 } detail: {
     if let color = selection {
         ColorDetail(color: color)
     } else {
         Text("Pick a color")
     }
 }
 */


struct PageImageQuizList: View {
    @ObservedObject var viewModel = RealmQuizCategoryListModel()
    @State private var selectedCategory: QuizCategory? = nil
    
    var body: some View {
        NavigationSplitView {
            ScrollView(.vertical, showsIndicators: false) {
                VStack(spacing:0) {
                    ForEach(viewModel.categories) { category in
                        SubPageQuizRow(isAnimating: false, quizCategory: category){ category in
                            self.selectedCategory = category
                            
                        }
                    }
                }
                .frame(maxWidth: .infinity)
            }
        } detail: {
            if let category = selectedCategory {
//                QuizDetailView(category: category)
            } else {
                Text("クイズを選択してください")
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .background(Color(.systemGroupedBackground))
            }
        }
    }
}

#Preview {
    PageImageQuizList()
}
