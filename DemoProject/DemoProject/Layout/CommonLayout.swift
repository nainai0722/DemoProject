//
//  CommonLayout.swift
//  DemoProject
//
//  Created by 指原奈々 on 2025/02/01.
//

import Foundation
import SwiftUI

struct CommonLayout {
    static let width = UIDevice.current.userInterfaceIdiom == .phone ? UIScreen.main.bounds.width - 100 : UIScreen.main.bounds.width * 0.35
}

struct QuizPageTopTitle: View {    
    var title :String = "クイズを編集"
    var subTitle :String = "使い方に迷ったら、？アイコンを押してね"
    var iconString :String = "questionmark.bubble.fill"
    var memo:String = ""
    @Binding var isPresented: Bool
    
    var body: some View {
        ZStack {
            HStack(alignment:.top){
                Spacer()
                VStack(alignment:.center) {
                    Text(title)
                        .font(.system(size: 24))
                    Text(subTitle)
                        .font(.system(size: 13))
                        .foregroundStyle(.secondary)
                }
                .padding(.bottom,20)
                Spacer()
                
            }
            HStack {
                Spacer()
                Image(systemName: iconString)
                    .font(.system(size: 30))
                    .padding(.trailing)
                    .onTapGesture {
                        isPresented.toggle()
                    }
            }
        }
        
    }
}

#Preview{
    QuizPageTopTitle(isPresented: .constant(false))
}

