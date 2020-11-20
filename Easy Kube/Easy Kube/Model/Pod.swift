//
//  Pod.swift
//  Easy Kube
//
//  Created by 王镓耀 on 2020/9/30.
//  Copyright © 2020 codewjy. All rights reserved.
//

import Foundation

struct PodData: Codable,Hashable {
    var items:[Pod]
    var rowDatas: [RowData] {
        var list = [RowData]()
        for t in items{
            list.append(
                RowData(
                    id: t.id,
                    objectType: .pod,
                    objectName: t.metadata.name,
                    objectNamespace: t.metadata.namespace,
                    objectAge: t.metadata.age,
                    objectStatus: "\(t.status.status) \(t.status.ready)"
                )
            )
        }
        return list
    }
}



struct Pod: Codable,Hashable,Identifiable{
    
    
    var metadata:PodMetadata
    var status:PodStatus
    var id: String {
           return metadata.uid
       }
}

struct PodMetadata: Codable,Hashable {
    var name:String
    var uid:String
    var namespace:String
    var creationTimestamp:String
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
        
        
        
        
//        return timeInterval.
        
//        return creationTimestamp
        
//        currentTime.timeIntervalSince(date)
        
//        Date().timeIntervalSince(date:date)

        
//        return date!
        
        
//        return creationTimestamp
    }
}
struct PodStatus: Codable,Hashable {
    var phase:String
    var podIP:String
    var hostIP:String
    var containerStatuses:[PodContainer]
    var status:String{
        if(phase == "Succeeded"){
            return "Completed"
        }else{
            return phase
        }
    }
    var ready:String{
        var readCount:Int = 0
        for container in containerStatuses {
            if container.ready{
                readCount+=1
            }
        }
        let totalCount = containerStatuses.count
        return "\(readCount) / \(totalCount)"
    }
}

struct PodContainer: Codable,Hashable {
    var ready: Bool
}


