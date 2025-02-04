//
//  RealmQuizCategoryListModel.swift
//  DemoProject
//
//  Created by 指原奈々 on 2025/01/29.
//

import Foundation
import SwiftUI
import Combine
import RealmSwift

final class RealmQuizCategoryListModel: ObservableObject {
    @Published var categories: [QuizCategory] = []
    
    init() {
        fetch()
    }

    func fetch() {
        categories = RealmQuizRepository().getQuizCategoryArray()
    }
}
