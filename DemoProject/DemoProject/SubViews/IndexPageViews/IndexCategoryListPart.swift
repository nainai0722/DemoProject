//
//  IndexCategoryListPart.swift
//  DemoProject
//
//  Created by 指原奈々 on 2025/01/24.
//

import SwiftUI

struct IndexCategoryListPart: View {
    var body: some View {
        VStack(alignment:.leading){
            Text("カテゴリーリスト")
                .font(.headline)
                .padding(.leading,20)
                .foregroundColor(Color(red: 0.4, green: 0.4, blue: 0.4))
            
            ZStack {
                
                RoundedRectangle(cornerRadius: 8)
                    .fill(LinearGradient(colors: [Color(red: 255/255, green: 122/255, blue: 109/255),Color(red: 229/255, green: 193/255, blue: 113/255)], startPoint: .leading, endPoint: .trailing))
                    .offset(x: 20, y: 0)
                ScrollView(Axis.Set.horizontal, showsIndicators: false){
                    HStack(alignment:.center, spacing:0){
                        NavigationLink(destination:PageCategories(title: "デザイン")){
                            VStack{
                                Image(systemName: "rectangle.pattern.checkered")
                                    .foregroundStyle(.white)
                                    .font(.system(size: 40))
                                    .frame(width: 100, height: 100)
                                Text("デザイン")
                                    .foregroundStyle(.white)
                                    .font(.system(size: 14))
                            }
                        }
                        NavigationLink(destination:PageCategories(title: "コーディング")){
                            VStack{
                                Image(systemName: "square.and.pencil")
                                    .foregroundStyle(.white)
                                    .font(.system(size: 40))
                                    .frame(width: 100, height: 100)
                                Text("コーディング")
                                    .foregroundStyle(.white)
                                    .font(.system(size: 14))
                            }
                        }
                        NavigationLink(destination:PageCategories(title: "事務ツール")){
                            VStack{
                                Image(systemName: "desktopcomputer")
                                    .foregroundStyle(.white)
                                    .font(.system(size: 40))
                                    .frame(width: 100, height: 100)
                                Text("事務ツール")
                                    .foregroundStyle(.white)
                                    .font(.system(size: 14))
                            }
                        }
                        
                        NavigationLink(destination:PageCategories(title: "その他")){
                            VStack{
                                Image(systemName: "compass.drawing")
                                    .foregroundStyle(.white)
                                    .font(.system(size: 40))
                                    .frame(width: 100, height: 100)
                                Text("その他")
                                    .foregroundStyle(.white)
                                    .font(.system(size: 14))
                            }
                            .padding(.trailing, 10)
                        }
                    }
                    .padding(Edge.Set.init(arrayLiteral: .top,.bottom), 20)
                }
                .offset(x:30, y: 0)
                .cornerRadius(5)
            }
        }
        .padding(.top, 10)
    }
}

#Preview {
    IndexCategoryListPart()
}
