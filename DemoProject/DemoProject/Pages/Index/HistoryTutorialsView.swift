//
//  HistoryTutorialsView.swift
//  DemoProject
//
//  Created by 指原奈々 on 2025/01/24.
//

import SwiftUI

struct HistoryTutorialsView: View {
    @StateObject private var model = TutorialListModel()
    var body: some View {
        VStack(alignment: .leading, spacing: 0){
            SubPageTopTitle(title: "最近のチュートリアル", subTitle: "100件を上限に掲載されている",withArrow: true)
            Divider()
            VStack {
                ForEach(model.items){ item in
                    TutorialItemView(tutorial: item)
                    Divider()
                }
            }
            Spacer()
        }
        .onAppear(perform: model.fetch)
        .navigationTitle("")
        .navigationBarHidden(true)
    }
}

#Preview ("チュートリアルタイトル画面"){
    HistoryTutorialsView()
}

struct TutorialItemView: View {
    let tutorial: Tutorial
    var body: some View {
        HStack {
            StatusCircleView(status: tutorial.status)
                .padding(.bottom,40)
            
            VStack(alignment:.leading) {
                Text(tutorial.title)
                Text(tutorial.subTitle)
                    .foregroundStyle(.gray.opacity(0.6))
                HStack {
                    HStack{
                        ForEach(0..<tutorial.starCount){ _ in
                            Image(systemName:"star.fill")
                        }
                        ForEach(tutorial.starCount..<5){ _ in
                            Image(systemName:"star")
                        }
                    }
                    .font(.caption)
                    .foregroundStyle(.gray)
                    Spacer()
                    
                    HStack {
                        Image(systemName: "flame.fill")
                        Text(tutorial.fireCount.description)
                    }
                    
                    Spacer()
                    HStack {
                        Image(systemName: "hand.thumbsup.fill")
                        Text(tutorial.fireCount.description)
                    }
                }
                .padding(.top,10)
            }
            .padding(.leading)
        }
        .padding()
        
    }
}

struct StatusCircleView: View {
    let status: TutorialStatus
    var body: some View {
        VStack{
            switch status {
            case .none:
                Circle() // 全体の円
                    .fill(Color.gray.opacity(0.3)) // 背景色
                    .frame(width: 15, height: 15)
            case .undone:
                ZStack {
                    Circle() // 全体の円
                        .fill(Color.gray.opacity(0.3)) // 背景色
                        .frame(width: 15, height: 15)
                    
                    Circle() // 半分の円
                        .trim(from: 0, to: 0.5) // 円の一部を描画
                        .rotation(Angle(degrees: -90)) // 上側を起点にする
                        .fill(Color.orange) // 塗りつぶし色
                        .frame(width: 15, height: 15)
                }
                
            case .completed:
                Circle()
                    .fill(.orange)
                    .frame(width: 15, height: 15)
            }
        }
    }
}
