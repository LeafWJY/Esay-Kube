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
    
    var body: some View {
        HStack{
            HStack (alignment: .center,
                    spacing: 10) {
                        Image("filter")
                            .resizable()
                            .frame(width: 25, height: 25, alignment: .center)
                            .padding([.leading], 22)
                        TextField ("搜索\(userData.selectedTab)", text: $userData.filterKey)
                            .foregroundColor(Color.blue)
                            .textFieldStyle(PlainTextFieldStyle())
            }
            .padding([.top], 20)
            .padding(.bottom,10)
            .background(Color.white.opacity(0.1), alignment: .center)
        }
    }
}

extension NSTextField {
    open override var focusRingType: NSFocusRingType {
        get { .none }
        set { }
    }
}


struct Filter_Previews: PreviewProvider {
    static var previews: some View {
        Filter()
    }
}
