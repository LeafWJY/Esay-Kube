//
//  SwiftUIView.swift
//  Easy Kube
//
//  Created by 王镓耀 on 2020/8/17.
//  Copyright © 2020 codewjy. All rights reserved.
//

import SwiftUI



struct NodeData: Codable,Hashable {
    
    var items: [KNode]
    
}

struct KNode: Codable,Identifiable,Hashable {
    

    var metadata: NodeMetadata
    var status: NodeStatus
    var id: String {
        return metadata.uid
    }
    
}

struct NodeMetadata: Codable,Hashable{

    var name: String
    var uid: String
    var creationTimestamp: String
    var labels: NodeLabel
    
}
struct NodeLabel :Codable ,Hashable{

    var master: String?
    var etcd: String?
    var worker: String?
    var role: String {
        var roles = String();
        if(master != nil){
            roles.append("master")
            roles.append(" ")
        }
        if(etcd != nil){
            roles.append("etcd")
            roles.append(" ")
        }
        if(worker != nil){
            roles.append("worker")
            roles.append(" ")
        }
        return roles;
    }
    
    enum CodingKeys:String,CodingKey {
           case master = "node-role.kubernetes.io/etcd"
           case etcd = "node-role.kubernetes.io/master"
           case worker = "node-role.kubernetes.io/worker"
       }
}

struct NodeStatus: Codable,Hashable{

    var conditions: [NodeCondition]
    
    var nodeInfo: NodeInfo
    
    var ready: Bool {
        for t in conditions{
            if(t.type == "Ready" && t.status == "True"){
                return true
            }
        }
        return false
    }
}

struct NodeInfo:Hashable,Codable{
    
    var kubeletVersion:String
    
}

struct NodeCondition: Hashable,Codable{
    var type: String
    var status: String
}






