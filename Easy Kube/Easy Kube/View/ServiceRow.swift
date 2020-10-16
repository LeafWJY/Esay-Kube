//
//  ServiceRow.swift
//  Easy Kube
//
//  Created by 王镓耀 on 2020/10/13.
//  Copyright © 2020 codewjy. All rights reserved.
//

import SwiftUI

struct ServiceRow: View {
    var service: Service
    
    @State var hovered = false
    
    @State var editHovered = false
    
    var body: some View {
        
        HStack(alignment: .center){
            Image("service")
                .resizable()
                .aspectRatio(1.0, contentMode: .fit)
                .frame(width: 32, height: 32)
                .fixedSize(horizontal: true, vertical: true)
                .cornerRadius(4.0)
                .padding(4)
            VStack(alignment: .leading){
                HStack() {
                    Text(service.metadata.name)
                        .fontWeight(.bold)
                        .truncationMode(.tail)
                        .frame(minWidth: 20)
                    Spacer()
                    Text(service.spec.type)
                        .fontWeight(.bold)
                        .opacity(0.625)
                    Text(service.spec.port)
                        //                        .fontWeight(.light)
                        .opacity(0.625)
                }
                
                HStack() {
                    Text(service.metadata.namespace)
                        .font(.caption)
                        .opacity(0.625)
                        .truncationMode(.middle)
                    Spacer()
                    Button(action: openTerminal, label:  {
                        Image(editHovered ? "edit-hover" : "edit" )
                            .resizable()
                            .frame(width: 16, height: 16)
                            .fixedSize(horizontal: true, vertical: true)
                    })
                        .onHover(perform: editHover)
                        .buttonStyle(ImgButtonStyle())
                }
            }
            
            
        }
        .padding()
        .onHover(perform: openHover)
        .background(hovered ? Color.blue.opacity(0.3) : Color.clear.opacity(0.1))
        .frame(height:65)
        
    }
    
    
    func openTerminal(){
        Terminal.execute(command: "kubectl edit svc \(service.metadata.name) -n \(service.metadata.namespace)")
    }
    
    func openHover(hover: Bool){
        withAnimation{
            self.hovered = hover
        }
        
    }
    
    func editHover(hover: Bool){
        self.editHovered = hover
        
    }
    
}

//struct ServiceRow_Previews: PreviewProvider {
//    static var previews: some View {
//        ServiceRow()
//    }
//}
