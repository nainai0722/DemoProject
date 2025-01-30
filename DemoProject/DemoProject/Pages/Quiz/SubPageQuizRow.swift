//
//  SubPageQuizRow.swift
//  DemoProject
//
//  Created by 指原奈々 on 2025/01/29.
//

import SwiftUI
import RealmSwift

//struct SubPageQuizRow: View {
//    @State var isAnimating = false
//    var quizCategory = RealmQuizCategory(id: 3, title: "漢字クイズ", starCount: 3, createdAt: Date())
//    var body: some View {
//        Text("\(quizCategory.title)")
//    }
//}

struct SubPageQuizRow: View {
    @State var isAnimating = false
    var quizCategory = RealmQuizCategory(id: 3, title: "漢字クイズ", starCount: 3, createdAt: Date())
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
                            Image("quiz_\(quizCategory.id)")
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
                .frame(width: UIScreen.main.bounds.width - 100, height: 150)
                NavigationLink(destination:
                                QuizView(categoryTitle:quizCategory.title, categoryId: quizCategory.id, realmQuizItems: DataInserUpdateLogic().fetchQuizDataByCategoryId(categoryId: quizCategory.id))){
                    ZStack {
                        RoundedRectangle(cornerRadius: 8)
                            .fill(Color.purple.opacity(0.65))
                            .frame(width: 100, height: 30)
                        Text("はじめる")
                    }
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
    SubPageQuizRow()
}
