//
//  PageCreateQuiz.swift
//  DemoProject
//
//  Created by 指原奈々 on 2025/01/29.
//

import SwiftUI

struct PageCreateQuiz: View {
    @ObservedObject var viewModel = RealmQuizCategoryListModel()
    
    //編集関連のプロパティ
    @Binding var isEditMode: Bool
    @Binding var editQuiz: Quiz?
    @Binding var editCategoryId: Int?
    @State private var showSaveMessage = false
    @State private var showValidationMessage = false
    
    @State private var selectedCategoryId: Int = -1
    @State private var selectedCategoryTitle: String = ""
    
    @State private var title: String = ""
    @State private var detail: String = ""
    @State private var answerNumberString: String = ""
    @State private var answerNumber: Int = -1
    @State private var option1: String = ""
    @State private var option2: String = ""
    @State private var option3: String = ""
    @State private var option4: String = ""
    
    @State private var isValidCategory: Bool = false
    
    @State private var shakeOffset: CGFloat = 0
    @State private var timer: Timer?
    
    @FocusState private var isTextFieldFocused: Bool
    
    var body: some View {
        ZStack {
            VStack {
                EditQuizTopTitle(title: isEditMode ? "クイズを編集する" : "クイズを作ろう",subTitle: "すべての項目を入力しよう",isPresented: .constant(false),onCancel: resetInputElements,
                                 onSave: tappedSaveButton)
                Divider()
                // TODO : 検証用
                //            Text("選択された: \(selectedCategoryId)")
                //                                .font(.headline)
                //            if selectedCategoryId >= 0 && selectedCategoryId < viewModel.categories.count {
                //                Text(viewModel.categories[selectedCategoryId].title)
                //            }
                // TODO : 検証用
                ScrollView {
                    VStack {
                        InputCategoryView(categories: $viewModel.categories, inputText: $selectedCategoryTitle, selectedCategoryId: $selectedCategoryId, isValidCategory: $isValidCategory)
                        InputView(inputText:$title , inputTitle:"タイトル", sampleText: "例）漢字を当てよう")
                        InputView(inputText: $detail, inputTitle: "クイズの問題文", sampleText: "例）「擬態」この漢字の読み方をこたえよう")
                        // 選択肢
                        InputView(inputText: $option1, inputTitle: "選択肢1", sampleText: "ぎたい")
                        InputView(inputText: $option2, inputTitle: "選択肢2", sampleText: "ぎたい")
                        InputView(inputText: $option3, inputTitle: "選択肢3", sampleText: "ぎたい")
                        InputView(inputText: $option4, inputTitle: "選択肢4", sampleText: "ぎたい")
                        InputAnswerView(inputText: $answerNumberString, inputTitle: "選択肢の中から答えの番号を選ぶ", sampleText: "0")
                    }
                    .focused($isTextFieldFocused) // フォーカス管理
                }
                
                Spacer()
            }
            .onTapGesture {
                isTextFieldFocused = false // 画面タップで閉じる
            }
            
            SubmitResultView(title: "保存できました")
                .opacity(showSaveMessage ? 1 : 0)
                .animation(.easeInOut, value: showSaveMessage)
            
            SubmitResultView(title: "入力されていないところがあります")
                .opacity(showValidationMessage ? 1 : 0)
                .offset(x: shakeOffset)
        }
        .onAppear(){
            viewModel.fetch()
            inputEditParameters()
        }
    }
    
    func inputEditParameters() {
        guard let editQuiz = editQuiz else { return }
        if isEditMode {
            title = editQuiz.title
            detail = editQuiz.detail
            answerNumber = editQuiz.answerNumber
            answerNumberString = "選択中の答案"
            option1 = editQuiz.quizOptions[0]
            option2 = editQuiz.quizOptions[1]
            option3 = editQuiz.quizOptions[2]
            option4 = editQuiz.quizOptions[3]
        }
    }
    
