//
//  QuizCategoryProtocol.swift
//  DemoProject
//
//  Created by 指原奈々 on 2025/02/22.
//

import Foundation
import RealmSwift

protocol QuizCategoryProtocol {
    associatedtype QuizName : Object
    var id : Int{ get }
    var title : String { get set }
    var starCount : Int { get set }
    var completed : Bool { get set }
    var correctCount : Int { get set }
    var createdAt : Date { get set }
    
    var quizItemArray: [QuizName] { get }
}

extension RealmQuizCategory: QuizCategoryProtocol {
//    typealias QuizName = RealmQuiz
    var quizItemArray: [RealmQuiz] {
        return Array(quizItems)
    }
}
extension DefaultRealmQuizCategory: QuizCategoryProtocol {
//    typealias QuizName = DefaultRealmQuiz
    var quizItemArray: [DefaultRealmQuiz] {
        return Array(quizItems)
    }
}
