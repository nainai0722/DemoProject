//
//  PageCategories.swift
//  DemoProject
//
//  Created by 指原奈々 on 2025/01/24.
//

import SwiftUI

struct PageCategories: View {
    var title : String = "Label"
    @StateObject private var model = CategoryListModel()
    var body: some View {
        VStack(alignment: .leading, spacing: 0){
            SubPageTopTitle(title: title, subTitle: "直書きのデータを表示している。",withArrow: true)
            Divider()
            
            ScrollView {
                LazyVStack(alignment:.leading) {
                            ForEach(0..<(model.items.count / 2  + model.items.count % 2), id: \.self) { rowIndex in
                                HStack {
                                    let firstIndex = rowIndex * 2
                                    
                                    let secondIndex = firstIndex + 1
                                    
                                    
                                    
                                    if firstIndex < model.items.count {
                                        TagItemView(categoryItem: model.items[firstIndex], index: firstIndex)
                                    }
                                    
                                    // 右側の要素（偶数インデックス）
                                    if secondIndex < model.items.count {
                                        TagItemView(categoryItem: model.items[secondIndex], index: secondIndex)
                                    }
                                }
                                .padding(.horizontal)
                            }
                        }
                    }
            .padding(.top, 30)
            .padding(.leading, 30)
            Spacer()
        }
        .onAppear(perform: model.fetch)
        .navigationTitle("")
        .navigationBarHidden(true)
    }
}

#Preview {
    PageCategories()
}
