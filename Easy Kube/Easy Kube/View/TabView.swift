//
//  TabView.swift
//  Easy Kube
//
//  Created by 王镓耀 on 2020/10/12.
//  Copyright © 2020 codewjy. All rights reserved.
//

import SwiftUI


struct TabView: View {
    
    @EnvironmentObject private var userData: UserData
    
    var body: some View {
        VStack(alignment: .leading){
            HStack {
                Image("logo")
                    .resizable()
                    .aspectRatio(1.0, contentMode: .fill)
                    .frame(width: 34, height: 34)
                Text("Easy Kube")
                    .fontWeight(.bold)
                    .font(.subheadline)
                
                Spacer()
                
            }.padding(.leading,15)
                .padding(.top,30)
                .padding(.bottom,20)
            
            VStack{
            TabButton(tab: "Pods", icon: "pod")
            TabButton(tab: "Services", icon: "service")
            TabButton(tab: "Deployments", icon: "deployment")
            TabButton(tab: "Nodes", icon: "node")
            TabButton(tab: "StatefulSets", icon: "statefulSet")
            TabButton(tab: "Ingresses", icon: "ingress")
            }.padding(.leading,10)
            
            
            Spacer()
            
            HStack{
                Button(action: {}, label: {
                    Image("setting")
                        .resizable()
                        .aspectRatio(1.0, contentMode: .fill)
                        .frame(width: 34, height: 34)
                })
                .buttonStyle(PlainButtonStyle())
            }.padding(10)
          
        }.frame(width:165)
//            .background(Color(hex:0xf0f0f0))
//        .background(VisualEffectView(material: .light, blendingMode: .behindWindow))
        .openBlur()
//        .background(Color.clear)

    
        
        
    }
    
    func changeToPod(){
        userData.selectedTab = "Pod"
    }
    func changeToDeploy(){
        userData.selectedTab = "Deploy"
    }
    func changeToNode(){
        userData.selectedTab = "Node"
    }
    
    func changeToService(){
        userData.selectedTab = "Service"
    }
    
    
    
}




//struct TabView_Previews: PreviewProvider {
//    static var previews: some View {
//        TabView()
//    }
//}



