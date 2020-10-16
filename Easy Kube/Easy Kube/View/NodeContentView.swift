//
//  ContentView.swift
//  K8S-GUI
//
//  Created by 王镓耀 on 2020/2/22.
//  Copyright © 2020 王镓耀. All rights reserved.
//

import SwiftUI

struct NodeContentView: View {
    var nodes = [KNode]()
    
    @State private var selectedKNode: KNode?
    
    init(nodes: [KNode]) {
        self.nodes = nodes;
    }
    
    var body: some View {
        NavigationView {
            NodeList(nodes:nodes,selectedNode: $selectedKNode)
            if(selectedKNode != nil){
                Button(action: openTerminal, label:  {Text("Press Me")})
            }
            
        }
        .frame(minWidth: 700, minHeight: 400)
        
    }
    
    func openTerminal(){
        let task = Process()
        task.executableURL = URL(fileURLWithPath: "/usr/local/bin/kubectl")
        do {
            try task.run()
        } catch {
            print("error")
        }
    }
    
    
}





struct NodeContentView_Previews: PreviewProvider {
    static var previews: some View {
        var rows = [KNode]()
        for index in 1...10 {
            
            let metadata = NodeMetadata(name:"node name",uid: String(index),creationTimestamp:"123",labels: NodeLabel(master: "master", etcd: "etcd", worker: "worker"))
            
            let nodeConditions = [NodeCondition(type: "Ready", status: "True")]
            let nodeStatus = NodeStatus(conditions: nodeConditions,nodeInfo:NodeInfo(kubeletVersion:"v1.15.5"))
            
            let node = KNode(metadata: metadata, status: nodeStatus)
            
            rows.append(node)
        }
        
        return NodeContentView(nodes: rows)
    }
}
