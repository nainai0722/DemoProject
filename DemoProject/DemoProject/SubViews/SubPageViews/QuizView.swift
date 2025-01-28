//
//  QuizView.swift
//  DemoProject
//
//  Created by 指原奈々 on 2025/01/28.
//

import SwiftUI

struct QuizView: View {
    let quiz = Quiz(id: 1, title: "猫に小判", detail: "猫に小判とはどういういみのことば？", answerNumber: 2, quizOptions: ["価値のあるものをあげても、価値を理解できない相手ではしかたない","かわいい相手にはいくらでもお金を注ぎ込める","贈り物をすると、あとでお礼がもらえる","小判などピカピカ光るものをねこは好む"])
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
        
        
        
    }
}

#Preview {
    QuizView()
}
