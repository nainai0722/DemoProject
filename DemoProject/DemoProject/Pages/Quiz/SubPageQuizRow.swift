//
//  SubPageTestRow.swift
//  DemoProject
//
//  Created by 指原奈々 on 2025/01/26.
//

import SwiftUI

struct SubPageQuizRow: View {
    @State var isAnimating = false
    @State var quizCategory:QuizCategory = QuizCategory()
    var myQuizFlag = false
    //クロージャで呼び出し元に返す
    let onSelect: (QuizCategory) -> Void
    var body: some View {
        ZStack{
            RoundedRectangle(cornerRadius: 8)
                .fill(Color.white)
                .frame(width: CommonLayout.width, height: 200)
                .shadow(radius: 8)
            NavigationLink(destination:
                            QuizView(categoryId:quizCategory.id,
                                     myQuizFlag:self.myQuizFlag )
            ){
                VStack {
                    HStack(){
                        QuizCategoryView(quizCategory: quizCategory)
                        QuizStatsView(quizCategory: quizCategory)
                        
                    }
                    .foregroundStyle(.black)
                    .frame(width: CommonLayout.width, height: 150)
                    StartButton()
                }
            }
            .onTapGesture {
                onSelect(quizCategory)
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
    SubPageQuizRow(onSelect: { _ in })
}

struct StartButton: View {
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 8)
                .fill(Color.green.opacity(0.65))
                .frame(width: 100, height: 30)
            Text("はじめる")
                .foregroundStyle(.white)
        }
    }
}

struct QuizStatsView: View {
    var quizCategory: QuizCategory
    var body: some View {
        VStack(alignment:.leading, spacing: 0){
            Text("\(quizCategory.title)クイズに\n挑戦しよう")
                .font(.system(size: 20))
            HStack {
                VStack {
                    Text("答えた数")
                        .font(.system(size: 16))
                    Text("\(quizCategory.correctCount)/\(quizCategory.quizItems.count)")
                }
                VStack {
                    Text("クイズステータス")
                        .font(.system(size: 16))
                    Text(quizCategory.completed ? "完了" : "未完了")
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
}

struct QuizCategoryView: View {
    var quizCategory: QuizCategory
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 8)
                .fill(Color.green.opacity(0.65))
                .frame(width: 120, height: 120)
            
            VStack {
                Image("quiz_\(quizCategory.id)")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 70, height: 70)
                    .padding(.top)
                Text(quizCategory.title)
            }
        }
    }
}
