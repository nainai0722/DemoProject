//
//  Quiz.swift
//  DemoProject
//
//  Created by 指原奈々 on 2025/01/28.
//

import Foundation

enum QuizType:String {
    case defaultQuiz = "通常"
    case readQuiz = "読みクイズ"
    case imageQuiz = "絵クイズ"
    case yesNoQuiz = "二択クイズ"
}

class Quiz: NSObject, Identifiable {
    var id : Int
    var title : String
    var detail : String
    var answerNumber : Int
    var quizOptions: [String]
    var quizType : QuizType
    var imageName : String

    init(id: Int, title: String, detail: String, answerNumber: Int, quizOptions: [String], quizType: QuizType = .defaultQuiz, imageName: String = "") {
        self.id = id
        self.title = title
        self.detail = detail
        self.answerNumber = answerNumber
        self.quizOptions = quizOptions
        self.quizType = quizType
        self.imageName = imageName
    }
    // クイズ画面をプレビューするためのモックデータ
    static let mockQuizData: Quiz =  Quiz(id: 1, title: "漢字を当てよう", detail: "別の生き物のように体を変化させることを「ぎたい」と言うよ。当てはまる漢字はどれ？", answerNumber: 1, quizOptions: ["疑体","擬態","技態","模対"])
    static let mockReadQuizData: Quiz = Quiz(id: 1,title: "読み方を当てよう",detail: "『草原』",answerNumber: 2,quizOptions: ["そうげん","くさばら","そうはら","くさはら"], quizType: .readQuiz)
    static let mockImageQuizData: Quiz = Quiz(id: 1,title: "ことわざを当てよう",detail: "『豚に真珠』",answerNumber: 2,quizOptions: ["そうげん","くさばら","そうはら","くさはら"], quizType: .imageQuiz, imageName: "kotowaza_buta_shinju")
}
