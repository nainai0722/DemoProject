//
//  PageProfile.swift
//  DemoProject
//
//  Created by 指原奈々 on 2025/01/26.
//

import SwiftUI

struct PageProfile: View {
    var body: some View {
        VStack{
            ProfileTitleView()
            VStack{
                
            }
        }
    }
}

#Preview {
    PageProfile()
}

struct ProfileTitleView: View {
    var body: some View {
        VStack {
            HStack{
                Image(systemName: "person.circle")
                VStack{
                    Text("Name")
                    Text("自己紹介文")
                }
            }
        }
    }
}
