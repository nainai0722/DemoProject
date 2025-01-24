//
//  ContentView.swift
//  DemoProject
//
//  Created by 指原奈々 on 2025/01/23.
//

import SwiftUI

struct HomeView: View {
    @State var searchText: String = ""
    var body: some View {
        VStack {
            IndexTopBarPart(searchText: searchText)
            
            CategoryListView()
            
            ClassListView()
        }
    }
}

#Preview {
    HomeView()
}

struct CategoryListView: View {
    var body: some View {
        VStack{
            HStack {
                Text("Category List")
                    .frame(alignment: .leading)
                Spacer()
            }
            ZStack {
                Rectangle()
                    .fill(LinearGradient(gradient: Gradient(colors: [.orange,.yellow]), startPoint: .leading, endPoint: .trailing))
                    .frame(width: UIScreen.main.bounds.width - 30, height: UIScreen.main.bounds.height * 0.2)
                    .shadow(radius: 5)
                HStack{
                    CategoryItemView()
                    CategoryItemView(icon: "chart.dots.scatter")
                    CategoryItemView(icon: "checkmark.gobackward")
                    CategoryItemView(icon: "internaldrive")
                }
            }
        }
        .padding(.horizontal,15)
    }
}

struct CategoryItemView: View {
    var title:String = "Memo"
    var icon:String =  "squareshape.split.3x3"
    var body: some View {
        VStack{
            Image(systemName:icon)
                .font(.system(size: 50))
//                .frame(width: 100, height: 100)
            Text(title)
        }
        .foregroundColor(.white)
    }
}

struct ClassListView: View {
    var body: some View {
        VStack{
            HStack {
                Text("Class List")
                Spacer()
            }
            VStack{
                ScrollView(.horizontal){
                    ClassItemView()
                }
            }
        }
        .padding(.top,10)
        .padding(.horizontal)
    }
}

struct ClassItemView: View {
    var title:String =  "writing"
    var icon:String =  "square.and.pencil"
    var body: some View {
        ZStack {
            Rectangle()
                .fill(.white)
                .frame(width: 100, height: 130)
                .shadow(radius: 1)
            VStack{
                Image(systemName: icon)
                    .font(.system(size: 50))
                Text(title)
                    .padding(.top,10)
                
            }
        }
    }
}