    func tappedSaveButton() {
        if isValidated() {
            saveQuiz()
        }else{
            withAnimation(.easeInOut) {
                showValidationMessage = true
            }
            timer = Timer.scheduledTimer(withTimeInterval: 0.05, repeats: true) { _ in
                shakeOffset = Bool.random() ? 5 : -5
            }
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                timer?.invalidate()
                showValidationMessage = false
                shakeOffset = 0
            }
        }
    }

    func isValidated() -> Bool {
        if selectedCategoryId == -1 {
            print("カテゴリが選択されていません")
            isValidCategory = true
            return false
        }
        
        guard !title.isEmpty else {
            print("タイトルが入力されていません")
            return false
        }
        
        guard !detail.isEmpty else {
            print("詳細が入力されていません")
            return false
        }
        
        guard !option1.isEmpty, !option2.isEmpty, !option3.isEmpty, !option4.isEmpty else {
            print("選択項目が入力されていません")
            return false
        }
        guard let answerNumberInt = Int(answerNumberString) else {
            print("正解番号が整数ではありません")
            return false
        }
        answerNumber = answerNumberInt
        return true
    }
    
    func saveQuiz() {
        print("入力内容は正しく入力されています。") //検証済み
        print("\(selectedCategoryId)")
        print("\(selectedCategoryTitle)")
        print("\(title)")
        print("\(detail)")
        print("\(answerNumberString)")
        print("\(option1)");print("\(option2)");print("\(option3)");print("\(option4)")
        let quiz1 = RealmQuiz()
        quiz1.title = title
        quiz1.detail = detail
        quiz1.answerNumber = answerNumber
        quiz1.quizOptions.append(objectsIn: [option1, option2, option3, option4])
        if isEditMode {
            guard let editQuiz = editQuiz else { return
                print("編集するクイズが見つかりません")
            }
            quiz1.id = editQuiz.id
            RealmQuizRepository().updateInputQuiz(quiz: quiz1, categoryId: selectedCategoryId)
        } else {
            RealmQuizRepository().addInputQuiz(quiz: quiz1, categoryId: selectedCategoryId) //指定したカテゴリに要素追加されることを確認済み
        }
         
        resetInputElements()
        showSaveMessage = true
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
            showSaveMessage = false
        }
    }
    
    func resetInputElements() {
        title = ""
        detail = ""
        answerNumber = -1
        option1 = ""
        option2 = ""
        option3 = ""
        option4 = ""
        selectedCategoryId = -1
        selectedCategoryTitle = ""
    }
}

#Preview {
    @Previewable @State var mockQuiz:Quiz? = Quiz.mockQuizData
    
    PageCreateQuiz(isEditMode: .constant(false), editQuiz: $mockQuiz, editCategoryId:.constant(1))
}

// カスタムModifier（MyTitle）の定義
struct MyTitle: ViewModifier {
    let color: Color
    
    func body(content: Content) -> some View {
        content
            .font(.largeTitle)
            .foregroundColor(.white)
            .padding()
            .background(color)
            .clipShape(RoundedRectangle(cornerRadius: 10))
    }
}
extension View {
    func titleStyle(color: Color) -> some View {
        self.modifier(MyTitle(color: color))
    }
}
////使うとき
//Text(<# String #>)
//            .titleStyle(color: .blue)

struct EditQuizTopTitle: View {
    var title :String = ""
    var subTitle :String = ""
    var iconString :String = ""
    var memo:String = ""
    @Binding var isPresented: Bool
    var onCancel: () -> Void
    var onSave: () -> Void
    
