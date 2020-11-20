//
//  SwiftUIView.swift
//  Easy Kube
//
//  Created by 王镓耀 on 2020/8/17.
//  Copyright © 2020 codewjy. All rights reserved.
//

import SwiftUI



struct ServiceData: Codable,Hashable {
    
    var items: [Service]
    var rowDatas: [RowData] {
        var list = [RowData]()
        for t in items{
            list.append(
                RowData(
                    id: t.id,
                    objectType: .service,
                    objectName: t.metadata.name,
                    objectNamespace: t.metadata.namespace,
                    objectAge: nil,
                    objectStatus: t.spec.port
                )
            )
        }
        return list
    }
    
}

struct Service: Codable,Identifiable,Hashable {
    

    var metadata: ServiceMetadata
    var spec: ServiceSpec
    var id: String {
        return metadata.uid
    }
    
}

struct ServiceMetadata: Codable,Hashable{

    var name: String
    var uid: String
    var creationTimestamp: String
    var namespace: String
    
}


struct ServiceSpec: Codable,Hashable{

    var ports: [ServicePort]
    
    var type: String
    
    var clusterIP: String
    
    var port: String {
        
         for p in ports {
            if p.port != nil{
                if p.nodePort != nil{
                    return "\(p.port!):\(p.nodePort!)/\(p.serviceProtocol)"
                }else{
                    return "\(p.port!)/\(p.serviceProtocol)"
                }
            }
         }
        return ""
    }
    
}

struct ServicePort: Codable,Hashable{
    
    var serviceProtocol:String
    var port:Int?
    var nodePort:Int?
    
    enum CodingKeys:String,CodingKey {
        case serviceProtocol = "protocol"
        case port = "port"
        case nodePort = "nodePort"
    }

}








