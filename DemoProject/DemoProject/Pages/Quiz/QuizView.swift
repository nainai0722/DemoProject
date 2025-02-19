//
//  QuizView.swift
//  DemoProject
//
//  Created by 指原奈々 on 2025/01/28.
//

import SwiftUI
import RealmSwift

struct QuizView: View {
    @State var isAnswerAnimating = false
    var categoryId:Int = 8 //データ格納しているIDを入れておくといい
    var quizCategory = QuizCategory()
    var myQuizFlag = true // 自作クイズ判定フラグ
    @StateObject var viewModel = QuizCategoryListModel()
    @State var index = 0
    @State var selectedAnswer :Int = -1
    @State var isCorrectAnswerPresented  = false
    @State var isEvaluateQuizPresented = false
    let isPhone = UIDevice.current.userInterfaceIdiom == .phone
    var body: some View {
        VStack(spacing:0) {
            if isPhone {
                SubPageTopTitle(title: "戻る", withArrow: true)
            }
            Divider()
            ZStack {
                VStack(alignment:.leading,spacing: 0) {
                    if index < viewModel.quizzes.count {
                        QuizItemView(selectedAnswer: $selectedAnswer, quiz: $viewModel.quizzes[index])
                        Spacer()
                        // 次へボタン
                        NextButton(selectedAnswer: $selectedAnswer, isErrorMessage: false, action: nextQuestion)
                    }else{
                        // クイズがすべて終了した際の画面
                        QuizCompletedView(restartAction: restartQuiz, evaluateAction: evaluateQuiz)
                    }
                }
                .opacity(isAnswerAnimating ? 0.3 : 1)
                .onAppear{
                    loadQuizData()
                }
                .fullScreenCover(isPresented: $isEvaluateQuizPresented) {
                    EvaluateQuizView(isEvaluateQuizPresented: $isEvaluateQuizPresented, quizCategory:quizCategory)
                }
                // クイズの正否はカスタムモーダル必須
                if(isAnswerAnimating) {
                    AnswerFeedbackView(isCorrect: $isCorrectAnswerPresented)
                }
            }
        }
        .navigationTitle(isPhone ? "" : "戻る")
        .navigationBarHidden(isPhone ? true : false)
    }
    
    private func nextQuestion() {
        if selectedAnswer == viewModel.quizzes[index].answerNumber {
            isCorrectAnswerPresented = true
        }
        isAnswerAnimating = true

        // 答えた数を反映させる
        if (myQuizFlag) {
            RealmQuizRepository().updateCategoryCorrectCount(by: categoryId, quizzesIndex: index)
            RealmQuizRepository().updateCategoryComplete(by: categoryId)
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            isAnswerAnimating = false
            index += 1
            selectedAnswer = -1
            isCorrectAnswerPresented = false
        }
    }
    
    private func restartQuiz() {
        index = 0
        selectedAnswer = -1
    }
    
    private func evaluateQuiz() {
        isEvaluateQuizPresented.toggle()
    }
    
    private func loadQuizData() {
        if myQuizFlag {
            viewModel.fetchMyQuizByCategoryId(by: categoryId)
        } else {
            Task {
                await viewModel.fetchMockQuizById(by: categoryId)
            }
        }
    }
}


struct NextButton: View {
    @Binding var selectedAnswer:Int
    @State var isErrorMessage :Bool
    let action: () -> Void

    var body: some View {
        Button(action:{
            if selectedAnswer == -1 {
                isErrorMessage = true
            } else {
                isErrorMessage = false
                action()
            }
        }) {
            VStack(spacing:0) {
                Text("次へ")
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(selectedAnswer == -1 ? Color.gray : Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(10)
                Text("答えを選んで")
                    .foregroundStyle(.red)
                    .opacity(isErrorMessage && selectedAnswer == -1 ? 1 : 0)
            }
        }
        .padding(.horizontal, 20)
        .padding(.bottom, 10)
    }
}

struct QuizCompletedView: View {
    let restartAction: () -> Void
    let evaluateAction: () -> Void

    var body: some View {
        VStack {
            Spacer()
            Text("クイズが終了しました！")
                .font(.system(size: 30))
            Button("もう一度プレイ", action: restartAction)
                .padding()
                .background(Color.blue)
                .foregroundColor(.white)
                .cornerRadius(10)
                .frame(width: 150)
            Button("クイズを評価する", action: evaluateAction)
                .padding()
                .background(Color.blue)
                .foregroundColor(.white)
                .cornerRadius(10)
                .frame(width: 150)
            Spacer()
        }
    }
}
#Preview("読み") {
    @State var mockQuiz = Quiz.mockReadQuizData
    QuizItemView(selectedAnswer: .constant(9), quiz: .constant(mockQuiz))
}
#Preview("絵クイズ") {
    @State var mockQuiz = Quiz.mockImageQuizData
    QuizItemView(selectedAnswer: .constant(9), quiz: .constant(mockQuiz))
}

#Preview {
    QuizView()
}

// 選択肢のレイアウトプレビュー用
#Preview("選択肢ボタン") {
    @State var mockQuiz = Quiz.mockReadQuizData
    HogeView(selectedAnswer: .constant(9), quiz: .constant(mockQuiz))
    TestOptionView(selectedAnswer: .constant(9), quiz: .constant(mockQuiz))
}

struct TestOptionView:View {
    @Binding var selectedAnswer:Int
    @Binding var quiz: Quiz
    @State var isTapped:Bool = false
    var body: some View {
        HStack(alignment:.top) {
            ZStack {
                Image(systemName: "square")
                    .font(.system(size: 30))
                Image(systemName: "checkmark")
            }
            if (quiz.quizOptions.count > 0){
                Text(quiz.quizOptions[0])
            }
            Spacer()
        }
    }
}

