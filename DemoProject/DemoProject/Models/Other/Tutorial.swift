//
//  ModelTutorial.swift
//  DemoProject
//
//  Created by 指原奈々 on 2025/01/24.
//

import Foundation
enum TutorialStatus: String, Codable {
    case none = "None"
    case undone = "Undone"
    case completed = "Completed"
}

class Tutorial: NSObject,Codable,Identifiable {
    var id : Int
    var status : TutorialStatus
    var title :String
    var subTitle: String
    var starCount: Int
    var fireCount : Int
    var favoriteCount : Int
    
    init(id: Int,status: TutorialStatus,title:String, subTitle: String,startCount: Int,fireCount : Int,favoriteCount : Int) {
        self.status = status
        self.id = id
        self.title = title
        self.subTitle = subTitle
        self.starCount = startCount
        self.fireCount = fireCount
        self.favoriteCount = favoriteCount
    }
    
    // CodingKeysを定義して、プロパティ名とJSONキーを対応付ける
    private enum CodingKeys: String, CodingKey {
        case id
        case status
        case title
        case subTitle = "sub_title"
        case starCount = "star_count"
        case fireCount = "fire_count"
        case favoriteCount = "favorite_count" // JSONキーとプロパティ名が異なる場合に対応
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
