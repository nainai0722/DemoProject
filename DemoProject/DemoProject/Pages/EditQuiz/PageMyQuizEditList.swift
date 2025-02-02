//
//  PageMyQuizEditList.swift
//  DemoProject
//
//  Created by 指原奈々 on 2025/02/02.
//

import SwiftUI

struct PageMyQuizEditList: View {
    @ObservedObject var viewModel = RealmQuizCategoryListModel()
    var body: some View {
        VStack{
            List {
                
                ForEach(viewModel.categories) { category in
                    Section(header: Text(category.title)) {
                        ForEach(category.quizItems) { quizItem in
                            // NavigationLink
                            Text(quizItem.title)
                            // スワイプで削除
                        }
                    }
                }
                .headerProminence(.increased)
            }
            .listStyle(.insetGrouped)
        }
        .onAppear(perform: viewModel.fetch)
    }
}

#Preview {
    PageMyQuizEditList()
}
