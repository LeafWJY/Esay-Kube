//
//  StatefulSetData.swift
//  Easy Kube
//
//  Created by 王镓耀 on 2023/1/13.
//  Copyright © 2023 codewjy. All rights reserved.
//
import Foundation

struct StatefulSetData: Codable,Hashable {
    var items:[StatefulSet]
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


struct StatefulSet: Codable,Hashable,Identifiable {
    var metadata:StatefulSetMetadata
    var status:StatefulSetStatus
    var id: String {
           return metadata.uid
       }
}

struct StatefulSetMetadata: Codable,Hashable {
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
struct StatefulSetStatus: Codable,Hashable {
    var replicas:Int?
    var readyReplicas:Int?
    var ready:String{
        return "\(readyReplicas == nil ? 0:readyReplicas!) / \(replicas == nil ? 0:replicas!)"
    }
}

