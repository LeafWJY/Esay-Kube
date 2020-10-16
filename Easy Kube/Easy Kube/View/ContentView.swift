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
                .padding(.trailing,-8)
            
            ZStack{
                VStack(alignment:.leading){
                    Filter()
                        .padding(.bottom,-10)
                    PodList(pods:[Pod](),selectedPod: $selectedPod)
                    
                }.zIndex("Pod" == userData.selectedTab ? 1:0)
                
                VStack(alignment:.leading){
                    Filter()
                        .padding(.bottom,-10)
                    DeployList(deploys:[Deploy](),selectedDeploy: $selectedDeploy)
                }.zIndex("Deploy" == userData.selectedTab ? 1:0)
                
                VStack(alignment:.leading){
                    Filter()
                        .padding(.bottom,-10)
                    NodeList(nodes: [KNode](),selectedNode: $selectedNode)
                }.zIndex("Node" == userData.selectedTab ? 1:0)
                
                
                VStack(alignment:.leading){
                    Filter()
                        .padding(.bottom,-10)
                    ServiceList(services: [Service](),selectedService: $selectedService)
                }.zIndex("Service" == userData.selectedTab ? 1:0)
            }
            
            
        }
        
        
    }
    
    
    
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        var rows = [Pod]()
        for index in 1...10 {
            let metadata = PodMetadata(name: "pod name", uid: String(index), namespace: "hippius-dev")
            let podStatus = PodStatus(phase: "Running", podIP: "10.244.3.190", hostIP: "192.168.16.148", containerStatuses: [PodContainer(ready: true)])
            let pod = Pod(metadata: metadata, status: podStatus)
            rows.append(pod)
        }
        return ContentView()
    }
}
