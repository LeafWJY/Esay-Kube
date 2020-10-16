//
//  Deployment.swift
//  Easy Kube
//
//  Created by 王镓耀 on 2020/10/12.
//  Copyright © 2020 codewjy. All rights reserved.
//



struct DeployData: Codable,Hashable {
   var items:[Deploy]
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
}
struct DeployStatus: Codable,Hashable {
    var replicas:Int?
    var availableReplicas:Int?
    var ready:String{
        return "\(availableReplicas == nil ? 0:availableReplicas!) / \(replicas == nil ? 0:replicas!)"
    }
}

