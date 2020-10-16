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
            
            print(currentCluster)
            
            var currentServer = ""
            
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
            
            print(currentClientKey)
            
        } catch {
            print(error)
        }
        
        
        
        
        
    }
    
    static func convertData(data:String)->String{
        
        var str = String(data: Data(base64Encoded: data)!, encoding: String.Encoding.utf8)
        
        var result = ""
        for line in str!.components(separatedBy: "\n"){
            if !line.starts(with: "--"){
                result.append(line)
            }
        }
        return result
    }
    
    
    
    
    static func loadPem(pem:String)-> IdentityAndTrust{
        
//        let pem =
//        "MIIC/jCCAeagAwIBAgIJAOU2AKu2m7+WMA0GCSqGSIb3DQEBCwUAMBUxEzARBgNVBAMMCmt1YmVybmV0ZXMwHhcNMTkxMjExMTIzMTE5WhcNMjkxMjA4MTIzMTE5WjA0MRkwFwYDVQQDDBBrdWJlcm5ldGVzLWFkbWluMRcwFQYDVQQKDA5zeXN0ZW06bWFzdGVyczCCASIwDQYJKoZIhvcNAQEBBQADggEPADCCAQoCggEBAMR1+gzvX+Yq0V0c0yhd1qhPzEvuF2WLxAv5Oyc4tfVIuwNn3U6n6zjPf8ZwKVg3sQGxzCkbJXj4laWFj8Y++/NzwgWAMLvEI5cYNhIFwD0pct1k+ouWiZSxHDAytZHFXfCTfyJb4HzSaVUce7c0xjy4ghXZ3Seac5a8UP9I8J8jrowpszHbaQImOXDPEdNtkES+akXNF9x4MHApuR7z7YISjyuN5wm8DFtG6qSd1r04RdaRk0bgar70uPvKJRdTu92cFsfACjglXb5lRG9a2Vvo+qRBdMxdMrICEe2crQTUEsW/qB+44yH1RnGtIiNEkZrSfWVqfn86vI2xoUEQo/sCAwEAAaMyMDAwCQYDVR0TBAIwADAOBgNVHQ8BAf8EBAMCBaAwEwYDVR0lBAwwCgYIKwYBBQUHAwIwDQYJKoZIhvcNAQELBQADggEBAIsleBvTjtqFZNO0snGz972MSL9XeDb7uzOPc3lEHhAAtExr1PpPihWYSn84Y6yFmRPpGBYWVje1t4As+WF/07cSlwJMUktaAIQLwfHiQBTT0ofL3zkio3akbN3pqZrwlnnmsSjkHpqA3LOV6N5lg9Ss93nm17P6I1Jz9R3oyYD1Oggwmaxcg+j4H15J168K7p8XT8Xl2NDP0ILZzPmaV66sajMw6tvau0H+DEJndLkjDoNFr09n3j5aHRHAq7gEE+HvTOZ4hD5MAGHhPNhs6tPtIFhClFtAEw+tLMyUOEwxoGFvdF+TcYviPA9ry7X0qXbodRjYxgdRxTW/JcuY2cg="
        
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
//        let keyBase64 = "MIIEowIBAAKCAQEAxHX6DO9f5irRXRzTKF3WqE/MS+4XZYvEC/k7Jzi19Ui7A2fdTqfrOM9/xnApWDexAbHMKRslePiVpYWPxj7783PCBYAwu8Qjlxg2EgXAPSly3WT6i5aJlLEcMDK1kcVd8JN/IlvgfNJpVRx7tzTGPLiCFdndJ5pzlrxQ/0jwnyOujCmzMdtpAiY5cM8R022QRL5qRc0X3HgwcCm5HvPtghKPK43nCbwMW0bqpJ3WvThF1pGTRuBqvvS4+8olF1O73ZwWx8AKOCVdvmVEb1rZW+j6pEF0zF0ysgIR7ZytBNQSxb+oH7jjIfVGca0iI0SRmtJ9ZWp+fzq8jbGhQRCj+wIDAQABAoIBABbJHBw98yBt3ORwwGjRIWFaB/bSgXIsmKtO17Z/1FLDgbUuabOCtDxdjJNGVPU/WE87ANPPqzPxmOGesQMsMOqWhW0/5ecRI5OVokfK1PYDBah52rkv13sgY4WPjBGBE5kgckFY6Jtxh/fwGsUv4MIQID5Ki2TZfAiChN5m5kl+lKrMtx59q61TgxJXskWLNnylRVHxT2p6ENMjZRQwpmx7YeC1qyUEtOhw/pD9i9QaKuV3fl0yKmioXwTA48hV6QQCW2wWNTxxyOpU9Gr0pCgl8E3KCpTpA5ipAWwrLdCTBgC7Z6OteqnuHGdHcahUvjxaXVb9lM9vH3s72meUQVECgYEA9+D3WNQPpe/TheGDB+jXaJ6iLkc/7n2TBllnOQXpZKzcZukLcfqprGwDBYpHMrpdzggOwIh5N8q0mhJTffi7LtqWoSWqsGdbhMgLe5D8XLWvw67snoH3AV99oOQ9bTQSzDTcp4I2j9MHTwGddweGhSxxlV/KBWBgszOIMvO/6ykCgYEAyuXAwPtSx1C5rkbksECwfc53gflGsQGeoPi+YlbAaxbTh9+kG7eLBKhOIiGTZ7PXPBrQ90v5nkwpf7QViTRLyGRX5KByD3ZbiLuvVvd1YqfWP45LF1Pxtf959t/KfHslfLs1XuHXY5h1yS6pA7o51ho56l4bNX2yOtl1y4v4noMCgYEA9HeYGrBSmooz6DdoHlXilJjXRKMah2CrrzhfWFrfO15MpOY0Vn4r9xQzyrP80igBueAyhGpUetTdV5K5a2TzXxtQMbBPblkRZpxQztZIPjsmFO0hCpcM//qokRRpDJmt7F46PK5sl14+OApUvX7bid4yS2rEeJb75+Dr86x4XDkCgYBbk8+oSsdWBu2H55+YndoLLoFqPKTXh6+dYCguIpG+xBK9pQdhKzqn439AkH8Ds3xWOJRQyg3kkOO6LAH8Z4o87G1vV6ujpvwxfuTpD8//s1lUXlkuMklKqADYmLG/9aU54xV3ud+JqGqhX1oRwKASLswtKESHpDApt7UfJhIVGQKBgEPfUzM9tS9p3f9VeKFXwsyuT+hwnxeopxkA50UiadmQcavohgXvtJ1co633CekHRATYSM79qN2WLKrtTuXqNPzMbYT+zo3nJy6dQknVPEjIu5Vr2AoBHbe2OB1+H0lENKRCEE2EK5ZKKGVfBlhvwGdjO4vO5b0g7+AzMnMOc+wl"
        
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



