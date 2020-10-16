//
//  KNodeRow.swift
//  Easy Kube
//
//  Created by 王镓耀 on 2020/8/17.
//  Copyright © 2020 codewjy. All rights reserved.
//

import SwiftUI

struct NodeRow: View {
    var node: KNode
    
    @State var hovered = false
    
    var body: some View {
        
        HStack(alignment: .center){
            Image("node")
                .resizable()
                .aspectRatio(1.0, contentMode: .fit)
                .frame(width: 32, height: 32)
                .fixedSize(horizontal: true, vertical: true)
                .cornerRadius(4.0)
                .padding(4)
            VStack(alignment: .leading){
                HStack() {
                    Text(node.metadata.name)
                        .fontWeight(.bold)
                        .truncationMode(.tail)
                        .frame(minWidth: 20)
                    Spacer()
                    Text(node.status.ready ? "Ready" : "NotReady")
                        .fontWeight(.bold)
                        .opacity(0.625)
                }
                
                HStack() {
                    Text(node.metadata.labels.role)
                        .font(.caption)
                        .opacity(0.625)
                        .truncationMode(.middle)
                    Button(action: {}, label:  {
                        Image("log" )
                            .resizable()
                            .frame(width: 16, height: 16)
                            .fixedSize(horizontal: true, vertical: true)
                    }).buttonStyle(ImgButtonStyle()).hidden()
                }
            }
            
            
        }
        .padding()
            
        .onHover(perform: openHover)
        .background(hovered ? Color.blue.opacity(0.3) : Color.clear.opacity(0.1))
        .frame(height:65)
        
    }
    
    
    
    
    func openHover(hover: Bool){
        withAnimation{
            self.hovered = hover
        }
        
    }
}

struct NodeRow_Previews: PreviewProvider {
    static var previews: some View {
        
        let metadata = NodeMetadata(name:"node name",uid:"12",creationTimestamp:"123",labels: NodeLabel(master: "master", etcd: "etcd", worker: "worker"))
        
        let nodeConditions = [NodeCondition(type: "Ready", status: "True")]
        let nodeStatus = NodeStatus(conditions: nodeConditions,nodeInfo:NodeInfo(kubeletVersion:"v1.15.5"))
        
        let node = KNode(metadata: metadata, status: nodeStatus)
        
        return NodeRow(node:  node)
    }
}
