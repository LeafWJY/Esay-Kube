//
//  AppDelegate.swift
//  K8S-GUI
//
//  Created by 王镓耀 on 2020/2/22.
//  Copyright © 2020 王镓耀. All rights reserved.
//

import Cocoa
import SwiftUI

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate,URLSessionDelegate {
    
    var window: NSWindow!
    
    var test: IdentityAndTrust!
    
    
    func applicationDidFinishLaunching(_ aNotification: Notification) {
        // Create the SwiftUI view that provides the window contents.
        
        //        loadDate()
        loadDate(urlString: "https://192.168.16.143:8443/api/v1/pods")
        //         let path: String = Bundle.main.path(forResource: "1", ofType: "docx")!
        //        print(path)
        
        
        
    }
    func loadDate(urlString: String){
        
        //1、创建URL
        let url: URL = URL(string: urlString)!
        
        //2、创建URLRequest
        let request: URLRequest = URLRequest(url: url)
        
        //3、创建URLSession
        let configration = URLSessionConfiguration.default
        let session =  URLSession(configuration: configration,delegate: self, delegateQueue:OperationQueue.main)
        
        //4、URLSessionTask子类
        let task: URLSessionDataTask = session.dataTask(with: request) { (data, response, error) in
            if error == nil {
                do {
                    let result: NSDictionary = try JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.allowFragments) as! NSDictionary
                    //                                        print(data?.base64EncodedString())
                    DispatchQueue.main.async {
                        //                                let message: NSDictionary = result.object(forKey: "othermapper") as! NSDictionary
                        //                                let name = message.object(forKey: "name") as? String
                        //                                print(name as Any)
                        let contentView = ContentView(content:result.description)
                        
                        // Create the window and set the content view.
                        self.window = NSWindow(
                            contentRect: NSRect(x: 0, y: 0, width: 480, height: 300),
                            styleMask: [.titled, .closable, .miniaturizable, .resizable, .fullSizeContentView],
                            backing: .buffered, defer: false)
                        self.window.center()
                        self.window.setFrameAutosaveName("Main Window")
                        self.window.contentView = NSHostingView(rootView: contentView)
                        self.window.makeKeyAndOrderFront(nil)
                        
                    }
                }catch{
                    print(error.localizedDescription)
                }
            }
        }
        
        //5、启动任务
        task.resume()
        
    }
    
    func applicationWillTerminate(_ aNotification: Notification) {
        // Insert code here to tear down your application
    }
    
    func urlSession(_ session: URLSession, didReceive challenge: URLAuthenticationChallenge,
                    completionHandler: @escaping (URLSession.AuthChallengeDisposition,
        URLCredential?) -> Void) {
        
        //认证服务器（这里不使用服务器证书认证，只需地址是我们定义的几个地址即可信任）
        if challenge.protectionSpace.authenticationMethod
            == NSURLAuthenticationMethodServerTrust {
            print("服务器认证！")
            let credential = URLCredential(trust: challenge.protectionSpace.serverTrust!)
            completionHandler(.useCredential, credential)
        }else if
            //认证客户端证书
            challenge.protectionSpace.authenticationMethod
                == NSURLAuthenticationMethodClientCertificate
        {
//            let certificate: SecCertificate = ""
//            var identity: SecIdentity?
//            let status = SecIdentityCreateWithCertificate(nil, certificate, &identity)
//
            print("客户端证书认证！")
            //获取客户端证书相关信息
            if self.test == nil{
                test = self.extractIdentity()
            }
            //                   let identityAndTrust:IdentityAndTrust = self.extractIdentity()
            
//            let urlCredential:URLCredential = URLCredential(
//                identity: test.identityRef,
//                certificates: test.certArray as? [AnyObject],
//                persistence: URLCredential.Persistence.forSession)
            let urlCredential:URLCredential = URLCredential(
            identity: test.identityRef,
            certificates: nil,
            persistence: .none)
            
            completionHandler(.useCredential, urlCredential)
        }
        // 其它情况（不接受认证）
        //           else {
        //               print("其它情况（不接受认证）")
        //               completionHandler(.cancelAuthenticationChallenge, nil);
        //           }
    }
    //获取客户端证书相关信息
    func extractIdentity() -> IdentityAndTrust {
        var identityAndTrust:IdentityAndTrust!
        var securityError:OSStatus = errSecSuccess
        
        let secIdentityRef:SecIdentity = loadCert()
                       let pem =
                       "MIIC/jCCAeagAwIBAgIJAOU2AKu2m7+WMA0GCSqGSIb3DQEBCwUAMBUxEzARBgNVBAMMCmt1YmVybmV0ZXMwHhcNMTkxMjExMTIzMTE5WhcNMjkxMjA4MTIzMTE5WjA0MRkwFwYDVQQDDBBrdWJlcm5ldGVzLWFkbWluMRcwFQYDVQQKDA5zeXN0ZW06bWFzdGVyczCCASIwDQYJKoZIhvcNAQEBBQADggEPADCCAQoCggEBAMR1+gzvX+Yq0V0c0yhd1qhPzEvuF2WLxAv5Oyc4tfVIuwNn3U6n6zjPf8ZwKVg3sQGxzCkbJXj4laWFj8Y++/NzwgWAMLvEI5cYNhIFwD0pct1k+ouWiZSxHDAytZHFXfCTfyJb4HzSaVUce7c0xjy4ghXZ3Seac5a8UP9I8J8jrowpszHbaQImOXDPEdNtkES+akXNF9x4MHApuR7z7YISjyuN5wm8DFtG6qSd1r04RdaRk0bgar70uPvKJRdTu92cFsfACjglXb5lRG9a2Vvo+qRBdMxdMrICEe2crQTUEsW/qB+44yH1RnGtIiNEkZrSfWVqfn86vI2xoUEQo/sCAwEAAaMyMDAwCQYDVR0TBAIwADAOBgNVHQ8BAf8EBAMCBaAwEwYDVR0lBAwwCgYIKwYBBQUHAwIwDQYJKoZIhvcNAQELBQADggEBAIsleBvTjtqFZNO0snGz972MSL9XeDb7uzOPc3lEHhAAtExr1PpPihWYSn84Y6yFmRPpGBYWVje1t4As+WF/07cSlwJMUktaAIQLwfHiQBTT0ofL3zkio3akbN3pqZrwlnnmsSjkHpqA3LOV6N5lg9Ss93nm17P6I1Jz9R3oyYD1Oggwmaxcg+j4H15J168K7p8XT8Xl2NDP0ILZzPmaV66sajMw6tvau0H+DEJndLkjDoNFr09n3j5aHRHAq7gEE+HvTOZ4hD5MAGHhPNhs6tPtIFhClFtAEw+tLMyUOEwxoGFvdF+TcYviPA9ry7X0qXbodRjYxgdRxTW/JcuY2cg="
                       let certData = Data(base64Encoded: pem)!

                       let certificate: SecCertificate = SecCertificateCreateWithData(nil,certData as CFData)!
                       
                       let certArray = [ certificate ]
                       
                       
                       let policy = SecPolicyCreateBasicX509()

                       var optionalTrust: SecTrust?
                       let status = SecTrustCreateWithCertificates(certArray as AnyObject,
                                                                   policy,
                                                                   &optionalTrust)

                       let trust = optionalTrust!
                       
                       identityAndTrust = IdentityAndTrust(identityRef: secIdentityRef,trust:trust,
                                                           certArray:  certArray)
        return identityAndTrust;
    }
    //定义一个结构体，存储认证相关信息
    struct IdentityAndTrust {
        var identityRef:SecIdentity
        var trust:SecTrust
        var certArray:[SecCertificate]
    }
    
    
    func loadCert() -> SecIdentity{
        
        // example data from http://fm4dd.com/openssl/certexamples.htm
        let pem =
            "MIIC/jCCAeagAwIBAgIJAOU2AKu2m7+WMA0GCSqGSIb3DQEBCwUAMBUxEzARBgNVBAMMCmt1YmVybmV0ZXMwHhcNMTkxMjExMTIzMTE5WhcNMjkxMjA4MTIzMTE5WjA0MRkwFwYDVQQDDBBrdWJlcm5ldGVzLWFkbWluMRcwFQYDVQQKDA5zeXN0ZW06bWFzdGVyczCCASIwDQYJKoZIhvcNAQEBBQADggEPADCCAQoCggEBAMR1+gzvX+Yq0V0c0yhd1qhPzEvuF2WLxAv5Oyc4tfVIuwNn3U6n6zjPf8ZwKVg3sQGxzCkbJXj4laWFj8Y++/NzwgWAMLvEI5cYNhIFwD0pct1k+ouWiZSxHDAytZHFXfCTfyJb4HzSaVUce7c0xjy4ghXZ3Seac5a8UP9I8J8jrowpszHbaQImOXDPEdNtkES+akXNF9x4MHApuR7z7YISjyuN5wm8DFtG6qSd1r04RdaRk0bgar70uPvKJRdTu92cFsfACjglXb5lRG9a2Vvo+qRBdMxdMrICEe2crQTUEsW/qB+44yH1RnGtIiNEkZrSfWVqfn86vI2xoUEQo/sCAwEAAaMyMDAwCQYDVR0TBAIwADAOBgNVHQ8BAf8EBAMCBaAwEwYDVR0lBAwwCgYIKwYBBQUHAwIwDQYJKoZIhvcNAQELBQADggEBAIsleBvTjtqFZNO0snGz972MSL9XeDb7uzOPc3lEHhAAtExr1PpPihWYSn84Y6yFmRPpGBYWVje1t4As+WF/07cSlwJMUktaAIQLwfHiQBTT0ofL3zkio3akbN3pqZrwlnnmsSjkHpqA3LOV6N5lg9Ss93nm17P6I1Jz9R3oyYD1Oggwmaxcg+j4H15J168K7p8XT8Xl2NDP0ILZzPmaV66sajMw6tvau0H+DEJndLkjDoNFr09n3j5aHRHAq7gEE+HvTOZ4hD5MAGHhPNhs6tPtIFhClFtAEw+tLMyUOEwxoGFvdF+TcYviPA9ry7X0qXbodRjYxgdRxTW/JcuY2cg="

        // remove header, footer and newlines from pem string
//        let characterSet = CharacterSet(charactersIn: "\n")
//        pem = pem.trimmingCharacters(in: .newlines)
//        pem = pem.trimmingCharacters(in: NSCharacterSet.whitespaces)

        let certData = Data(base64Encoded: pem)!

        let certificate: SecCertificate = SecCertificateCreateWithData(nil,certData as CFData)!
        
        
        let keyBase64 = "MIIEowIBAAKCAQEAxHX6DO9f5irRXRzTKF3WqE/MS+4XZYvEC/k7Jzi19Ui7A2fdTqfrOM9/xnApWDexAbHMKRslePiVpYWPxj7783PCBYAwu8Qjlxg2EgXAPSly3WT6i5aJlLEcMDK1kcVd8JN/IlvgfNJpVRx7tzTGPLiCFdndJ5pzlrxQ/0jwnyOujCmzMdtpAiY5cM8R022QRL5qRc0X3HgwcCm5HvPtghKPK43nCbwMW0bqpJ3WvThF1pGTRuBqvvS4+8olF1O73ZwWx8AKOCVdvmVEb1rZW+j6pEF0zF0ysgIR7ZytBNQSxb+oH7jjIfVGca0iI0SRmtJ9ZWp+fzq8jbGhQRCj+wIDAQABAoIBABbJHBw98yBt3ORwwGjRIWFaB/bSgXIsmKtO17Z/1FLDgbUuabOCtDxdjJNGVPU/WE87ANPPqzPxmOGesQMsMOqWhW0/5ecRI5OVokfK1PYDBah52rkv13sgY4WPjBGBE5kgckFY6Jtxh/fwGsUv4MIQID5Ki2TZfAiChN5m5kl+lKrMtx59q61TgxJXskWLNnylRVHxT2p6ENMjZRQwpmx7YeC1qyUEtOhw/pD9i9QaKuV3fl0yKmioXwTA48hV6QQCW2wWNTxxyOpU9Gr0pCgl8E3KCpTpA5ipAWwrLdCTBgC7Z6OteqnuHGdHcahUvjxaXVb9lM9vH3s72meUQVECgYEA9+D3WNQPpe/TheGDB+jXaJ6iLkc/7n2TBllnOQXpZKzcZukLcfqprGwDBYpHMrpdzggOwIh5N8q0mhJTffi7LtqWoSWqsGdbhMgLe5D8XLWvw67snoH3AV99oOQ9bTQSzDTcp4I2j9MHTwGddweGhSxxlV/KBWBgszOIMvO/6ykCgYEAyuXAwPtSx1C5rkbksECwfc53gflGsQGeoPi+YlbAaxbTh9+kG7eLBKhOIiGTZ7PXPBrQ90v5nkwpf7QViTRLyGRX5KByD3ZbiLuvVvd1YqfWP45LF1Pxtf959t/KfHslfLs1XuHXY5h1yS6pA7o51ho56l4bNX2yOtl1y4v4noMCgYEA9HeYGrBSmooz6DdoHlXilJjXRKMah2CrrzhfWFrfO15MpOY0Vn4r9xQzyrP80igBueAyhGpUetTdV5K5a2TzXxtQMbBPblkRZpxQztZIPjsmFO0hCpcM//qokRRpDJmt7F46PK5sl14+OApUvX7bid4yS2rEeJb75+Dr86x4XDkCgYBbk8+oSsdWBu2H55+YndoLLoFqPKTXh6+dYCguIpG+xBK9pQdhKzqn439AkH8Ds3xWOJRQyg3kkOO6LAH8Z4o87G1vV6ujpvwxfuTpD8//s1lUXlkuMklKqADYmLG/9aU54xV3ud+JqGqhX1oRwKASLswtKESHpDApt7UfJhIVGQKBgEPfUzM9tS9p3f9VeKFXwsyuT+hwnxeopxkA50UiadmQcavohgXvtJ1co633CekHRATYSM79qN2WLKrtTuXqNPzMbYT+zo3nJy6dQknVPEjIu5Vr2AoBHbe2OB1+H0lENKRCEE2EK5ZKKGVfBlhvwGdjO4vO5b0g7+AzMnMOc+wl"

        let keyData = Data(base64Encoded: keyBase64)!
        let tag = "com.wjy.keys.mykey".data(using: .utf8)!
        let key = SecKeyCreateWithData(keyData as NSData, [
            kSecAttrKeyType: kSecAttrKeyTypeRSA,
            kSecAttrApplicationTag as String: tag,
            kSecAttrKeyClass: kSecAttrKeyClassPrivate,
        ] as NSDictionary, nil)!
        print(key)
        
        
        let query: [String: Any] = [kSecClass as String: kSecClassKey,
                                       kSecAttrApplicationTag as String: tag,
                                       kSecAttrKeyType as String: kSecAttrKeyTypeRSA,
                                       kSecAttrKeyClass as String: kSecAttrKeyClassPrivate,
                                       kSecReturnRef as String: true]
        
        var item: CFTypeRef?
        let status2 = SecItemCopyMatching(query as CFDictionary, &item)
//        guard status2 == errSecSuccess else { print("error1");return nil}
        print("status1")
//        test123()
        print(status2)
        
        
        
        
        
        
        
//        let query: [String: Any] = [kSecClass as String: kSecClassKey,
//        kSecAttrApplicationTag as String: tag,
//        kSecAttrKeyType as String: kSecAttrKeyTypeRSA,
//        kSecReturnRef as String: true]
//
//        var item: CFTypeRef?
//        let status = SecItemCopyMatching(query as CFDictionary, &item)
//        print(status)
//        var keychain: Unmanaged<SecKeychain>
//        let pubkey = SecKeyCopyPublicKey(key)
        var identity: SecIdentity?
        let resut =  SecIdentityCreateWithCertificate(item, certificate, &identity)
        print(resut)
        
      
        return identity!
        
        
        

        // use certificate e.g. copy the public key
    //    let publicKey = SecCertificateCopyKey(certificate)!
        
    }
    
    
    
    func test123(){
        let tag = "com.example.keys.mykey".data(using: .utf8)!
        let attributes: [String: Any] =
            [kSecAttrKeyType as String:            kSecAttrKeyTypeRSA,
             kSecAttrKeySizeInBits as String:      2048,
             kSecPrivateKeyAttrs as String:
                [kSecAttrIsPermanent as String:    true,
                 kSecAttrApplicationTag as String: tag]
        ]

        let privateKey = SecKeyCreateRandomKey(attributes as CFDictionary, nil)
        let query: [String: Any] = [kSecClass as String: kSecClassKey,
                                    kSecAttrApplicationTag as String: tag,
                                    kSecAttrKeyType as String: kSecAttrKeyTypeRSA,
                                    kSecReturnRef as String: true]
        var item: CFTypeRef?
        let status2 = SecItemCopyMatching(query as CFDictionary, &item)
        guard status2 == errSecSuccess else { print("error1"); return }
        let key = item as! SecKey
    }
    

    
    
}




struct AppDelegate_Previews: PreviewProvider {
    static var previews: some View {
        /*@START_MENU_TOKEN@*/Text("Hello, World!")/*@END_MENU_TOKEN@*/
    }
}
