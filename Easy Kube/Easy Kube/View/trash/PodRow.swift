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
                    Text(pod.status.ready)
                        .fontWeight(.bold)
                }
                
                HStack() {
                    Text(pod.metadata.namespace)
                        .font(.caption)
                        .opacity(0.625)
                        .truncationMode(.middle)
                        .frame(width: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/,alignment: .leading)
                    
                    Text("age: \(pod.metadata.age)")
                        .font(.caption)
                        .opacity(0.625)
                        .truncationMode(.middle)
                    Spacer()
                    CellButton(action: showLog, img: "log", text: "log")
                    CellButton(action: exec, img: "terminal", text: "exec")
                    CellButton(action: showDetail, img: "detail", text: "desc")
                    CellButton(action: delete, img: "delete", text: "delete")
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
        Terminal.execute(command: "kubectl logs -f \(pod.metadata.name) -n \(pod.metadata.namespace)")
    }
    
    func exec(){
        Terminal.execute(command: "kubectl exec -it  \(pod.metadata.name) -n \(pod.metadata.namespace) /bin/bash")
    }
    
    func delete(){
        Terminal.execute(command: "kubectl delete po  \(pod.metadata.name) -n \(pod.metadata.namespace)")
    }
    
    
    func showDetail(){
        let command = """
        kubectl describe po \(pod.metadata.name) -n \(pod.metadata.namespace)
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
    
}



//struct PodRow_Previews: PreviewProvider {
//    static var previews: some View {
//        let metadata = PodMetadata(name: "pod name", uid: "12312312", namespace: "hippius-dev")
//
//
//        let podStatus = PodStatus(phase: "Running", podIP: "10.244.3.190", hostIP: "192.168.16.148", containerStatuses: [PodContainer(ready: true)])
//
//
//        let pod = Pod(metadata: metadata, status: podStatus)
//
//
//        return PodRow(pod:pod)
//    }
//}
