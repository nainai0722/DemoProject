//
//  SubPageQuizRow.swift
//  DemoProject
//
//  Created by 指原奈々 on 2025/01/29.
//

import SwiftUI
import RealmSwift

struct old_SubPageQuizRow: View {
    @State var isAnimating = false
    var quizCategory = QuizCategory(id: 1, title: "時間", starCount: 3, quizItems: [], completed: false, correctCount: 0, createdAt: "2025-01-28")
    //クロージャで呼び出し元に返す
    let onSelect: (QuizCategory) -> Void
    var body: some View {
        ZStack{
            RoundedRectangle(cornerRadius: 8)
                .fill(Color.white)
                .frame(width: CommonLayout.width, height: 200)
                .shadow(radius: 8)
            VStack {
                HStack(){
                    ZStack {
                        RoundedRectangle(cornerRadius: 8)
                            .fill(Color.orange.opacity(0.65))
                            .frame(width: 120, height: 120)

                        VStack {
                            Image("quiz_\(quizCategory.id)")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 70, height: 70)
                                .padding(.top, 10)
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
                                Text("\(quizCategory.correctCount)/\(quizCategory.quizItems.count)")
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
                .frame(width: CommonLayout.width, height: 150)
                NavigationLink(destination:
                                old_MyQuizView(categoryId: quizCategory.id)
                )
                {
                    ZStack {
                        RoundedRectangle(cornerRadius: 8)
                            .fill(Color.orange.opacity(0.65))
                            .frame(width: 100, height: 30)
                        Text("はじめる")
                            .foregroundStyle(.white)
                    }
                }
                .onTapGesture {
                    onSelect(quizCategory)
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
    old_SubPageQuizRow(){ _ in
        
    }
}
