//
//  RowView.swift
//  Easy Kube
//
//  Created by 王镓耀 on 2020/10/21.
//  Copyright © 2020 codewjy. All rights reserved.
//

import SwiftUI

struct RowView: View {
    var row: RowData
    @State var hovered = false

    var body: some View {
        HStack(alignment: .center){
            Image(row.objectType.rawValue)
                .resizable()
                .aspectRatio(1.0, contentMode: .fit)
                .frame(width: 40, height: 40)
                .fixedSize(horizontal: true, vertical: true)
                .cornerRadius(4.0)
                .colorMultiply(Color(hex: 0x61bdd5))
            VStack(alignment: .leading){
                HStack() {
                    Text(row.objectName)
                        .fontWeight(.bold)
                        .truncationMode(.head)
//                        .frame(minWidth: 200)
//                        .background(Color.gray)
                    Spacer()
                    Text(row.objectStatus)
                        .fontWeight(.bold)
                }
                
                HStack() {
                    
                        Text(row.objectNamespace != nil ? row.objectNamespace! : "")
                        .font(.caption)
                        .opacity(0.625)
                        .truncationMode(.middle)
                        .frame(width: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/,alignment: .leading)
                  
                    if row.objectAge != nil{
                        Text("age: \(row.objectAge! )")
                            .font(.caption)
                            .opacity(0.625)
                            .truncationMode(.middle)
                    }
                    
                    
                    Spacer()
                    
                    
                    switch row.objectType {
                    case .pod:
                        CellButton(action: showLog, img: "log", text: "log")
                        CellButton(action: exec, img: "terminal", text: "exec")
                        CellButton(action: showDetail, img: "detail", text: "desc")
                        CellButton(action: delete, img: "delete", text: "delete")
                    case .service:
                        CellButton(action: showDetail, img: "detail", text: "desc")
                        CellButton(action: edit, img: "edit", text: "edit")
                    case .deployment:
                        CellButton(action: showDetail, img: "detail", text: "desc")
                        CellButton(action: edit, img: "edit", text: "edit")
                    case .node:
                        CellButton(action: showDetail, img: "detail", text: "desc")
                    case .statefulSet:
                        CellButton(action: showDetail, img: "detail", text: "desc")
                    case .ingress:
                        CellButton(action: showDetail, img: "detail", text: "desc")
                    }
                
                }
            }
        }
        .padding()
        .onHoverAware( openHover)
        .background(hovered ? Color(hex:0x66CCFF,alpha: 0.3) : Color.clear)
        .frame(height:65)
        
    }
    
    func openHover(hover: Bool){
        withAnimation{
            self.hovered = hover
        }
    }
    
    func showLog(){
        Terminal.execute(command: "kubectl logs -f \(row.objectName) -n \(row.objectNamespace!)")
    }
    
    func exec(){
        Terminal.execute(command: "kubectl exec -it  \(row.objectName) -n \(row.objectNamespace!) /bin/bash")
    }
    
    func delete(){
        Terminal.execute(command: "kubectl delete po  \(row.objectName) -n \(row.objectNamespace!)")
    }
    
    
    func showDetail(){
        
        let namespace = row.objectNamespace != nil ? " -n \(row.objectNamespace!)" : ""
        let command = """
        kubectl describe \(row.objectType.rawValue) \(row.objectName)  \(namespace)
        while [ 1 ]; do
        echo -n "按Q退出"
        read name
        if [[ $name = "q" || $name = "Q" ]]; then
           break
        fi
        done
        """
        Terminal.execute(command: command)
    }
    
    
    func edit(){
        Terminal.execute(command: "kubectl edit \(row.objectType.rawValue) \(row.objectName) -n \(row.objectNamespace!)")
    }
    
  
}
