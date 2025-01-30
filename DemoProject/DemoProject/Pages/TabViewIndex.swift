//
//  TabViewIndex.swift
//  DemoProject
//
//  Created by 指原奈々 on 2025/01/26.
//

import SwiftUI

struct TabViewIndex: View {
    var body: some View {
        TabView {
            PageViewIndex()
                .tabItem {
                    Image(systemName: "house.fill")
                    Text("Home")
                }
            
            PageTestList()
                .tabItem {
                    Image(systemName: "list.dash")
                    Text("クイズ")
                }
            
            PageQuizList()
                .tabItem {
                    Image(systemName: "list.dash")
                    Text("自作クイズ")
                }
            
            PageCreateQuiz()
                .tabItem {
                    Image(systemName: "rectangle.and.pencil.and.ellipsis")
                    Text("つくる")
                }
            
            PageProfile()
                .tabItem {
                    Image(systemName: "person.circle")
                    Text("自分のこと")
                }
            
                
        }
    }
}

#Preview {
    TabViewIndex()
}
