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
}
