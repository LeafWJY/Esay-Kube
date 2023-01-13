//
//  ListView.swift
//  Easy Kube
//
//  Created by 王镓耀 on 2020/10/21.
//  Copyright © 2020 codewjy. All rights reserved.
//

import SwiftUI

struct ListView: View {
    @State var rows = [RowData]()
    @EnvironmentObject private var userData: UserData
    
    let objectType: ObjectType
    

    
    
    
    var body: some View {
        List {
            ForEach(rows){ row in
                if self.userData.filterKey == "" || row.objectName.contains(self.userData.filterKey) {
                    RowView(row: row)
                        .padding(.top, 0)
                        .padding(.bottom, 0)
                        .padding(.leading, -10)
                        .padding(.trailing, -10)
                }
            }
        }.frame(minWidth: 600, minHeight: 400)
        .onAppear(perform: startTimer)
//        .onNSView(added: {nsview in
//            let root = nsview.subviews[0] as! NSScrollView
//            root.hasVerticalScroller = false
//            root.hasHorizontalScroller = false
//          })
        
    }
    
    
    
    func startTimer() {
        self.getData(objectType)
        Timer.scheduledTimer(withTimeInterval: 2, repeats: true, block: { timer in
            self.getData(objectType)
        })
    }
    
    
    
    
    func getData(_ type:ObjectType){
        
        var  request: URLRequest
        switch type {
        case .pod:
            request = URLRequest(url: URL(string: "https://192.168.16.144:6443/api/v1/pods")!)
        case .deployment:
            request = URLRequest(url: URL(string: "https://192.168.16.144:6443/apis/apps/v1/deployments")!)
        case .node:
            request = URLRequest(url: URL(string: "https://192.168.16.144:6443/api/v1/nodes")!)
        case .service:
            request = URLRequest(url: URL(string: "https://192.168.16.144:6443/api/v1/services")!)
        case .ingress:
            request = URLRequest(url: URL(string: "https://192.168.16.144:6443/apis/networking.k8s.io/v1/ingresses")!)
        case .statefulSet:
            request = URLRequest(url: URL(string: "https://192.168.16.144:6443/apis/apps/v1/statefulsets")!)
        default:
            return
        }
        
        let task: URLSessionDataTask = RestService.sharedSession.dataTask(with: request) { (data, response, error) in
            if error == nil {
                if let data = data {
                    do{
                        var rowData : [RowData]
                        switch type {
                        case .pod:
                            rowData = try JSONDecoder().decode(PodData.self, from: data).rowDatas
                        case .deployment:
                            rowData = try JSONDecoder().decode(DeployData.self, from: data).rowDatas
                        case .node:
                            rowData = try JSONDecoder().decode(NodeData.self, from: data).rowDatas
                        case .service:
                            rowData = try JSONDecoder().decode(ServiceData.self, from: data).rowDatas
                        case .ingress:
                            rowData = try JSONDecoder().decode(IngressData.self, from: data).rowDatas
                        case .statefulSet:
                            rowData = try JSONDecoder().decode(StatefulSetData.self, from: data).rowDatas
                        default:
                            return
                        }
                        
                        //得到数据，回到主线程
                        DispatchQueue.main.async {
                            //更新界面
                            self.rows = rowData
                        }
                        
                        //完成
                        return
                    }catch{
                        print(error)
                    }
                    
                }
                
            }
        }
        
        //5、启动任务
        task.resume()
        
    }
}
