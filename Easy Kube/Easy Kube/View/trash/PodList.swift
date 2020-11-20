//
//  PodList.swift
//  Easy Kube
//
//  Created by 王镓耀 on 2020/9/30.
//  Copyright © 2020 codewjy. All rights reserved.
//

import SwiftUI


struct PodList: View {
    @State var pods = [Pod]()
    @Binding var selectedPod: Pod?
    @EnvironmentObject private var userData: UserData

    
    var  request: URLRequest = URLRequest(url: URL(string: "https://192.168.16.143:8443/api/v1/pods")!)

    
    
    var body: some View {
         List {
            ForEach(pods){ pod in
                if self.userData.filterKey == "" || pod.metadata.name.contains(self.userData.filterKey) {
                PodRow(pod: pod).tag(pod)
                    .padding(.top, 0)
                    .padding(.bottom, 0)
                    .padding(.leading, -10)
                    .padding(.trailing, -10)
                }
                
            }
        }.frame(minWidth: 600, minHeight: 400)
            .onAppear(perform: startTimer)
         .onDisappear(perform: {
            print("disidtsidasdasdasd")
         })
         
    }

    
    
     func startTimer() {
        self.getPod()
        Timer.scheduledTimer(withTimeInterval: 2, repeats: true, block: { timer in
            self.getPod()
        })
    }
    
    
    
    
    func getPod(){

//        //1、创建URL
//        let url: URL = URL(string: "https://192.168.16.143:8443/api/v1/pods")!
//
//        //2、创建URLRequest
//        let request: URLRequest = URLRequest(url: url)
        
        //3、创建URLSession
//        let configration = URLSessionConfiguration.default
//        let session =  URLSession(configuration: configration,delegate: sessionDelegate, delegateQueue:OperationQueue.main)

        //4、URLSessionTask子类
        let task: URLSessionDataTask = RestService.sharedSession.dataTask(with: request) { (data, response, error) in
            if error == nil {

                    if let data = data {
                        if let decodedResponse = try? JSONDecoder().decode(PodData.self, from: data) {
                            //得到数据，回到主线程
                            DispatchQueue.main.async {
                                //更新界面
                                self.pods = decodedResponse.items
                            }
                            //完成
                            return
                        }
                        
                    }

            }
        }
        
        //5、启动任务
        task.resume()
        
    }
    
}


//struct PodList_Previews: PreviewProvider {
//    static var previews: some View {
//        var rows = [Pod]()
//        for index in 1...10 {
//            let metadata = PodMetadata(name: "pod name", uid: String(index), namespace: "hippius-dev")
//            let podStatus = PodStatus(phase: "Running", podIP: "10.244.3.190", hostIP: "192.168.16.148", containerStatuses: [PodContainer(ready: true)])
//            let pod = Pod(metadata: metadata, status: podStatus)
//            rows.append(pod)
//        }
//        return PodList(pods:rows,selectedPod: .constant(rows[1]))
//    }
//}
