//
//  Deployment.swift
//  Easy Kube
//
//  Created by 王镓耀 on 2020/10/12.
//  Copyright © 2020 codewjy. All rights reserved.
//

import Foundation

struct DeployData: Codable,Hashable {
    var items:[Deploy]
    var rowDatas: [RowData] {
        var list = [RowData]()
        for t in items{
            list.append(
                RowData(
                    id: t.id,
                    objectType: .deployment,
                    objectName: t.metadata.name,
                    objectNamespace: t.metadata.namespace,
                    objectAge: t.metadata.age,
                    objectStatus: t.status.ready
                )
            )
        }
        return list
    }
}


struct Deploy: Codable,Hashable,Identifiable {
    var metadata:DeployMetadata
    var status:DeployStatus
    var id: String {
           return metadata.uid
       }
}

struct DeployMetadata: Codable,Hashable {
    var name:String
    var uid:String
    var namespace:String
    var creationTimestamp: String
    var age:String {
        let formatter = DateFormatter()
        formatter.locale = Locale.init(identifier: "zh_CN")
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        let date = formatter.date(from: creationTimestamp)
        
        let currentTime = Date()
        let timeInterval = Int(currentTime.timeIntervalSince(date!))
        if timeInterval < 60 {
            return "\(timeInterval)s"
        } else if timeInterval < 3600 {
            return "\(timeInterval/60)m"
        } else if timeInterval < 3600*24 {
            return "\(timeInterval/3600)h"
        } else {
            return "\(timeInterval/3600/24)d"
        }
    }
}
struct DeployStatus: Codable,Hashable {
    var replicas:Int?
    var availableReplicas:Int?
    var ready:String{
        return "\(availableReplicas == nil ? 0:availableReplicas!) / \(replicas == nil ? 0:replicas!)"
    }
}

