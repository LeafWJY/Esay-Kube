//
//  IdentityUtil.swift
//  Easy Kube
//
//  Created by 王镓耀 on 2020/9/29.
//  Copyright © 2020 codewjy. All rights reserved.
//

import Cocoa
import Yams
class IdentityUtil{
    
    private static var identity: IdentityAndTrust?
    
    private static var kubeConfig: KubeConfig?
    
    private static var currentClientCertificate = ""
    private static var currentClientKey = ""
    
    public static func loadIdentity() -> IdentityAndTrust{
        
        if(identity != nil){
            return identity!
        }else{
            identity = extractIdentity()
            return identity!
        }
        
    }
    
    //获取客户端证书相关信息
    static func  extractIdentity() -> IdentityAndTrust{
        
        loadConfig()
        loadKey(keyBase64: currentClientKey)
        return loadPem(pem: currentClientCertificate)
    }
    
    
    
    static func loadConfig(){
        do {
            
            let url = FileManager.default.homeDirectoryForCurrentUser.appendingPathComponent(".kube/config")
            let configData = try Data(contentsOf: url)
            let configStr = String(data: configData, encoding: .utf8)!
            let decoder = YAMLDecoder()
            let kubeconfig = try decoder.decode(KubeConfig.self, from: configStr)
            
            //            let current = kubeconfig.currentContext
            var currentCluster = ""
            var currentUser = ""
            for context in kubeconfig.contexts{
                if context.name == kubeconfig.currentContext{
                    currentCluster = context.context.cluster
                    currentUser = context.context.user
                    break;
                }
            }
            for cluster in kubeconfig.clusters{
                if cluster.name == currentCluster{
                    currentCluster = cluster.cluster.server
                    break;
                }
            }

            
            for user in kubeconfig.users{
                if user.name == currentUser{
                    currentClientCertificate = convertData(data: user.user.clientCertificateData)
                    currentClientKey = convertData(data: user.user.clientKeyData)
                    break;
                }
            }
            
//            print(currentClientKey)
            
        } catch {
            print(error)
        }
        
        
        
        
        
    }
    
    static func convertData(data:String)->String{
        
        let str = String(data: Data(base64Encoded: data)!, encoding: String.Encoding.utf8)
        
        var result = ""
        for line in str!.components(separatedBy: "\n"){
            if !line.starts(with: "--"){
                result.append(line)
            }
        }
        return result
    }
    
    
    
    
    static func loadPem(pem:String)-> IdentityAndTrust{

        let certData = Data(base64Encoded: pem)!
        let certificate: SecCertificate = SecCertificateCreateWithData(nil,certData as CFData)!
        
        var identity: SecIdentity?
        SecIdentityCreateWithCertificate(nil, certificate, &identity)
        
        let certArray = [ certificate ]
        
        var trust: SecTrust?
        SecTrustCreateWithCertificates(certArray as AnyObject,SecPolicyCreateBasicX509(),&trust)
        return IdentityAndTrust(identityRef: identity!,trust:trust!,certArray:  certArray)
        
    }
    
    static func loadKey(keyBase64:String){
        let keyData = Data(base64Encoded: keyBase64)!
        let tag = "com.wjy.Easy-Kube.mykey".data(using: .utf8)!
        
        let key = SecKeyCreateWithData(keyData as NSData, [
            kSecAttrKeyType: kSecAttrKeyTypeRSA,
            kSecAttrApplicationTag as String: tag,
            kSecAttrKeyClass: kSecAttrKeyClassPrivate,
            ] as NSDictionary, nil)!
        let addquery: [String: Any] = [kSecClass as String: kSecClassKey,
                                       kSecAttrApplicationTag as String: tag,
                                       kSecAttrKeyType as String:kSecAttrKeyTypeRSA,
                                       kSecValueRef as String: key]
        
        SecItemAdd(addquery as CFDictionary, nil)
        // SecItemDelete(addquery as CFDictionary)
    }
    
    
}

//认证数据结构体
struct IdentityAndTrust {
    var identityRef:SecIdentity
    var trust:SecTrust
    var certArray:[SecCertificate]
}



