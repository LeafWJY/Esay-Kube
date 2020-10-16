//
//  Pod.swift
//  Easy Kube
//
//  Created by 王镓耀 on 2020/9/30.
//  Copyright © 2020 codewjy. All rights reserved.
//

struct PodData: Codable,Hashable {
    var items:[Pod]
}



struct Pod: Codable,Hashable,Identifiable {
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


