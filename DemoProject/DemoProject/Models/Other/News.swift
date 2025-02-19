//
//  ModelNews.swift
//  DemoProject
//
//  Created by 指原奈々 on 2025/01/24.
//

import Foundation

class News: NSObject,Codable,Identifiable {
    var id: Int
    var title: String
    var subTile: String
    var postDate: String
    
    init(id: Int, title: String, subTile: String, postDate: String) {
        self.id = id
        self.title = title
        self.subTile = subTile
        self.postDate = postDate
    }
    
    private enum CodingKeys: String, CodingKey {
        case id
        case title
        case subTile = "sub_title" // JSONのキーに合わせる
        case postDate = "post_date" // JSONのキーに合わせる
    }
}
