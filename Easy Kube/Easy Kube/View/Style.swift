//
//  Style.swift
//  Easy Kube
//
//  Created by 王镓耀 on 2020/10/10.
//  Copyright © 2020 codewjy. All rights reserved.
//

import SwiftUI

struct ImgButtonStyle: ButtonStyle {

  func makeBody(configuration: Self.Configuration) -> some View {
    configuration.label
//      .padding()
      .foregroundColor(.white)
      .background(configuration.isPressed ? Color.red : Color.white)
      .cornerRadius(2.0)
  }

}
