//
//  DataUtil.swift
//  Easy Kube
//
//  Created by 王镓耀 on 2020/9/29.
//  Copyright © 2020 codewjy. All rights reserved.
//

import Cocoa

class ClientCertificateDelegate: NSObject, NSApplicationDelegate,URLSessionDelegate {
    
    var identity: IdentityAndTrust!
    
    func urlSession(_ session: URLSession, didReceive challenge: URLAuthenticationChallenge,
                    completionHandler: @escaping (URLSession.AuthChallengeDisposition,
        URLCredential?) -> Void) {
        //认证服务器（这里不使用服务器证书认证，只需地址是我们定义的几个地址即可信任）
        if challenge.protectionSpace.authenticationMethod
            == NSURLAuthenticationMethodServerTrust {
//            print("服务器认证！")
            let credential = URLCredential(trust: challenge.protectionSpace.serverTrust!)
            completionHandler(.useCredential, credential)
        }else if challenge.protectionSpace.authenticationMethod
            == NSURLAuthenticationMethodClientCertificate {
//            print("客户端证书认证！")
            //获取客户端证书相关信息
            if self.identity == nil{
                self.identity = IdentityUtil.loadIdentity()
            }
            let urlCredential:URLCredential = URLCredential(
                identity: self.identity.identityRef,
                certificates: nil,
                persistence: .none)
            completionHandler(.useCredential, urlCredential)
        }
    }
    
}
