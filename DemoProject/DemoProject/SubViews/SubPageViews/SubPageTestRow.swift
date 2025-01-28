//
//  SUbPageTestRow.swift
//  DemoProject
//
//  Created by 指原奈々 on 2025/01/26.
//

import SwiftUI

struct SubPageTestRow: View {
    @State var isAnimating = false
    var quizCategory:QuizCategory = QuizCategory(id: 1, title: "時間", starCount: 3, questions: [], completed: false, correctCount: 0, createdAt: "2025-01-28")
    var body: some View {
        ZStack{
            RoundedRectangle(cornerRadius: 8)
                .fill(Color.white)
                .frame(width: UIScreen.main.bounds.width - 100, height: 200)
                .shadow(radius: 8)
            VStack {
                HStack(){
                    ZStack {
                        RoundedRectangle(cornerRadius: 8)
                            .fill(Color.purple.opacity(0.65))
                            .frame(width: 100, height: 100)
                        
                        VStack {
                            Image("quiz_1")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 70, height: 70)
                            Text(quizCategory.title)
                        }
                    }
                    VStack(alignment:.leading, spacing: 0){
                        Text("\(quizCategory.title)クイズに挑戦しよう")
                            .font(.system(size: 20))
                        HStack {
                            VStack {
                                Text("答えた数")
                                    .font(.system(size: 16))
                                Text("\(quizCategory.correctCount)/\(quizCategory.questions.count)")
                            }
                        }
                        HStack{
                            ForEach(0..<quizCategory.starCount){ _ in
                                Image(systemName: "star.fill")
                            }
                            ForEach(quizCategory.starCount..<5){ _ in
                                Image(systemName: "star")
                            }
                        }
                    }
                    
                }
                .frame(width: UIScreen.main.bounds.width - 100, height: 150)
                ZStack {
                    RoundedRectangle(cornerRadius: 8)
                        .fill(Color.purple.opacity(0.65))
                        .frame(width: 100, height: 30)
                    Text("はじめる")
                }
                .onTapGesture {
                    //クイズ画面へ遷移する
                    QuizView()
                }
            }
        }
        .padding(.top, 10)
        .opacity(isAnimating ? 1 : 0)
        .animation(.easeInOut(duration: 0.5),value:isAnimating)
        .onAppear {
            self.isAnimating = true
        }
    }
}

#Preview {
    SubPageTestRow()
}
