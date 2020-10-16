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
        VStack(alignment: .center){
            Image("logo")
                .resizable()
                .aspectRatio(1.0, contentMode: .fit)
                .frame(width: 40, height: 40)
                .fixedSize(horizontal: true, vertical: true)
                .padding(.top,30)
            
            Button(action: changeToPod) { Text("P")
                .font(.largeTitle)
                .fontWeight(.bold)
                .foregroundColor("Pod" == userData.selectedTab ? Color.blue.opacity(0.9) : Color.gray)
                .multilineTextAlignment(.center)
                .padding()
                .frame(width:60,height: 60)
//                .background(Color.gray.opacity(0.2))
                
            }.buttonStyle(PlainButtonStyle())
            
            Button(action: changeToService) { Text("S")
                .font(.largeTitle)
                .fontWeight(.bold)
                 .foregroundColor("Service" == userData.selectedTab ? Color.blue.opacity(0.9) : Color.gray)
                .multilineTextAlignment(.center)
                .padding()
                .frame(width:60,height: 60)
                
            }.buttonStyle(PlainButtonStyle())
            
            Button(action: changeToDeploy) { Text("D")
                .font(.largeTitle)
                .fontWeight(.bold)
                 .foregroundColor("Deploy" == userData.selectedTab ? Color.blue.opacity(0.9) : Color.gray)
                .multilineTextAlignment(.center)
                .padding()
                .frame(width:60,height: 60)
//                 .background(Color.gray.opacity(0.2))
                
            }.buttonStyle(PlainButtonStyle())
            Button(action: changeToNode) { Text("N")
                .font(.largeTitle)
                .fontWeight(.bold)
                 .foregroundColor("Node" == userData.selectedTab ? Color.blue.opacity(0.9) : Color.gray)
                .multilineTextAlignment(.center)
                .padding()
                .frame(width:60,height: 60)
                
            }.buttonStyle(PlainButtonStyle())
            Spacer()
        }.frame(width:68)
            .background(Color.gray.opacity(0.2))
        
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

struct TabView_Previews: PreviewProvider {
    static var previews: some View {
        TabView()
    }
}
