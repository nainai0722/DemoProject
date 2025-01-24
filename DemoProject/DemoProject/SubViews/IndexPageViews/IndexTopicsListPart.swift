//
//  IndexTopicsListPart.swift
//  DemoProject
//
//  Created by 指原奈々 on 2025/01/24.
//

import SwiftUI

struct IndexTopicsListPart: View {
    let topicsImageList = ["cat",
                           "tortoise",
                           "hare",
                           "dog",
                           "lizard"]
    let topicsNameList = ["cat",
                           "tortoise",
                           "hare",
                           "dog",
                           "lizard"]
    var body: some View {
        VStack(alignment:.leading){
            Text("人気のトピックス")
                .font(.headline)
            ScrollView(.horizontal, showsIndicators: false){
                HStack(spacing: 20){
                    ForEach(topicsImageList.indices, id: \.self){ index in
                        
                        NavigationLink(destination:
                                        PageTutorialList(title: self.topicsNameList[index]),
                                       label: {
                                            
                            ZStack {
                                RoundedRectangle(cornerRadius: 5)
                                    .foregroundStyle(LinearGradient(gradient: Gradient(colors: [Color.blue, Color.purple]), startPoint: .topLeading, endPoint: .bottomTrailing))
                                    .frame(width: UIScreen.main.bounds.width / 2, height: 100)
                                VStack {
                                    Image(systemName: topicsImageList[index])
                                        .font(.system(size: 30))
                                    Text(topicsNameList[index])
                                        .padding(.top,10)
                                }
                                .foregroundStyle(.white)
                            }
                                        }
                        )
                    }
                }
            }
        }
    }
}

/*
 HStack(spacing: 20){
     ForEach(topicsImageList.indices, id: \.self){ index in
         VStack {
             Image(systemName: topicsImageList[index])
                 .resizable()
                 .frame(width: 40, height: 40)
                 .foregroundColor(.gray)
             Text(topicsNameList[index])
         }
     }
 }
 */


#Preview {
    IndexTopicsListPart()
}
