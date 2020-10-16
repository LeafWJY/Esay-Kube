////
////  DeployContentView.swift
////  Easy Kube
////
////  Created by 王镓耀 on 2020/10/12.
////  Copyright © 2020 codewjy. All rights reserved.
////
//
//import SwiftUI
//
//struct DeployContentView: View {
//
//    var deploys = [Deploy]()
//
//       @State private var selectedDeploy: Deploy?
//
//       @State private var selectedTab: String = "Deploy"
//
//       @EnvironmentObject private var userData: UserData
//
//       init(pods: [Deploy]) {
//           self.deploys = deploys;
//       }
//
//
//    var body: some View {
//         HStack(alignment: .top){
//                   TabView()
//                       .padding(.trailing,-8)
//                   VStack(alignment:.leading){
//                       Filter()
//                           //                .background(Color.clear)
//                           .padding(.bottom,-10)
//                       PodList(pods:pods,selectedPod: $selectedPod)
//
//                   }
//               }
//    }
//}
//
//struct DeployContentView_Previews: PreviewProvider {
//    static var previews: some View {
//        DeployContentView()
//    }
//}
