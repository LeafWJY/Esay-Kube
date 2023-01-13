//
//  IngressData.swift
//  Easy Kube
//
//  Created by 王镓耀 on 2023/1/13.
//  Copyright © 2023 codewjy. All rights reserved.
//

import Foundation


struct IngressData :Codable,Hashable {
    
    
    var items: [Ingress]
    var rowDatas: [RowData] {
        var list = [RowData]()
        for t in items{
            list.append(
                RowData(
                    id: t.id,
                    objectType: .ingress,
                    objectName: t.metadata.name,
                    objectNamespace: t.metadata.namespace,
                    objectAge: t.metadata.age,
                    objectStatus: t.spec.rules[0].host
                )
            )
        }
        return list
    }
    
}

struct Ingress: Codable,Identifiable,Hashable {
    

    var metadata: IngressMetadata
    var spec: IngressSpec
    var id: String {
        return metadata.uid
    }
    
}

struct IngressMetadata: Codable,Hashable{

    var name: String
    var uid: String
    var creationTimestamp: String
    var namespace: String
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


struct IngressSpec: Codable,Hashable{

    var rules: [IngressRule]
    
}

struct IngressRule: Codable,Hashable{
    
    var host:String

}



