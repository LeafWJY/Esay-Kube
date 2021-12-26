//
//  NodeRow.swift
//  Easy Kube
//
//  Created by 王镓耀 on 2020/8/17.
//  Copyright © 2020 codewjy. All rights reserved.
//

import SwiftUI

struct NodeRow: View {
    var node: Node
    
    var body: some View {
            VStack(alignment: .leading){
                HStack {
                    Text(node.metadata.name)
                        .fontWeight(.bold)
                        .multilineTextAlignment(.leading)
                    Spacer()
                    Text(node.status.ready ? "Ready" : "NotReady")
                        .fontWeight(.heavy)
                        .foregroundColor(node.status.ready ? Color.green : Color.red)
                }
                
                Text(node.metadata.labels.role)
                    .fontWeight(.light)
                    
                
            }
           
            
        
    }
}

//struct NodeRow_Previews: PreviewProvider {
//    static var previews: some View {
//        NodeRow(node:  Node(metadata:  NodeMetadata(name:"node1",uid:"12",creationTimestamp:"123",labels: NodeLabel())))
//    }
//}
