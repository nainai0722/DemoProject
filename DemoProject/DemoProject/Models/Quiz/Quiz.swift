//
//  Quiz.swift
//  DemoProject
//
//  Created by 指原奈々 on 2025/01/28.
//

import Foundation

class Quiz: NSObject, Codable,Identifiable {
    var id : Int
    var title : String
    var detail : String
    var answerNumber : Int
    var quizOptions: [String]

    init(id: Int, title: String, detail: String, answerNumber: Int, quizOptions: [String]) {
        self.id = id
        self.title = title
        self.detail = detail
        self.answerNumber = answerNumber
        self.quizOptions = quizOptions
    }
    static let mockQuizData: Quiz =  Quiz(id: 1, title: "漢字を当てよう", detail: "別の生き物のように体を変化させることを「ぎたい」と言うよ。当てはまる漢字はどれ？", answerNumber: 1, quizOptions: ["疑体","擬態","技態","模対"])
    static let mockReadQuizData: Quiz = Quiz(id: 1,title: "読み方を当てよう",detail: "『草原』",answerNumber: 2,quizOptions: ["そうげん","くさばら","そうはら","くさはら"])
}
