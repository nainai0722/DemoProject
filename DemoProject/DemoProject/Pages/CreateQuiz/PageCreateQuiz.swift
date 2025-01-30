//
//  PageCreateQuiz.swift
//  DemoProject
//
//  Created by 指原奈々 on 2025/01/29.
//

import SwiftUI

struct PageCreateQuiz: View {
    @ObservedObject var viewModel = RealmQuizCategoryListModel()
    
    @State private var isShowingPopover = false
    @State private var selectedCategoryId: Int = -1
    @State private var selectedCategoryTitle: String = ""
    @State private var selectedOption: String? = nil
    
    @State private var title: String = ""
    @State private var detail: String = ""
    @State private var answerNumberString: String = ""
    @State private var answerNumber: Int = -1
    @State private var option1: String = ""
    @State private var option2: String = ""
    @State private var option3: String = ""
    @State private var option4: String = ""
    
    @State private var isValidCategory: Bool = false
    
    var sortCategories: [RealmQuizCategory] {
        let sortedCategories = viewModel.categories.sorted { $0.id > $1.id }
        
        return sortedCategories
    }
    
    var categories: [RealmQuizCategory] {
        return viewModel.categories
    }
    
    var body: some View {
        VStack {
            SubPageTopTitle(title: "戻る", withArrow: true)
            Divider()
            // TODO : 検証用
            Text("選択された: \(selectedCategoryId)")
                                .font(.headline)
            if selectedCategoryId >= 0 && selectedCategoryId < viewModel.categories.count {
                Text(viewModel.categories[selectedCategoryId].title)
            }
            // TODO : 検証用

//            Menu {
//                ForEach(categories, id: \.self) { category in
//                    Button(action: {
//                        selectedCategoryId = category.id
//                        isShowingPopover = false
//                        isValidCategory = false
//                    }) {
//                        Text("\(category.id): \(category.title)")
//                            .padding()
//                            .frame(maxWidth: .infinity)
//                            .background(Color.gray.opacity(0.2))
//                            .cornerRadius(8)
//                    }
//                }
//            } label: {
//                Label("カテゴリを選択する", systemImage: "doc.fill")
//                    .padding()
//            }
            InputCategoryView(categories: $viewModel.categories, inputText: $selectedCategoryTitle, selectedCategoryId: $selectedCategoryId, isValidCategory: $isValidCategory)
            InputView(inputText:$title , inputTitle:"タイトル", sampleText: "例）漢字を当てよう")
            InputView(inputText: $detail, inputTitle: "クイズの問題文", sampleText: "例）「擬態」この漢字の読み方をこたえよう")
            // 選択肢
            InputView(inputText: $option1, inputTitle: "選択肢1", sampleText: "ぎたい")
            InputView(inputText: $option2, inputTitle: "選択肢2", sampleText: "ぎたい")
            InputView(inputText: $option3, inputTitle: "選択肢3", sampleText: "ぎたい")
            InputView(inputText: $option4, inputTitle: "選択肢4", sampleText: "ぎたい")
            InputAnswerView(inputText: $answerNumberString, inputTitle: "選択肢の中から答えの番号を選ぶ", sampleText: "0")
            
            Spacer()
            
            Button(action:{
                let quiz1 = RealmQuiz()
                if isValidated() {
                    print("入力内容は正しく入力されています。") //検証済み
                    print("\(selectedCategoryId)")
                    print("\(selectedCategoryTitle)")
                    print("\(title)")
                    print("\(detail)")
                    print("\(answerNumberString)")
                    print("\(option1)");print("\(option2)");print("\(option3)");print("\(option4)")
                    quiz1.title = title
                    quiz1.detail = detail
                    quiz1.answerNumber = answerNumber
                    quiz1.quizOptions.append(objectsIn: [option1, option2, option3, option4])
                    DataInserUpdateLogic().addInputQuizData(quiz: quiz1, categoryId: selectedCategoryId) //指定したカテゴリに要素追加されることを確認済み
                }
            }){
                Text("ビュー側で設定したクイズの追加")
                    .font(.headline)
                    .padding()
                    .foregroundStyle(.white)
                    .background(.blue)
            }
            .padding(.bottom,20)
        }
        .onAppear(perform: viewModel.fetch)
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
    
}

#Preview {
    PageCreateQuiz()
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
    @Binding var categories : [RealmQuizCategory]
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
                    if selectedCategoryId >= 0 && selectedCategoryId < categories.count {
                        
                        HStack {
                            Text(categories[selectedCategoryId].title)
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
