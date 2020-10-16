//
//  PodRow.swift
//  Easy Kube
//
//  Created by 王镓耀 on 2020/9/30.
//  Copyright © 2020 codewjy. All rights reserved.
//

import SwiftUI

struct PodRow: View {
    
    var pod: Pod
    
    @State var hovered = false
    @State var deleteHovered = false
    @State var logHovered = false
    
//    @State var color = Color.green.opacity(0.1)
    
    
    
    var body: some View {
        HStack(alignment: .center){
            Image("pod")
                .resizable()
                .aspectRatio(1.0, contentMode: .fit)
                .frame(width: 40, height: 40)
                .fixedSize(horizontal: true, vertical: true)
                .cornerRadius(4.0)
            VStack(alignment: .leading){
                HStack() {
                    Text(pod.metadata.name)
                        .fontWeight(.bold)
                        .truncationMode(.tail)
                        .frame(minWidth: 20)
                    Spacer()
                    Text(pod.status.status)
                        .fontWeight(.bold)
                        .opacity(0.625)
                    Text(pod.status.ready)
                        .fontWeight(.bold)
                        .opacity(0.625)
                }
   
                HStack() {
                    Text(pod.metadata.namespace)
                        .font(.caption)
                        .opacity(0.625)
                        .truncationMode(.middle)
                    Spacer()
                    Button(action: openTerminal, label:  {
                        Image(logHovered ? "log-hover" :"log" )
                            .resizable()
                            .frame(width: 16, height: 16)
                            .fixedSize(horizontal: true, vertical: true)
                    }).onHover(perform: logHovered)
                        .buttonStyle(ImgButtonStyle())
                    Button(action: openTerminal, label:  {
                        Image(deleteHovered ? "delete-hover" :"delete" )
                            .resizable()
                            .frame(width: 16, height: 16)
                            .fixedSize(horizontal: true, vertical: true)
                    }).onHover(perform: deleteHovered)
                        .buttonStyle(ImgButtonStyle())
                
                    
                    
                    
                }
            }
            
            
        }
        .padding()
            
        .onHover(perform: openHover)
//        .background(self.color)
        .background(hovered ? Color.blue.opacity(0.3) : Color.clear.opacity(0.1))
        .frame(height:65)
        
    }
    
    func openHover(hover: Bool){
        withAnimation{
            self.hovered = hover
//            self.color = hover ? Color.blue.opacity(0.3) : Color.green.opacity(0.1)
        }
        
    }
    
    func deleteHovered(hover: Bool) {
        self.deleteHovered = hover
    }
    
    func logHovered(hover: Bool) {
        self.logHovered = hover
    }
    
    
    func openTerminal(){
        Terminal.execute(command: "kubectl logs -f \(pod.metadata.name) -n \(pod.metadata.namespace)")
    }
    
}



struct PodRow_Previews: PreviewProvider {
    static var previews: some View {
        let metadata = PodMetadata(name: "pod name", uid: "12312312", namespace: "hippius-dev")
        
        
        let podStatus = PodStatus(phase: "Running", podIP: "10.244.3.190", hostIP: "192.168.16.148", containerStatuses: [PodContainer(ready: true)])
        
        
        let pod = Pod(metadata: metadata, status: podStatus)
        
        
        return PodRow(pod:pod)
    }
}
