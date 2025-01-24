//
//  HistoryTutorialsView.swift
//  DemoProject
//
//  Created by 指原奈々 on 2025/01/24.
//

import SwiftUI

struct HistoryTutorialsView: View {
    var tutorials = ModelTutorialList()
    var body: some View {
        VStack(alignment: .leading, spacing: 0){
            SubPageTopTitle(title: "最近のチュートリアル", subTitle: "100件を上限に掲載されている",withArrow: true)
            Divider()
            VStack {
                ForEach(tutorials.items.indices, id: \.self){ index in
                    TutorialItemView(tutorial: tutorials.items[index])
                }
            }
            Spacer()
        }
    }
}

#Preview {
    HistoryTutorialsView()
}

struct SubPageTopTitle: View {
    var title :String = ""
    var subTitle :String = ""
    var withArrow = true
    @Environment(\.presentationMode) var presentationMode:Binding<PresentationMode>
    
    //閉じるときは以下を呼び出す
    //self.presentationMode.wrappedValue.dismiss()
    var body: some View {
        HStack(alignment:.top){
            Image(systemName: "arrowshape.backward")
                .padding(.leading,10)
                .padding(.top, 10)
                .onTapGesture {
                    self.presentationMode.wrappedValue.dismiss()
                }
            VStack(alignment:.leading) {
                Text(title)
                    .font(.system(size: 24))
                Text(subTitle)
                    .font(.system(size: 13))
                    .foregroundStyle(.secondary)
            }
            .padding(.leading, 20)
            .padding(.bottom,20)
            Spacer()
        }
    }
}

struct TutorialItemView: View {
    let tutorial: ModelTutorial
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
            }
            .padding(.leading)
            Spacer()
        }
        .padding()
        
    }
}

struct StatusCircleView: View {
    let status: TutorialStatus
    var body: some View {
        VStack{
            switch status {
            case .None:
                Circle() // 全体の円
                    .fill(Color.gray.opacity(0.3)) // 背景色
                    .frame(width: 15, height: 15)
            case .Undone:
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
                
            case .Completed:
                Circle()
                    .fill(.orange)
                    .frame(width: 15, height: 15)
            }
        }
    }
}
