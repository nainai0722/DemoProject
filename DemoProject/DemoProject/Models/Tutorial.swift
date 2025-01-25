//
//  ModelTutorial.swift
//  DemoProject
//
//  Created by 指原奈々 on 2025/01/24.
//

import Foundation
enum TutorialStatus {
    case None
    case Undone
    case Completed
}

class Tutorial: NSObject {
    var sequence : Int
    var status : TutorialStatus
    var title :String
    var subTitle: String
    var starCount: Int
    var fireCount : Int
    var favoriteCount : Int
    
    init(sequence: Int,status: TutorialStatus,title:String,subTitle: String,startCount: Int,fireCount : Int,favoriteCount : Int) {
        self.status = status
        self.sequence = sequence
        self.title = title
        self.subTitle = subTitle
        self.starCount = startCount
        self.fireCount = fireCount
        self.favoriteCount = favoriteCount
    }
    
//    override init() {
//        let count = Int.random(in: 0...3)
//        if count == 1 {
//            self.status = .None
//        }else if count == 3 {
//            self.status = .Undone
//        }else{
//            self.status = .Completed
//        }
//        self.sequence = 0
//        self.title = "タイトル"
//        self.subTitle = "サブタイトル"
//        self.startCount = 0
//        self.fireCount = 0
//        self.favoriteCount = 0 
//    }
}
