//
//  DeploymentList.swift
//  Easy Kube
//
//  Created by 王镓耀 on 2020/10/12.
//  Copyright © 2020 codewjy. All rights reserved.
//

import SwiftUI

struct DeployList: View {
    @State var deploys = [Deploy]()
    @Binding var selectedDeploy: Deploy?
    @EnvironmentObject private var userData: UserData
    
//    var sessionDelegate = ClientCertificateDelegate()
    
    
    var  request: URLRequest = URLRequest(url: URL(string: "https://192.168.16.143:8443/apis/apps/v1beta2/deployments")!)
    
    
    var body: some View {
//        List(selection: $selectedDeploy) {
         List {
            ForEach(deploys){ deploy in
                if self.userData.filterKey == "" || deploy.metadata.name.contains(self.userData.filterKey) {
                    DeployRow(deploy: deploy)
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
        self.getDeployment()
        Timer.scheduledTimer(withTimeInterval: 2, repeats: true, block: { timer in
            self.getDeployment()
        })
    }
    
    func getDeployment(){
//        //1、创建URL
//        let url: URL = URL(string: "https://192.168.16.143:8443/apis/apps/v1beta2/deployments")!
//
//        //2、创建URLRequest
//        let request: URLRequest = URLRequest(url: url)
//
//        //3、创建URLSession
//        let configration = URLSessionConfiguration.default
//        let session =  URLSession(configuration: configration,delegate: sessionDelegate, delegateQueue:OperationQueue.main)
        
        //4、URLSessionTask子类
        let task: URLSessionDataTask = RestService.sharedSession.dataTask(with: request) { (data, response, error) in
            if error == nil {
                DispatchQueue.main.async {
                    if let data = data {
                        if let decodedResponse = try? JSONDecoder().decode(DeployData.self, from: data) {
                            //得到数据，回到主线程
                            DispatchQueue.main.async {
                                //更新界面
                                self.deploys = decodedResponse.items
                            }
                            //完成
                            return
                        }
                        
                    }
                    
                }
            }
        }
        
        //5、启动任务
        task.resume()
        
    }
}

//struct DeploymentList_Previews: PreviewProvider {
//    static var previews: some View {
//        var rows = [Deploy]()
//        for index in 1...10 {
//            let metadata = DeployMetadata(name: "pod name", uid: String(index), namespace: "hippius-dev")
//            let deployStatus = DeployStatus(availableReplicas: 1)
//            let deploy = Deploy(metadata: metadata, status: deployStatus)
//            rows.append(deploy)
//        }
//        return DeployList(deploys: rows,selectedDeploy: .constant(rows[1]))
//    }
//}
