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
    @State var detailHovered = false

    var body: some View {
        
        HStack(alignment: .center){
            Image("node")
            .resizable()
            .aspectRatio(1.0, contentMode: .fit)
            .frame(width: 40, height: 40)
            .fixedSize(horizontal: true, vertical: true)
            .cornerRadius(4.0)
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
                    Spacer()
                    Button(action: showDetail, label:  {
                        VStack{
                            Image("detail")
                                .resizable()
                                .frame(width: 16, height: 16)
                                .fixedSize(horizontal: true, vertical: true)
                                .colorMultiply(detailHovered ? Color(hex:0x66CCFF) : Color.black.opacity(0.8))
                            Text("desc")
                                .font(.system(size: 8))
                                .padding(.top,-5)
                                .foregroundColor(Color.black)
                        }.background(hovered ? Color(hex:0x66CCFF,alpha: 0.3) : Color.clear)
                        .overlay(AcceptingFirstMouse())
                    }).onHoverAware( detailHovered)
                    .buttonStyle(ImgButtonStyle())
                }
            }
            
            
        }
        .padding()
            
        .onHoverAware( openHover)
        .background(hovered ? Color(hex:0x66CCFF,alpha: 0.3)  : Color.clear.opacity(0.1))
        .frame(height:65)
        
    }
    
    func showDetail(){
        let command = """
        kubectl describe node \(node.metadata.name)
        while [ 1 ]; do
        echo -n "按Q退出"
        read name
        if [[ $name = "q" || $name = "Q" ]]; then
           break
        fi
        done
        """
        
        
        Terminal.execute(command: command)
    }
    
    
    func detailHovered(hover: Bool){
        self.detailHovered = hover
    }
    
    
    func openHover(hover: Bool){
        withAnimation{
            self.hovered = hover
        }
        
    }
}

//struct NodeRow_Previews: PreviewProvider {
//    static var previews: some View {
//        
//        let metadata = NodeMetadata(name:"node name",uid:"12",creationTimestamp:"123",labels: NodeLabel(master: "master", etcd: "etcd", worker: "worker"))
//        
//        let nodeConditions = [NodeCondition(type: "Ready", status: "True")]
//        let nodeStatus = NodeStatus(conditions: nodeConditions,nodeInfo:NodeInfo(kubeletVersion:"v1.15.5"))
//        
//        let node = KNode(metadata: metadata, status: nodeStatus)
//        
//        return NodeRow(node:  node)
//    }
//}

