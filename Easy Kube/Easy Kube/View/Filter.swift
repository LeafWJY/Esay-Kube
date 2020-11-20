//
//  Filter.swift
//  Easy Kube
//
//  Created by 王镓耀 on 2020/10/10.
//  Copyright © 2020 codewjy. All rights reserved.
//

import SwiftUI

struct Filter: View {
    @EnvironmentObject private var userData: UserData
    
    @State var hovered = false
    
    var body: some View {
        HStack{
            HStack (alignment: .center,
                    spacing: 10) {
                        Image("filter")
                            .resizable()
                            .frame(width: 15, height: 15, alignment: .center)
                            .padding(.leading,10)
                TextField("Search \(userData.selectedTab)", text: $userData.filterKey, onEditingChanged: textChange, onCommit: textCommit)
//                        TextField ("Search \(userData.selectedTab)", text: $userData.filterKey,onEditchan)
//                            .foregroundColor(Color.black)
                            .textFieldStyle(PlainTextFieldStyle())
                            
                            
            }.frame(width: 200, height: 32, alignment: .center)
            .background(hovered ? Color.white : Color.gray.opacity(0.15) )
            .cornerRadius(16)
//            .onHoverAware(hover)
//            .background(Color(hex:0xf6f6f6), alignment: .center)
            Spacer()
        }
        .padding([.leading], 16)
        .padding([.top], 15)
        .padding(.bottom,15)
         .background(Color(hex:0xf6f6f6), alignment: .center)
    }
    
    
    func hover(_ hover:Bool){
//        withAnimation{
        self.hovered = hover
        
    }
    
    func textChange( change : Bool){
        
        print("change")
    }
    
    func textCommit(){
        
        print("change")
    }
}



//
//struct Filter_Previews: PreviewProvider {
//    static var previews: some View {
//        Filter()
//    }
//}