    var body: some View {
        ZStack {
            HStack(alignment:.top){
                Button(action:{
                    // 呼び出し元でresetInputElementsを呼び出し
                    onCancel()
                }){
                    Text("キャンセル")
                }
                .frame(width: 80, height: 40)
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
                Button(action:{
                    
                    onSave()
                }){
                    Text("保存")
                }
                .frame(width: 80, height: 40)
                
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

struct InputView: View {
    @Binding var inputText: String
    var inputTitle : String = "クイズの詳細"
    var sampleText : String = "例）「擬態」この漢字の読み方をこたえよう"
    var body: some View {
        VStack(alignment:.leading) {
            Text(inputTitle)
                .padding(.leading, 20)
            ZStack {
                RoundedRectangle(cornerRadius: 8)
                    .fill(Color.gray.opacity(0.2))
                    .frame(width: UIScreen.main.bounds.width * 0.9, height: 40)
                TextField(sampleText, text: $inputText)
                    .frame(width: UIScreen.main.bounds.width * 0.9, height: 35)
                    .padding(.leading, 20)
                    .font(.system(size: 24))
            }
        }
    }
}

struct InputAnswerView: View {
    @State var isShowingNumberPopover:Bool = false
    @Binding var inputText: String
    var inputTitle : String = "クイズの答え"
    @State var sampleText : String = "未選択"
    var body: some View {
        VStack(alignment:.leading) {
            Text(inputTitle)
                .padding(.leading, 20)
            ZStack {
                RoundedRectangle(cornerRadius: 8)
                    .fill(Color.gray.opacity(0.2))
                    .frame(width: UIScreen.main.bounds.width * 0.9, height: 40)
                Menu {
                    ForEach(1..<5, id: \.self) { num in
                        Button(action: {
                            //配列は0...4なので、1つ減らす
                            inputText = "\(num - 1)"
                            sampleText = "\(num)番を選択"
                            isShowingNumberPopover = false
                            
                        }) {
                            Text("正解は\(num)")
                                .padding()
                                .frame(maxWidth: .infinity)
                                .background(Color.gray.opacity(0.2))
                                .cornerRadius(8)
                        }
                    }
                } label: {
                    HStack {
                        Text(sampleText)
                            .padding(.leading, 10)
                        Spacer()
                    }
                    .frame(width: UIScreen.main.bounds.width * 0.9, height: 40)
                }
                
            }
        }
    }
}

struct InputCategoryView: View {
    @State var isShowingPopover = false
    @Binding var categories : [QuizCategory]
    @Binding var inputText: String
    @Binding var selectedCategoryId : Int
    @Binding var isValidCategory: Bool
    var inputTitle : String = "カテゴリーを選ぶ"
    @State var sampleText : String = "0"
    var body: some View {
        VStack(alignment:.leading) {
            Text(inputTitle)
                .padding(.leading, 20)
            ZStack {
                RoundedRectangle(cornerRadius: 8)
                    .fill(Color.gray.opacity(0.2))
                    .frame(width: UIScreen.main.bounds.width * 0.9, height: 40)
                Menu {
                    ForEach(categories, id: \.self) { category in
                        Button(action: {
                            selectedCategoryId = category.id
                            isShowingPopover = false
                            isValidCategory = false
                        }) {
                            Text("\(category.id): \(category.title)")
                                .padding()
                                .frame(maxWidth: .infinity)
                                .background(Color.gray.opacity(0.2))
                                .cornerRadius(8)
                        }
                    }
                } label: {
                    if selectedCategoryId > 0 && selectedCategoryId <= categories.count {
                        
                        HStack {
                            Text(categories[selectedCategoryId - 1].title)
                                .padding(.leading, 10)
                            Spacer()
                        }
                        .frame(width: UIScreen.main.bounds.width * 0.9, height: 40)
                        
                    }else{
                        HStack {
                            Text(inputTitle)
                                .padding(.leading, 10)
                            Spacer()
                        }
                        .frame(width: UIScreen.main.bounds.width * 0.9, height: 40)
                    }
                }
                
            }
        }
    }
}

struct SubmitResultView: View {
    var title: String = "メッセージ"
    
    var body: some View {
        VStack{
            ZStack {
                RoundedRectangle(cornerRadius: 0)
                    .ignoresSafeArea(.all)
                    .foregroundStyle(.gray.opacity(0.2))
                RoundedRectangle(cornerRadius: 15)
                    .foregroundStyle(.white)
                    .frame(width: UIScreen.main.bounds.width * 0.9, height: 80)
                VStack{
                    Text(title)
                }
            }
        }
        .onAppear(){
            
        }
    }
}
