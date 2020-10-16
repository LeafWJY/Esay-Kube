//
//  AppDelegate.swift
//  K8S-GUI
//
//  Created by 王镓耀 on 2020/2/22.
//  Copyright © 2020 王镓耀. All rights reserved.
//

import Cocoa
import SwiftUI

//import Yaml

import Yams

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate,URLSessionDelegate {
    
    var window: NSWindow!
    
    var identity: IdentityAndTrust!
    
    
    func applicationDidFinishLaunching(_ aNotification: Notification) {
        
//        var str = """
//        apiVersion: v1
//        clusters:
//        - cluster:
//            certificate-authority-data: LS0tLS1CRUdJTiBDRVJUSUZJQ0FURS0tLS0tCk1JSUN5RENDQWJDZ0F3SUJBZ0lCQURBTkJna3Foa2lHOXcwQkFRc0ZBREFWTVJNd0VRWURWUVFERXdwcmRXSmwKY201bGRHVnpNQjRYRFRFNU1UQXhOREEwTlRBek1Wb1hEVEk1TVRBeE1UQTBOVEF6TVZvd0ZURVRNQkVHQTFVRQpBeE1LYTNWaVpYSnVaWFJsY3pDQ0FTSXdEUVlKS29aSWh2Y05BUUVCQlFBRGdnRVBBRENDQVFvQ2dnRUJBTlRhCnc3dy9hb2NDcDcrc2gyTitqdGNuWTRtVi9PaS8xaElHZWhRUC94dW9PK085bWtNdTlxTFVEMWp1dFQ3Um1oVy8KVjdYemZOc0R4NFdNYm40b1F2Z0tKTDQ5WllNYVVpUWJERk40SHlSeWRrSjFHWmNNaTlTcDBRVTdvNHJLY09HMwptODY3bGpDZDRDRjA4SURwQllMUC9KZ3FWNThINWhySFFBQXh2czkvd2p5emd0ckVtc2NhZDIvSVd6OXV1R29yCmQ3a0MzU2JtVVNpK3dUZ0kxYmRZNnBCakhEQzhPalJoWTlWdmlqQnd6VWp6WmJQeXhkRmZHWCs3UVU5eWN3R1YKQU5kb2M4bXY5NWJEWlAwVXpKamRFOWRkOEFsWCtvNWF6R21QTnNKTnk0UU1PYmw3c0s5aG5nUUZMaStJZzA4Uwp1WnhYYkRFKy9BZDg0MS9IN0lNQ0F3RUFBYU1qTUNFd0RnWURWUjBQQVFIL0JBUURBZ0trTUE4R0ExVWRFd0VCCi93UUZNQU1CQWY4d0RRWUpLb1pJaHZjTkFRRUxCUUFEZ2dFQkFNbmdvdEdpV1NUaTBBVmZhVUkza1FVSXdkR2kKODM2MkZSM1ZTUndWMG9YMEwwZXJYOVlYRUlvYkJrVy8vbG9YS25QMnRnRUdXMHVtd3p3eGdMKzZyV0psbXJrNgpCYVEwekZwVGRJem40Q1VGbWhQelM1bjI3S001aVhZdFptcmNuYUNSODF6R1pwVCszSmlyZXczWFAydDlpUEVqCmJodW5DNm9mRmU1TTNBOEZwY0FHK3Y1MTdmdVVyWEM3Qmt1eFJoRmkxWmgzL3JudWJ5SkNMRVZjYTZVQjRFYTMKWnNjMEw4RWJJM0VvL1ZBa1pKTDh2NW5qRjZHYjJsdFhxNzlXQ3l4MW5ZNVJSY3BJd1dxVE1mR1RxSVNGTXZOSgpLdGt1Ym4yK2taMFpINy9mNWl5K3B2Y2ZERk4yZzFteGlrVlZtUnNSZUFuRjBkZkNpRHhpNHRtckZ6ST0KLS0tLS1FTkQgQ0VSVElGSUNBVEUtLS0tLQo=
//            server: https://kubernetes.docker.internal:6443
//          name: docker-desktop
//        """
//
//
//        do {
////            let decoder = YAMLDecoder()
////            var kubeconfig: KubeConfig
////            try kubeconfig = decoder.decode(KubeConfig.self, from: str)
////
//////            print(kubeconfig.clusters[0].cluster.certificate)
////
////            var str = String(data: Data(base64Encoded: kubeconfig.clusters[0].cluster.certificate)!, encoding: String.Encoding.utf8)
//////            print(str!)
////            var textArray:[String] = str!.components(separatedBy: "\n")
//////            print(textArray)
////
////            var pem = ""
////            for line in textArray{
////                if !line.starts(with: "--"){
////                    pem.append(line)
////                }
////            }
////            print(pem)
//
//            do {
//
//                let url = FileManager.default.homeDirectoryForCurrentUser.appendingPathComponent(".kube/config")
//
//                let configData = try Data(contentsOf: url)
//                // Convert the data back into a string
//
//
//                let configStr = String(data: configData, encoding: .utf8)!
////                print(configStr)
//
//                let decoder = YAMLDecoder()
//                var kubeconfig: KubeConfig
//                try kubeconfig = decoder.decode(KubeConfig.self, from: configStr)
//                print(kubeconfig)
//
//
//
//
//
//
//
//
//
//
//
//
//            } catch {
//                print(error)
//            }
//
////            print(str.trimmingCharacters(in: NSCharacterSet.newlines))
//
//
//
//
////            return try decoder.decode([Pen].self, from: yamlString)
//        } catch {
//            print("Could not load pen JSON!")
//        }
        
        
        //
        //        let s = S(p: "test")
        //        let encoder = YAMLEncoder()
        //        let encodedYAML = try! encoder.encode(s)
        //
        //        encodedYAML == """
        //        p: test
        //
        //        """
        //        let decoder = YAMLDecoder()
        //        let decoded = try! decoder.decode(S.self, from: encodedYAML)
        //        s.p == decoded.p
        
        
        //
        
        //        let obj = try! UniYAML.decode(str)
        //        let value = try! Yaml.load(str)
        //        print(value["clusters"].array)  // Int(1)
        //        print(value["b"])  // Int(2)
        //        print(value["c"])  // Null
        
        //        print("languages:\n - Swift: true\n - Objective C: false")
        
        
        
        let userData = UserData()
        
        let contentView = ContentView().environmentObject(userData).edgesIgnoringSafeArea(.top)
        
        // Create the window and set the content view.
        self.window = NSWindow(
            contentRect: NSRect(x: 0, y: 0, width: 480, height: 300),
            styleMask: [.titled, .closable, .miniaturizable, .resizable, .fullSizeContentView],
            backing: .buffered, defer: false)
        self.window.center()
        self.window.setFrameAutosaveName("Main Window")
        self.window.contentView = NSHostingView(rootView: contentView)
        self.window.makeKeyAndOrderFront(nil)
        self.window.titlebarAppearsTransparent = true
        self.window.titleVisibility = .hidden
        
        
    }
    
    
    func applicationWillTerminate(_ aNotification: Notification) {
        // Insert code here to tear down your application
    }
    
    func applicationShouldTerminateAfterLastWindowClosed(_ sender: NSApplication) -> Bool {
        true
    }
    
}






struct AppDelegate_Previews: PreviewProvider {
    static var previews: some View {
        /*@START_MENU_TOKEN@*/Text("Hello, World!")/*@END_MENU_TOKEN@*/
    }
}


