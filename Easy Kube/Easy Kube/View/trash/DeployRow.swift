//
//  DeploymentRow.swift
//  Easy Kube
//
//  Created by 王镓耀 on 2020/10/12.
//  Copyright © 2020 codewjy. All rights reserved.
//

import SwiftUI

struct DeployRow: View {
    var deploy: Deploy
    @State var hovered = false
    @State var logHovered = false
    
    
    
    var body: some View {
        HStack(alignment: .center){
            Image("deploy")
                .resizable()
                .aspectRatio(1.0, contentMode: .fit)
                .frame(width: 40, height: 40)
                .fixedSize(horizontal: true, vertical: true)
                .cornerRadius(4.0)
            VStack(alignment: .leading){
                HStack() {
                    Text(deploy.metadata.name)
                        .fontWeight(.bold)
                        .truncationMode(.tail)
                        .frame(minWidth: 20)
                    Spacer()
                    Text("Ready")
                        .fontWeight(.bold)
                        .opacity(0.625)
                    Text(deploy.status.ready)
                        .fontWeight(.bold)
                        .opacity(0.625)
                }
                
                HStack() {
                    Text(deploy.metadata.namespace)
                        .font(.caption)
                        .opacity(0.625)
                        .truncationMode(.middle)
                    Spacer()
                    Button(action: openTerminal, label:  {
                        VStack{
                            Image(logHovered ? "edit-hover" :"edit" )
                                .resizable()
                                .frame(width: 16, height: 16)
                                .fixedSize(horizontal: true, vertical: true)
                            Text("edit")
                                .font(.system(size: 8))
                                .padding(.top,-5)
                                .foregroundColor(Color.black)
                        }
                        .overlay(AcceptingFirstMouse())
                    }).onHoverAware( logHovered)
                        .buttonStyle(ImgButtonStyle())
                }
            }
            
            
        }
        .padding()
        .onHoverAware( openHover)
        .background(hovered ? Color(hex:0x66CCFF,alpha: 0.3)  : Color.clear)
        .frame(height:65)
        
    }
    
    func openHover(hover: Bool){
        withAnimation{
            self.hovered = hover
        }
    }
    
    
    func logHovered(hover: Bool) {
        self.logHovered = hover
    }
    
    
    func openTerminal(){
        Terminal.execute(command: "kubectl edit deploy \(deploy.metadata.name) -n \(deploy.metadata.namespace)")
    }
    
}

//struct DeploymentRow_Previews: PreviewProvider {
//    static var previews: some View {
//        let metadata = DeployMetadata(name: "deploy name", uid: "12312312", namespace: "hippius-dev")
//        let deployStatus = DeployStatus(availableReplicas: 1)
//        
//        
//        let deploy = Deploy(metadata: metadata, status: deployStatus)
//        
//        return DeployRow(deploy:deploy)
//    }
//}