// 選択肢のレイアウトの試験用　削除していいはず
struct HogeView:View {
    @Binding var selectedAnswer:Int
    @Binding var quiz: Quiz
    @State var isTapped:Bool = false
    var body: some View {
        
        HStack {
            Spacer()
            Text(quiz.quizOptions[0])
            Text("選択中")
                .opacity(isTapped ? 1 : 0)
            Spacer()
        }
        .frame(maxWidth: .infinity)
        .padding(16)
        .contentShape(Rectangle())
        .border(Color.blue)
        .onTapGesture {
            print("タップ")
            isTapped.toggle( )
        }
        .background(isTapped ? Color.red : Color.clear)
        .foregroundStyle(isTapped ? Color.white : Color.black)
        
    }
}

struct QuizItemView: View {
    let padding:CGFloat = 16
    @Binding var selectedAnswer:Int
    @Binding var quiz: Quiz
    var body: some View {
        VStack()  {
            VStack() {
                Text(quiz.title)
                    .font(.system(size: 24, weight: .bold))
                    .padding()
                switch quiz.quizType {
                    case .imageQuiz:
                    Text(quiz.detail)
                        .font(.system(size: 40, weight: .medium))
                        .frame(width: UIScreen.main.bounds.width - padding * 4)
                        .padding()
                    if !quiz.imageName.isEmpty {
                        Image(quiz.imageName)
                            .resizable()
                            .scaledToFit()
                    }
                    
                    case .readQuiz:
                    Text(quiz.detail)
                        .font(.system(size: 50, weight: .medium))
                        .frame(width: UIScreen.main.bounds.width - padding * 4)
                        .padding()
                    default:
                    Text(quiz.detail)
                        .font(.system(size: 20))
                        .frame(width: UIScreen.main.bounds.width - padding * 4)
                        .padding()
                }
            }
            .padding()
            .frame(width: UIScreen.main.bounds.width * 0.9)
            .background(Color.white) // 背景色をつける
            .cornerRadius(15) // 角を丸くする
            .shadow(color: Color.black.opacity(0.3), radius: 5, x: 0, y: 3)

            ScrollView(){
                ForEach(Array(quiz.quizOptions.enumerated()), id: \.0) { index, option in
                    HStack(alignment:.top) {
                        
                        if(selectedAnswer == index) {
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
                    .frame(maxWidth: .infinity)
                    .padding(16)
                    .contentShape(Rectangle())
                    .background(Color.white)
                    .cornerRadius(8)
                    .shadow(color: Color.black.opacity(0.3), radius: 5, x: 0, y: 3)
                    .onTapGesture {
//                        print("タップ")
                        selectedAnswer = index
                    }
                }
                .padding()
            }
        }
    }
}

/// 選択肢の正否を表示する画面
struct AnswerFeedbackView: View {
    @Binding var isCorrect: Bool
    var body: some View {
        VStack {
            Image(systemName: isCorrect ? "circle" : "xmark.app")
                .font(.system(size: 200))
                .foregroundStyle(isCorrect ? .red : .blue)
                .shadow(radius: 10)
                .transition(.opacity)
            Text(isCorrect ? "正解!!" : "ちがいます")
                .font(.system(size: 40))
                .foregroundStyle(isCorrect ? .red : .blue)
                .shadow(radius: 10)
        }
        .animation(.easeInOut, value: isCorrect)
    }
}


/// クイズの評価画面
struct EvaluateQuizView: View {
    @Binding var isEvaluateQuizPresented: Bool
    @State var quizCategory:QuizCategory
    @State var startCount:Int = 0
    @State private var selectedStar: Int? = nil // 選択された星のインデックス
    var body: some View {
        VStack{
            Text("このクイズの評価をしてください")
            HStack{
                ForEach(1..<6, id: \.self) { count in
                    Button(action: {
                        if selectedStar == count {
                            selectedStar = count - 1  // すでに選択している星なら1つ消す
                        } else {
                            selectedStar = count // 新しい星を選択
                        }
//                        guard let selectedStar = selectedStar else { return }
//                        print("selectedStar \(String(selectedStar))")
                    }) {
                        Image(systemName: (selectedStar ?? quizCategory.starCount) >= count ? "star.fill" : "star")
                            .foregroundColor(.yellow)

                    }
                }
            }
            Button(action:{
                applyChanges()
            }){
                Text("閉じる")
            }
            .padding(.top,40)
        }
        .frame(width: 200, height: 200)
    }
    
    func tapStarCount(count:Int) {
        quizCategory.starCount = count
        print("\(count)")
    }
    
    func applyChanges(){
        isEvaluateQuizPresented.toggle()
        if let selectedStar = selectedStar {
            RealmQuizRepository().updateCategoryStarCount(by:quizCategory.id , starCount: selectedStar)
        }
        
    }
}

#Preview ("タイトル"){
    SubPageTopTitle()
}

struct SubPageTopTitle: View {
    var title :String = ""
    var subTitle :String = ""
    var withArrow = true
    @Environment(\.presentationMode) var presentationMode:Binding<PresentationMode>
    
    //閉じるときは以下を呼び出す
    //self.presentationMode.wrappedValue.dismiss()
    var body: some View {
        HStack(alignment:.top){
            Image(systemName: "arrowshape.backward")
                .padding(.leading,10)
                .padding(.top, 10)
                .onTapGesture {
                    //閉じる
                    self.presentationMode.wrappedValue.dismiss()
                }
            VStack(alignment:.leading) {
                Text(title)
                    .font(.system(size: 24))
                Text(subTitle)
                    .font(.system(size: 13))
                    .foregroundStyle(.secondary)
            }
            .padding(.leading, 20)
            .padding(.bottom,20)
            Spacer()
        }
    }
}
