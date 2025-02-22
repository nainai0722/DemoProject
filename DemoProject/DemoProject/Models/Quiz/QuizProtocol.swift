//
//  QuizProtocol.swift
//  DemoProject
//
//  Created by 指原奈々 on 2025/02/22.
//

import Foundation
import RealmSwift

protocol QuizProtocol {
    var id : Int { get }
    var title : String{ get set }
    var detail : String{ get set }
    var answerNumber : Int{ get set }
    var quizOptions: [String]{ get set }
    var quizType : QuizType{ get set }
    var imageName : String{ get set }
}
