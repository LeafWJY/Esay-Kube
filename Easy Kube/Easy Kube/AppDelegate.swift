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
class AppDelegate: NSObject, NSApplicationDelegate {
    
    var window: NSWindow!
    

    func applicationDidFinishLaunching(_ aNotification: Notification) {
          
        let userData = UserData()
        
        let contentView = ContentView().environmentObject(userData).edgesIgnoringSafeArea(.top)

    
        
        // Create the window and set the content view.
        self.window = NSWindow(
            contentRect: NSRect(x: 0, y: 0, width: 480, height: 300),
            styleMask: [.titled, .closable, .miniaturizable, .resizable, .fullSizeContentView],
            backing: .buffered, defer: false)
//        self.window.center()
        self.window.setFrameAutosaveName("Main Window")
        self.window.contentView = NSHostingView(rootView: contentView)
        self.window.makeKeyAndOrderFront(self)
        self.window.titlebarAppearsTransparent = true
        self.window.titleVisibility = .hidden
        self.window.isMovableByWindowBackground = true
        self.window.backgroundColor = .clear
//        self.window.add
        
//        self.window.level = .statusBar
//        NSApplication.shared.activate(ignoringOtherApps: true)
    

        
//        self.window.allowsToolTipsWhenApplicationIsInactive = true

        
        
    }
    
    
    func applicationWillTerminate(_ aNotification: Notification) {
        // Insert code here to tear down your application
    }
    
    func applicationShouldTerminateAfterLastWindowClosed(_ sender: NSApplication) -> Bool {
        true
    }
    

//    func activate(ignoringOtherApps flag: Bool)
    
}






struct AppDelegate_Previews: PreviewProvider {
    static var previews: some View {
        /*@START_MENU_TOKEN@*/Text("Hello, World!")/*@END_MENU_TOKEN@*/
    }
}


