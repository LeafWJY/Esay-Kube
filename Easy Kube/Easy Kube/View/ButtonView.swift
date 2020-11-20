//
//  TabButton.swift
//  Easy Kube
//
//  Created by 王镓耀 on 2020/10/16.
//  Copyright © 2020 codewjy. All rights reserved.
//

import SwiftUI


struct TabButton: View {
    
    @EnvironmentObject private var userData: UserData
    @State var hovered = false
    let tab:String
    let icon:String
    
    var body: some View {
//        HStack {
            Button(action: selected) {
                HStack{
                    Image(icon)
                        .resizable()
                        .aspectRatio(1.0, contentMode: .fit)
                        .frame(width: 20, height: 20)
//                        .colorMultiply(Color(hex: 0x61bdd5))
                        .colorMultiply(tab == userData.selectedTab ? Color.white : Color(hex: 0x61bdd5))
                    Text(tab)
                        .fontWeight(.bold)
                        .foregroundColor(tab == userData.selectedTab ? Color.white : Color.black.opacity(0.6))
                    Spacer()
                }
                .frame(width:140,height: 30)
                .padding(.leading,5)
//                .padding([.top,.bottom],)
                .background(tab == userData.selectedTab ? Color(hex:0x66CCFF) : hovered ? Color.gray.opacity(0.3) : Color.clear)
                .cornerRadius(5)
                .onHoverAware(hover)
                .overlay(AcceptingFirstMouse())
            }
            .buttonStyle(PlainButtonStyle())
//            .padding([.top,.bottom],-2)
//        }
    }
    
    func selected(){
        userData.selectedTab = tab
    }
    
    func hover(_ hover:Bool){
        withAnimation{
            self.hovered = hover
        }
    }
}

struct CellButton: View {
    
    @State var hovered = false
    let action:()->Void
    
    
    let img:String
    let text:String
    
    
    var body: some View {
        
        Button(action: action, label:  {
            VStack{
                Image(img)
                    .resizable()
                    .frame(width: 16, height: 16)
                    .fixedSize(horizontal: true, vertical: true)
                    .colorMultiply(hovered ? Color(hex:0x66CCFF) : Color.black.opacity(0.8))
                Text(text)
                    .font(.system(size: 8))
                    .padding(.top,-5)
                    .foregroundColor(Color.black)
            }
//            .background(Color.clear)
            .overlay(AcceptingFirstMouse())
        }).onHoverAware(hover)
        .buttonStyle(ImgButtonStyle())
    }
    
    func hover(_ hover:Bool){
        self.hovered = hover
    }
    
    
    
    
    
    
    
    
    
}



