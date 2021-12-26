//
//  SwiftUIView.swift
//  Easy Kube
//
//  Created by 王镓耀 on 2020/8/17.
//  Copyright © 2020 codewjy. All rights reserved.
//

import SwiftUI



struct NodeInfo: Codable {
    
    var items: [Node]
    
}

struct Node: Codable,Identifiable {
    

    var metadata: NodeMetadata
    var status: NodeStatus
    var id: String {
        return metadata.uid
    }
    
}

struct NodeMetadata: Codable{

    var name: String
    var uid: String
    var creationTimestamp: String
    var labels: NodeLabel
    
}
struct NodeLabel :Codable {

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
        print(roles)
        return roles;
    }
    
    enum CodingKeys:String,CodingKey {
           case master = "node-role.kubernetes.io/etcd"
           case etcd = "node-role.kubernetes.io/master"
           case worker = "node-role.kubernetes.io/worker"
       }
}

struct NodeStatus: Codable{

    var conditions: [NodeCondition]
    
    var ready: Bool {
        for t in conditions{
            if(t.type == "Ready" && t.status == "True"){
                return true
            }
        }
        return false
    }
}

struct NodeCondition: Codable{
    var type: String
    var status: String
}






