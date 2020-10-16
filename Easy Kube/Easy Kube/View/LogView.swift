//
//  LogView.swift
//  Easy Kube
//
//  Created by 王镓耀 on 2020/9/30.
//  Copyright © 2020 codewjy. All rights reserved.
//

import SwiftUI

struct LogView: View {
    @State var log:String
    
    
    var body: some View {
        ScrollView {
            //            MapView(coordinate: landmark.locationCoordinate)
            //                .frame(height: 250)
            //                .overlay(
            //                    GeometryReader { proxy in
            //                        Button("Open in Maps") {
            //                            let destination = MKMapItem(placemark: MKPlacemark(coordinate: self.landmark.locationCoordinate))
            //                            destination.name = self.landmark.name
            //                            destination.openInMaps()
            //                        }
            //                        .frame(width: proxy.size.width, height: proxy.size.height, alignment: .bottomTrailing)
            //                        .offset(x: -10, y: -10)
            //                    }
            //            )
            
            VStack(alignment: .leading) {
                
                Divider()
                
                //                   TextField("请输入", text: $log)
                //                    .disabled(true)
                
                
                Text(self.log)
                    .multilineTextAlignment(.leading)
                    .lineLimit(nil)
                
            }
            .padding()
                //                .frame(maxWidth: 1000)
                .offset(x: 0, y: -20)
        }.frame(width: 400, height: 400)
    }
    
//    func getLog(){
//
//        print("getLog")
//
//
//        //1、创建URL
//        let url: URL = URL(string: "https://192.168.16.143:8443/api/v1/namespaces/hippius-dev/pods/hippius-activity-95890-6b45dd5658-dw8z7/log?container=hippius-activity-95890&follow=false&pretty=false&previous=false&timestamps=false")!
//
//        //2、创建URLRequest
//        let request: URLRequest = URLRequest(url: url)
//
//        //3、创建URLSession
//        let configration = URLSessionConfiguration.default
//        let session =  URLSession(configuration: configration,delegate: DataUtil(), delegateQueue:OperationQueue.main)
//
//        //4、URLSessionTask子类
//        let task: URLSessionDataTask = session.dataTask(with: request) { (data, response, error) in
//            if error == nil {
//
//
//                DispatchQueue.main.async {
//                    print("1")
//                    if let data = data {
//
//                        self.log = String(decoding: data, as: UTF8.self)
//                    }
//
//                }
//            }
//        }
//
//        //5、启动任务
//        task.resume()
//
//
//
//
//    }
    
    
}

struct LogView_Previews: PreviewProvider {
    static var previews: some View {
        LogView(log: "")
    }
}
