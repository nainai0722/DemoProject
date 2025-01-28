//
//  NewsListView.swift
//  DemoProject
//
//  Created by 指原奈々 on 2025/01/24.
//

import SwiftUI

struct NewsListView: View {
    @StateObject private var model = NewsViewModel()
    
    let colors:[Color] = [.blue,.green,.red,.orange,.yellow]
    var body: some View {
        VStack(alignment: .leading,spacing: 0){
            SubPageTopTitle(title: "話題のニュース ", subTitle: "私のローカルサーバからモックデータを流している",withArrow: true)
            Divider()
            ScrollView(){
                if (model.newsList.count == 0){
                    ProgressView()
                }else{
                    VStack(spacing:0){
                        ForEach(model.newsList){ news in
                            SubPageNewsRow(news: news,color:self.colors.randomElement()!)
                        }
                    }
                }
            }
        }
        .onAppear(perform: model.fetch)
        .navigationBarHidden(true)
    }
}

#Preview("notLoading") {
    NewsListView()
}
#Preview("Loading") {
    NewsListView()
}

struct SubPageNewsRow: View {
    var news: News
    var color : Color = .blue
    
    var body: some View {
        HStack{
            Rectangle()
                .fill(.gray)
                .frame(minWidth: 1, idealWidth: 1, maxWidth: 1, minHeight: 120, idealHeight: 100, maxHeight: 1000, alignment: .leading)
                
            HStack {
                Circle()
                    .fill(color)
                    .frame(width: 15, height: 15,alignment: .center)
                    .offset(x: -16, y: 2)
            }
            
            VStack(alignment:.leading) {
                HStack {
                    Text(news.title)
                        .newsTitleStyle(color: .black)
                    Spacer()
                    Image(systemName: "calendar")
                    Text(news.postDate)
                        .padding(.trailing)
                }
                Text(news.subTile)
                
            }
            Spacer()
        }
        .padding(.leading)
    }
}

// カスタムModifier（MyTitle）の定義
struct NewsTitle: ViewModifier {
    let color: Color
    
    func body(content: Content) -> some View {
        content
            .font(.system(size: 20))
            .foregroundColor(color)

    }
}
extension View {
    func newsTitleStyle(color: Color) -> some View {
        self.modifier(NewsTitle(color: color))
    }
}
//使うとき

