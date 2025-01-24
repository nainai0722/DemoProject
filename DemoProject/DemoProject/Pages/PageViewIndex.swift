//
//  PageViewIndex.swift
//  DemoProject
//
//  Created by 指原奈々 on 2025/01/24.
//

import SwiftUI

struct PageViewIndex: View {
    @State var isAnimating = false
    var body: some View {
        NavigationView{
            VStack{
                IndexTopBarPart()
                    .opacity(isAnimating ? 1 : 0)
                    .animation(.spring().delay(0.2), value: isAnimating)
            VStack {
                ScrollView{
                        IndexCategoryListPart()
                            .opacity(isAnimating ? 1 : 0)
                            .animation(.spring().delay(0.4), value: isAnimating)
                        
                        IndexClassListPart()
                            .opacity(isAnimating ? 1 : 0)
                            .animation(.spring().delay(0.6), value: isAnimating)
                        
                        IndexTopicsListPart()
                            .opacity(isAnimating ? 1 : 0)
                            .animation(.spring().delay(0.8), value: isAnimating)
                        
                    }
                }
            }
            .onAppear(){
                self.isAnimating = true
            }
        }
    }
}

#Preview {
    PageViewIndex()
}
