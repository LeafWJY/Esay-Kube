//
//  Terminal.swift
//  Easy Kube
//
//  Created by 王镓耀 on 2020/10/13.
//  Copyright © 2020 codewjy. All rights reserved.
//

import SwiftUI

class Terminal {
    
     public static func execute(command:String){
    
    
        do {
                   let str = command
                   
                   let filename = getDocumentsDirectory().appendingPathComponent("easy-cube.sh")
                   
                   try str.write(to: filename, atomically: true, encoding: String.Encoding.utf8)
               } catch {
                   print(error)
               }
               
               do {
                   let task = Process()
                   task.executableURL = URL(fileURLWithPath: "/bin/chmod")
                   task.arguments = ["a+x", getFilePath()]
                   try task.run()
               } catch {
                   print(error)
               }
               
               
               do {
                   let task = Process()
                   task.executableURL = URL(fileURLWithPath: "/usr/bin/open")
                   task.arguments = ["-a", "iTerm", getFilePath()]
//                   task.arguments = ["-a", "Terminal", getFilePath()]
                   try task.run()
               } catch {
                   print(error)
               }
        
        
    }
    
    public static func getDocumentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
    
    public static func getFilePath() ->String{
        let filename = getDocumentsDirectory().appendingPathComponent("easy-cube.sh")
        let str = filename.path
        print("str",str)
        return str
        
    }
   
}


