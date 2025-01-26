//
//  CategoryTagView.swift
//  DemoProject
//
//  Created by 指原奈々 on 2025/01/25.
//

import SwiftUI

struct CategoryTagView: View {
    @StateObject private var model = CategoryListModel()
    var body: some View {
        VStack(alignment: .leading, spacing: 0){
            SubPageTopTitle(title: "カテゴリ選択", subTitle: "直書きのデータを表示している。",withArrow: true)
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
            Spacer()
        }
        .onAppear(perform: model.fetch)
        .navigationTitle("")
        .navigationBarHidden(true)
    }
}

#Preview {
    CategoryTagView()
}

struct TagItemView: View {
    let categoryItem: CategoryItem
    let index : Int
    @State var isAnimating = false
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 13)
                .fill(categoryColor(colorType: categoryItem.color).opacity(0.7))
                .frame(width:stringWidth(), height: 30)
            Text(categoryItem.title + "(\(categoryItem.num))")
                .foregroundStyle(.black)
        }
        .opacity(isAnimating ? 1 : 0)
        .animation(.spring().delay(0.2 + Double(index) * 0.05), value: isAnimating)
        .onAppear(){
            isAnimating = true
        }
        
    }
    
    func stringWidth() -> CGFloat {
        return CGFloat(categoryItem.title.count + 3) * 14
    }
    
    func categoryColor(colorType:ColorType) -> Color {
        switch colorType {
        case .blue:
            return .blue
        case .red:
            return .red
        case .orange:
            return .orange
        }
    }
}
