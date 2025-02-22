//
//  QuizCategoryProtocol.swift
//  DemoProject
//
//  Created by 指原奈々 on 2025/02/22.
//

import Foundation
import RealmSwift

protocol QuizCategoryProtocol {
    var id : Int{ get }
    var title : String { get set }
    var starCount : Int { get set }
    var quizItems : RealmSwift.List<DefaultRealmQuiz> { get }
    var completed : Bool { get set }
    var correctCount : Int { get set }
    var createdAt : String { get set }
}
