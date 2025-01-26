//
//  SUbPageTestRow.swift
//  DemoProject
//
//  Created by 指原奈々 on 2025/01/26.
//

import SwiftUI

struct SubPageTestRow: View {
    var body: some View {
        ZStack{
            RoundedRectangle(cornerRadius: 8)
                .fill(Color.white)
                .frame(width: UIScreen.main.bounds.width - 100, height: 200)
                .shadow(radius: 8)
            HStack(){
                ZStack {
                    RoundedRectangle(cornerRadius: 8)
                        .fill(Color.blue)
                        .frame(width: 100, height: 100)
                    Text("画像位置")
                }
                VStack(alignment:.leading, spacing: 0){
                    Text("Hello,world!Hello,world!Hello,world!Hello,world!")
                }
            }
            .frame(width: UIScreen.main.bounds.width - 100, height: 200)
        }
    }
}

#Preview {
    SubPageTestRow()
}
