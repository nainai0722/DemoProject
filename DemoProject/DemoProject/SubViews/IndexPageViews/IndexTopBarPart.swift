//
//  IndexTopBarPart.swift
//  DemoProject
//
//  Created by 指原奈々 on 2025/01/24.
//

import SwiftUI

struct IndexTopBarPart: View {
    @State private var tutorialName: String = ""
    @State var isActive = false
    @State var shouldShowAlert = false
    @State var searchText: String = ""
    
    // 警告ボタンの制御を初期化する
    let dismissButton = Alert.Button.default(Text("OK")){}
    
    var alart:Alert{
        Alert(title: Text("注意"), message: Text("最初にキーワードを入力してください"), dismissButton: dismissButton)
    }
    
    var body: some View {
        HStack{
            NavigationLink(destination: PageTutorialList(title:"History Tutorials")){
                Image(systemName: "list.bullet")
                    .font(.system(size: 22))
                    .foregroundColor(.gray)
            }
            Spacer()
                .frame(width: 20)
            ZStack(alignment:Alignment.trailing){
                RoundedRectangle(cornerRadius: 5)
                    .stroke(lineWidth: 1)
                    .fill(Color(red: 0.9, green: 0.9, blue: 0.9))
                    .frame(height: 30)
                TextField("チュートリアルの名前", text: $tutorialName)
                    .padding(5)
                    .clipShape(RoundedRectangle(cornerRadius: 5))
                    .font(.system(size: 14))
                NavigationLink(destination: PageTutorialList(title:self.tutorialName),isActive: $isActive){
                    Text("")
                }
                
                Image(systemName: "magnifyingglass")
                    .font(.system(size: 15))
                    .foregroundColor(.gray)
                    .padding(.trailing,10)
                    .onTapGesture {
                        if self.tutorialName.isEmpty{
                            self.shouldShowAlert = true
                        }else{
                            self.isActive = true
                            self.shouldShowAlert = false
                        }
                    }
                    .alert(isPresented: $shouldShowAlert, content: {
                        alart
                    })
                
            }
            Spacer()
                .frame(width: 20)
            NavigationLink(destination:PageMessagesView()){
                Image(systemName: "3.circle.fill")
                    .foregroundColor(.orange)
                    .font(.system(size: 24))
            }
            
        }
        .padding(.horizontal)
    }
}

#Preview {
    IndexTopBarPart()
}
