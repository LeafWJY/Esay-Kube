//
//  ServiceList.swift
//  Easy Kube
//
//  Created by 王镓耀 on 2020/10/13.
//  Copyright © 2020 codewjy. All rights reserved.
//

import SwiftUI

struct ServiceList: View {
     @State var services = [Service]()
        @Binding var selectedService: Service?
        @EnvironmentObject private var userData: UserData
        
//        var sessionDelegate = ClientCertificateDelegate()
    

    
    var  request: URLRequest = URLRequest(url: URL(string: "https://192.168.16.143:8443/api/v1/services")!)
        
        
        
        var body: some View {
//            List(selection: $selectedService) {
    //            Filter()
             List {
                ForEach(services){ service in
                    
                    if self.userData.filterKey == "" || service.metadata.name.contains(self.userData.filterKey) {
                    ServiceRow(service: service).tag(service)
                        .padding(.top, 0)
                        .padding(.bottom, 0)
                        .padding(.leading, -10)
                        .padding(.trailing, -10)
                    }
                    
                }
            }.frame(minWidth: 600, minHeight: 400)
                .onAppear(perform: startTimer)
    //         .listStyle(SidebarListStyle())
            
        }
        
        
         func startTimer() {
            self.getService()
            Timer.scheduledTimer(withTimeInterval: 2, repeats: true, block: { timer in
                self.getService()
            })
        }
        
        
        
        
        func getService(){
//            //1、创建URL
//            let url: URL = URL(string: "https://192.168.16.143:8443/api/v1/services")!
//
//            //2、创建URLRequest
//            let request: URLRequest = URLRequest(url: url)
//
//            //3、创建URLSession
//            let configration = URLSessionConfiguration.default
//            let session =  URLSession(configuration: configration,delegate: sessionDelegate, delegateQueue:OperationQueue.main)
            
            //4、URLSessionTask子类
            let task: URLSessionDataTask = RestService.sharedSession.dataTask(with: request) { (data, response, error) in
                if error == nil {
                    DispatchQueue.main.async {
                        if let data = data {
                            if let decodedResponse = try? JSONDecoder().decode(ServiceData.self, from: data) {
                                //得到数据，回到主线程
                                DispatchQueue.main.async {
                                    //更新界面
                                    self.services = decodedResponse.items
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

//struct ServiceList_Previews: PreviewProvider {
//    static var previews: some View {
//        ServiceList()
//    }
//}
