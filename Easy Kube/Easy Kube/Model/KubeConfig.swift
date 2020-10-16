//
//  KubeConfig.swift
//  Easy Kube
//
//  Created by 王镓耀 on 2020/10/13.
//  Copyright © 2020 codewjy. All rights reserved.
//

import SwiftUI

struct KubeConfig: Codable {
    var apiVersion: String
    var clusters: [Cluster]
    var contexts:[Context]
    var currentContext:String
    var kind: String
    var users:[User]
    
    
    
    enum CodingKeys:String,CodingKey {
        case apiVersion = "apiVersion"
        case clusters = "clusters"
        case contexts = "contexts"
        case currentContext = "current-context"
        case kind = "kind"
        case users = "users"
    }
}


struct Cluster: Codable {
    var cluster: ClusterInfo
    var name: String
   
}

struct ClusterInfo: Codable {
    var certificateAuthorityData: String
    var server: String
    
    enum CodingKeys:String,CodingKey {
           case certificateAuthorityData = "certificate-authority-data"
           case server = "server"
       }
}

struct Context: Codable {
    var context: ContextInfo
    var name: String
   
}

struct ContextInfo: Codable {
    var cluster: String
    var user: String

}

struct User: Codable {
    var user: UserInfo
    var name: String
   
}

struct UserInfo: Codable {
    var clientCertificateData: String
    var clientKeyData: String
    
    enum CodingKeys:String,CodingKey {
        case clientCertificateData = "client-certificate-data"
        case clientKeyData = "client-key-data"
    }
}

