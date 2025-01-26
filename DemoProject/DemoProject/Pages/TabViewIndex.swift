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
            
            PageTest()
                .tabItem {
                    Image(systemName: "list.dash")
                    Text("Quiz")
                }
            
            PageProfile()
                .tabItem {
                    Image(systemName: "person.circle")
                    Text("Profile")
                }
        }
    }
}

#Preview {
    TabViewIndex()
}
