//
//  PodContentView.swift
//  Easy Kube
//
//  Created by 王镓耀 on 2020/9/30.
//  Copyright © 2020 codewjy. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    
    @State private var selectedPod: Pod?
    @State private var selectedDeploy: Deploy?
    @State private var selectedNode: KNode?
    @State private var selectedService: Service?
    @EnvironmentObject private var userData: UserData
    private var deployView : DeployList?
    
    var body: some View {
        HStack(alignment: .top){
            TabView()
//                .padding(.trailing,120)
//                .background(Color.clear)

                VStack(alignment:.leading){
                    Filter()
                        .padding(.bottom,-10)
                    
                    ZStack{
                        ListView(rows: [RowData](), objectType: .pod).zIndex("Pods" == userData.selectedTab ? 1:0)
                        ListView(rows: [RowData](), objectType: .deployment).zIndex("Deployments" == userData.selectedTab ? 1:0)
                        ListView(rows: [RowData](), objectType: .node).zIndex("Nodes" == userData.selectedTab ? 1:0)
                        ListView(rows: [RowData](), objectType: .service).zIndex("Services" == userData.selectedTab ? 1:0)
                        ListView(rows: [RowData](), objectType: .statefulSet).zIndex("StatefulSets" == userData.selectedTab ? 1:0)
                        ListView(rows: [RowData](), objectType: .ingress).zIndex("Ingresses" == userData.selectedTab ? 1:0)
                    }
                    
                }.padding(.leading,-9)

        }
//        .background(Color.clear)
        
        
    }
    
    func acceptsFirstMouse(for event: NSEvent?) -> Bool{
        return true
    }
    
    
    
}


//struct ContentView_Previews: PreviewProvider {
//    static var previews: some View {
//        var rows = [Pod]()
//        for index in 1...10 {
//            let metadata = PodMetadata(name: "pod name", uid: String(index), namespace: "hippius-dev")
//            let podStatus = PodStatus(phase: "Running", podIP: "10.244.3.190", hostIP: "192.168.16.148", containerStatuses: [PodContainer(ready: true)])
//            let pod = Pod(metadata: metadata, status: podStatus)
//            rows.append(pod)
//        }
//        return ContentView()
//    }
//}
