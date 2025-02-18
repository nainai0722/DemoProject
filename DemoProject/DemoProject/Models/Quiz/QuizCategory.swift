//
//  Quiz.swift
//  DemoProject
//
//  Created by 指原奈々 on 2025/01/26.
//

import SwiftUI

class QuizCategory: NSObject, Identifiable {
    var id : Int
    var title : String
    var starCount : Int
    var quizItems : [Quiz]
    var completed : Bool
    var correctCount : Int
    var createdAt : String
    
    init(id: Int = 1, title: String = "漢字クイズ", starCount: Int = 3, quizItems: [Quiz] = [], completed: Bool = true, correctCount: Int = 0, createdAt: String = "2025--2-7 11:09") {
        self.id = id
        self.title = title
        self.starCount = starCount
        self.quizItems = quizItems
        self.completed = completed
        self.correctCount = correctCount
        self.createdAt = createdAt
    }
    
    private enum CodingKeys : String, CodingKey {
        case id
        case title
        case starCount = "star_count"
        case quizItems = "quiz_items"
        case completed
        case correctCount = "correct_count"
        case createdAt = "created_at"
    }
}


