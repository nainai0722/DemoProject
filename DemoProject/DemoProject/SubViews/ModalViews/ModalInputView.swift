//
//  ModalInputView.swift
//  DemoProject
//
//  Created by 指原奈々 on 2025/01/24.
//

import SwiftUI

struct ModalInputView: View {
    @Binding var isPresented: Bool
    @Binding var name:String
    @Environment(\.presentationMode) var presentationMode:Binding<PresentationMode>
    
    //閉じるときは以下を呼び出す
    //self.presentationMode.wrappedValue.dismiss()
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 0)
                .fill(.black.opacity(0.3))
                .ignoresSafeArea(edges: .all)
            VStack{
                Text("名前が入力されていません")
                    .padding(.top,15)
                Divider()
                ZStack {
                    RoundedRectangle(cornerRadius: 8)
                        .stroke(.gray.opacity(0.3),lineWidth: 1)
                        .frame(width: 200)
                    TextField("名前を入力してください", text: $name)
                        .foregroundStyle(.gray.opacity(0.3))
                        .frame(width: 200,height: 40)

                }
                HStack{
                    Button(action:{
                        isPresented = false
                        self.presentationMode.wrappedValue.dismiss()
                    }){
                        Text("キャンセル")
                    }
                    Spacer()
                    Button(action:{
                        if invalid() {
                            isPresented = false
                            self.presentationMode.wrappedValue.dismiss()
                        }
                    }){
                            Text("保存")
                    }
                }
                .padding()
            }
            .frame(width: UIScreen.main.bounds.width * 0.8, height: 180)
            .background(.white)
            .clipShape(RoundedRectangle(cornerRadius: 8))
            .padding([.leading, .trailing], 16)
        }
        .onTapGesture {
            isPresented = false
            self.presentationMode.wrappedValue.dismiss()
        }
    }
    func invalid()->Bool {
        return name.isEmpty ? false : true
    }
}

#Preview {
    ModalInputView(isPresented: .constant(true), name:.constant("名前を入力してください")
    )
}
