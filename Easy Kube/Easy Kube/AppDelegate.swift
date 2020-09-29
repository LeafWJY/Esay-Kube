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
    
    var identity: IdentityAndTrust!
    
    
    func applicationDidFinishLaunching(_ aNotification: Notification) {
        // Create the SwiftUI view that provides the window contents.
        loadDate(urlString: "https://192.168.16.143:8443/api/v1/pods")
        
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
            print("客户端证书认证！")
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


struct AppDelegate_Previews: PreviewProvider {
    static var previews: some View {
        /*@START_MENU_TOKEN@*/Text("Hello, World!")/*@END_MENU_TOKEN@*/
    }
}
