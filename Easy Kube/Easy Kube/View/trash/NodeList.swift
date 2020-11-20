//
//  NodeListView.swift
//  Easy Kube
//
//  Created by 王镓耀 on 2020/8/17.
//  Copyright © 2020 codewjy. All rights reserved.
//

import SwiftUI


struct NodeList: View  {
    @State var nodes = [KNode]()
    @Binding var selectedNode: KNode?
    @EnvironmentObject private var userData: UserData
    var  request: URLRequest = URLRequest(url: URL(string: "https://192.168.16.143:8443/api/v1/nodes")!)
    
    var body: some View {
        //        List(selection: $selectedNode) {
        List {
            ForEach(nodes){ node in
                
                if self.userData.filterKey == "" || node.metadata.name.contains(self.userData.filterKey) {
                    NodeRow(node: node).tag(node)
                        .padding(.top, 0)
                        .padding(.bottom, 0)
                        .padding(.leading, -10)
                        .padding(.trailing, -10)
                }
                
            }
        }.frame(minWidth: 600, minHeight: 400)
        .onAppear(perform: startTimer)
    }
    
    func startTimer() {
        self.getNode()
        Timer.scheduledTimer(withTimeInterval: 2, repeats: true, block: { timer in
            self.getNode()
        })
    }
    
    
    func getNode(){
        print("getNode")
        let task: URLSessionDataTask = RestService.sharedSession.dataTask(with: request) { (data, response, error) in
            if error == nil {
                if let data = data {
                    if let decodedResponse = try? JSONDecoder().decode(NodeData.self, from: data) {
                        //得到数据，回到主线程
                        DispatchQueue.main.async {
                            //更新界面
                            self.nodes = decodedResponse.items
                        }
                        //完成
                        return
                    }
                    
                }
                
                
            }
        }
        task.resume()
    }
}













//struct NodeList_Previews: PreviewProvider {
//    static var previews: some View {
//        
//        var rows = [KNode]()
//        for index in 1...10 {
//            
//            let metadata = NodeMetadata(name:"node name",uid: String(index),creationTimestamp:"123",labels: NodeLabel(master: "master", etcd: "etcd", worker: "worker"))
//            
//            let nodeConditions = [NodeCondition(type: "Ready", status: "True")]
//            let nodeStatus = NodeStatus(conditions: nodeConditions,nodeInfo:NodeInfo(kubeletVersion:"v1.15.5"))
//            
//            let node = KNode(metadata: metadata, status: nodeStatus)
//            
//            rows.append(node)
//        }
//        return NodeList(nodes:rows,selectedNode: .constant(rows[1]))
//    }
//}
