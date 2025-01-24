//
//  IndexClassListPart.swift
//  DemoProject
//
//  Created by 指原奈々 on 2025/01/24.
//

import SwiftUI

struct IndexClassListPart: View {
    let classNameList = ["Color","String","ShapeStyle","Task"]
    @State var shouldPushClassList = false
//    @EnvironmentObject var status: ModelStatus
    
    var body: some View {
        VStack(alignment:.leading){
            Text("ClassList")
                .padding(.leading,20)
                .foregroundStyle(Color(red: 0.4, green: 0.4, blue: 0.4))
                .offset(x: 0, y: 16)
                .padding(.bottom,20)
            
            ScrollView(.horizontal, showsIndicators: false){
                HStack{
                    ForEach(0 ..< classNameList.count,id:\.self){ item in
                        NavigationLink(destination:PageClassList()){
                            VStack{
                                Image(systemName: "star")
                                    .frame(width: 100, height: 100)
                                
                                Text(classNameList[item])
                                    .foregroundStyle(.gray)
                                    .font(.caption)
                                    .multilineTextAlignment(.center)
                                    .padding(.bottom,20)
                            }
                            .border(.gray.opacity(0.5), width: 0.5)
                            .shadow(radius: 5)
                            
                        }
                    }
                }
            }
            .padding(.leading,20)
        }
        
    }
}

#Preview {
    IndexClassListPart()
}
