//
//  ContentView.swift
//  K8S-GUI
//
//  Created by 王镓耀 on 2020/2/22.
//  Copyright © 2020 王镓耀. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    var content:String
    
    init(content: String) {
        self.content = content;
    }

    var body: some View {
        Text(content)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}



struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(content: "1")
    }
}
