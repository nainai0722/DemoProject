//
//  QuizView.swift
//  DemoProject
//
//  Created by 指原奈々 on 2025/01/28.
//

import SwiftUI
import RealmSwift

struct QuizView: View {
    @State var isAnimating = false
    var categoryId:Int = 0
    var myQuizFlag = true
    //TODO: サーバにデータ管理する際に使う想定
    @ObservedObject var viewModel = QuizListModel()
    @State var index = 0
    @State var selectedAnswer :Int = -1
    @State var isCorrectedPresented :Bool = false
    var body: some View {
        VStack {
            if UIDevice.current.userInterfaceIdiom == .phone {
                SubPageTopTitle(title: "戻る", withArrow: true)
            }
            Divider()
            ZStack {
                VStack(alignment:.leading) {
                    if index < viewModel.quizzes.count {
                        QuizItemView(selectedAnswer: $selectedAnswer, quiz: $viewModel.quizzes[index])
                        Spacer()
                        Button(action:{
                            if(selectedAnswer == viewModel.quizzes[index].answerNumber) {
                                isCorrectedPresented = true
                            }
                            isAnimating = true
                            
                            
                            DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {  // 1秒後にアニメーションをリセット
                                isAnimating = false
                                index += 1
                                selectedAnswer = -1
                                isCorrectedPresented = false
                            }
                        }){
                            Text("次へ")
                                .padding()
                                .padding(.horizontal,30)
                                .background(Color.blue)
                                .foregroundStyle(.white)
                                .cornerRadius(10)
                        }
                        .padding(.leading,30)
                        .padding(.bottom, 30)
                    }else{
                        // クイズがすべて終了した場合の表示
                        VStack {
                            Spacer()
                            Text("クイズが終了しました！")
                                .font(.headline)
                            Button("もう一度プレイ") {
                                index = 0 // 最初からやり直す
                                selectedAnswer = -1
                            }
                            Spacer()
                        }
                        
                    }
                }
                .opacity(isAnimating ? 0.3 : 1)
                .onAppear{
                    if myQuizFlag {
                        viewModel.fetchMyQuizByCategoryId(by: categoryId)
                    } else{
                        viewModel.fetch(by: categoryId)
                    }
                }
                
                if(isAnimating) {
                    VStack {
                        Image(systemName: isCorrectedPresented ? "circle" : "xmark.app")
                            .font(.system(size: 200))
                            .foregroundStyle(isCorrectedPresented ? .red : .blue)
                            .shadow(radius: 10)
                            .opacity(isAnimating ? 1 : 0 )
                            .animation(.easeInOut(duration: 0.5),value:isAnimating)
                        Text(isCorrectedPresented ? "正解!!" : "ちがいます")
                            .font(.system(size: 40))
                            .foregroundStyle(isCorrectedPresented ? .red : .blue)
                            .shadow(radius: 10)
                            .opacity(isAnimating ? 1 : 0 )
                            .animation(.easeInOut(duration: 0.5),value:isAnimating)
                    }
                }
            }
            Spacer()
        }
        .navigationTitle(UIDevice.current.userInterfaceIdiom == .phone ? "" : "戻る")
        .navigationBarHidden(UIDevice.current.userInterfaceIdiom == .phone ? true : false)
    }
}

#Preview {
    QuizView()
}

struct QuizItemView: View {
    let padding:CGFloat = 16
    @Binding var selectedAnswer:Int
    var body: some View {
        
        VStack(alignment:.leading, spacing: 0)  {
            ZStack {
                RoundedRectangle(cornerRadius: 8)
                    .fill(Color.white)
                    .frame(width: UIScreen.main.bounds.width - padding * 2, height: 200)
                    .shadow(radius: 8)
                    .padding()
                VStack {
                    Text(quiz.title)
                        .font(.system(size: 24, weight: .bold))
                        .padding()
                    Text(quiz.detail)
                        .font(.system(size: 20))
                        .frame(width: UIScreen.main.bounds.width - padding * 4)
                        .padding()
                }
            }
            ScrollView {
                ForEach(Array(quiz.quizOptions.enumerated()), id: \.0) { index, option in
                    HStack(alignment:.top) {
                        if( selectedAnswer == index) {
                            ZStack {
                                Image(systemName: "square")
                                    .font(.system(size: 30))
                                Image(systemName: "checkmark")
                            }
                        }else {
                            Image(systemName: "square")
                                .font(.system(size: 30))
                        }
                        Text(option)
                            .fixedSize(horizontal: false, vertical: true)
                            .multilineTextAlignment(.leading)
                            .font(.system(size: 24))
                            .padding(.bottom,padding)
                        Spacer()
                    }
                    .onTapGesture {
                        selectedAnswer = index
                    }
                }
                .padding()
            }
        }
//        おそらく要らない
//        .navigationTitle("")
//        .navigationBarHidden(true)
    }
    @Binding var quiz: Quiz
    /*= Quiz(id: 1, title: "猫に小判", detail: "猫に小判とはどういういみのことば？", answerNumber: 2, quizOptions: ["価値のあるものをあげても、価値を理解できない相手ではしかたない","かわいい相手にはいくらでもお金を注ぎ込める","贈り物をすると、あとでお礼がもらえる","小判などピカピカ光るものをねこは好む"])
     */
}



