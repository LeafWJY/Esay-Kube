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
    
    @State var detailHovered = false
    
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
                        .opacity(0.625)
                }
                
                HStack() {
                    Text(service.metadata.namespace)
                        .font(.caption)
                        .opacity(0.625)
                        .truncationMode(.middle)
                    Spacer()
                    Button(action: openTerminal, label:  {
                        VStack{
                        Image(editHovered ? "edit-hover" : "edit" )
                            .resizable()
                            .frame(width: 16, height: 16)
                            .fixedSize(horizontal: true, vertical: true)
                        Text("edit")
                            .font(.system(size: 8))
                            .padding(.top,-5)
                            .foregroundColor(Color.black)
                        }
                    })
                        .onHoverAware( editHover)
                        .buttonStyle(ImgButtonStyle())
                    Button(action: showDetail, label:  {
                        VStack{
                            Image("detail")
                                .resizable()
                                .frame(width: 16, height: 16)
                                .fixedSize(horizontal: true, vertical: true)
                                .colorMultiply(detailHovered ? Color(hex:0x66CCFF) : Color.black.opacity(0.8))
                            Text("desc")
                                .font(.system(size: 8))
                                .padding(.top,-5)
                                .foregroundColor(Color.black)
                        }.background(hovered ? Color(hex:0x66CCFF,alpha: 0.3) : Color.clear)
                        .overlay(AcceptingFirstMouse())
                    }).onHoverAware( detailHovered)
                    .buttonStyle(ImgButtonStyle())
                }
            }
            
            
        }
        .padding()
        .onHoverAware( openHover)
        .background(hovered ? Color(hex:0x66CCFF,alpha: 0.3)  : Color.clear)
        .frame(height:65)
        
    }
    
    func showDetail(){
        let command = """
        kubectl describe svc \(service.metadata.name) -n \(service.metadata.namespace)
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
    

    
    func openTerminal(){
        Terminal.execute(command: "kubectl edit svc \(service.metadata.name) -n \(service.metadata.namespace)")
    }
    
    func openHover(hover: Bool){
        withAnimation{
            self.hovered = hover
        }
        
    }
    
    func detailHovered(hover: Bool){
        self.detailHovered = hover
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
