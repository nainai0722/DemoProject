//
//  Category.swift
//  DemoProject
//
//  Created by 指原奈々 on 2025/01/25.
//
import SwiftUI
import Foundation

enum CategoryType: String, Codable {
    case income
    case expense
}

enum ColorType: String, Codable  {
    case red
    case blue
    case orange
}

class CategoryItem: NSObject, Codable,Identifiable {
    var id : Int
    var type : CategoryType
    var color: ColorType
    var title :String
    var num: Int
    
    init(id: Int, type: CategoryType, color: ColorType, title: String, num: Int) {
        self.id = id
        self.type = type
        self.color = color
        self.title = title
        self.num = num
    }
    
    private enum CodingKeys : String, CodingKey {
        case id
        case type
        case color
        case title
        case num
    }
}
