//
//  Quiz.swift
//  DemoProject
//
//  Created by 指原奈々 on 2025/01/26.
//

import SwiftUI

class QuizCategory: NSObject, Codable,Identifiable {
    var id : Int
    var title : String
    var starCount : Int
    var questions : [Quiz]
    var completed : Bool
    var correctCount : Int
    var createdAt : String
    
    init(id: Int, title: String, starCount: Int, questions: [Quiz], completed: Bool, correctCount: Int, createdAt: String) {
        self.id = id
        self.title = title
        self.starCount = starCount
        self.questions = questions
        self.completed = completed
        self.correctCount = correctCount
        self.createdAt = createdAt
    }
    
    private enum CodingKeys : String, CodingKey {
        case id
        case title
        case starCount = "star_count"
        case questions
        case completed
        case correctCount = "correct_count"
        case createdAt = "created_at"
    }
}


