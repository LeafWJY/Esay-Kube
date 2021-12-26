//
//  NodeListView.swift
//  Easy Kube
//
//  Created by 王镓耀 on 2020/8/17.
//  Copyright © 2020 codewjy. All rights reserved.
//

import SwiftUI


struct NodeList: View  {
    @State var nodes = [Node]()
    
    @State var isShowing: Bool = false

    var body: some View {
        
        NavigationView {
            List(nodes) { node in
                NodeRow(node: node)
                
            }
            .navigationBarTitle("Nodes")
        }            
        .background(PullRefresh(action: {
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                self.isShowing = false
                self.loadData()
            }
        }, isShowing: $isShowing))
        .onAppear(perform: loadData)
        
        
        
        
        
        
        //        NavigationView {
        //            List(nodes) { node in
        //                NodeRow(node: node)
        //
        //            }
        //            .navigationBarTitle(Text("Nodes"))
        //            .onAppear(perform: loadData)
        //        }
    }
    
    func loadData() {
        
        //请求url
        guard let url = URL(string: "https://www.fastmock.site/mock/236e17eb17086d3142fa119490e3f11d/easy-kube/nodes") else {
            print("Invalid URL")
            return
        }
//        guard let url = URL(string: "https://192.168.16.143:8443/api/v1/pods") else {
//                   print("Invalid URL")
//                   return
//               }
        let request = URLRequest(url: url)
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let data = data {
                if let decodedResponse = try? JSONDecoder().decode(NodeInfo.self, from: data) {
                    //得到数据，回到主线程
                    DispatchQueue.main.async {
                        //更新界面
                        self.nodes = decodedResponse.items
                    }
                    //完成
                    return
                }
            }
            
            //报错输出
            print("错误信息: \(error.debugDescription)")
        }.resume()
    }
}





//struct NodeList_Previews: PreviewProvider {
//    static var previews: some View {
//        //        let row =  Node(id:1 , metadata:NodeMetadata(name:"121",uid:"12",creationTimestamp:"123"))
//        //        var rows = [Node]()
//        //        rows.append(row)
//        //
//        //        for index in 1...500 {
//        //            rows.append(Node(id:index , metadata:NodeMetadata(name:"121",uid:"12",creationTimestamp:"123")))
//        //        }
////        return NodeList()
//    }
//}
