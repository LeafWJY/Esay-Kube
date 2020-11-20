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
//      .foregroundColor(.white)
//      .background(configuration.isPressed ? Color.red : Color.white)
      .cornerRadius(2.0)
  }

}

extension Color {
    init(hex: Int, alpha: Double = 1) {
        let components = (
            R: Double((hex >> 16) & 0xff) / 255,
            G: Double((hex >> 08) & 0xff) / 255,
            B: Double((hex >> 00) & 0xff) / 255
        )
        self.init(
            .sRGB,
            red: components.R,
            green: components.G,
            blue: components.B,
            opacity: alpha
        )
    }
}

extension NSTextField {
    open override var focusRingType: NSFocusRingType {
        get { .none }
        set { }
    }
}



struct VisualEffectView: NSViewRepresentable
{
    var material: NSVisualEffectView.Material
    var blendingMode: NSVisualEffectView.BlendingMode

    func makeNSView(context: Context) -> NSVisualEffectView
    {
        let visualEffectView = NSVisualEffectView()
        visualEffectView.material = material
        visualEffectView.blendingMode = blendingMode
        visualEffectView.state = .followsWindowActiveState
        return visualEffectView
    }

    func updateNSView(_ visualEffectView: NSVisualEffectView, context: Context)
    {
        visualEffectView.material = material
        visualEffectView.blendingMode = blendingMode
    }
}

extension View {
    
    func openBlur() ->  some View{
        return self.background(VisualEffectView(material: .underWindowBackground, blendingMode: .behindWindow))
    }
    
}



public extension View {
    func onHoverAware(_ perform: @escaping (Bool) -> Void) -> some View {
        background(HoverAwareView { (value: Bool) in
            perform(value)
        })
    }
}
public struct HoverAwareView: View {
    public let onHover: (Bool) -> Void
    public var body: some View {
        Representable(onHover: onHover)
    }
}
private extension HoverAwareView {
    final class Representable: NSViewRepresentable {
        let onHover: (Bool) -> Void
        init(onHover: @escaping (Bool) -> Void) {
            self.onHover = onHover
        }
        func makeNSView(context: Context) -> NSHoverAwareView {
            NSHoverAwareView(onHover: onHover)
        }
        func updateNSView(_ nsView: NSHoverAwareView, context: Context) {}
    }
}
private extension HoverAwareView {
    final class NSHoverAwareView: NSView {
        let onHover: (Bool) -> Void
        init(onHover: @escaping (Bool) -> Void) {
            self.onHover = onHover
            super.init(frame: .zero)
        }
        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
        override func updateTrackingAreas() {
            for area in trackingAreas {
                removeTrackingArea(area)
            }
            guard bounds.size.width > 0, bounds.size.height > 0 else { return }
            let options: NSTrackingArea.Options = [
                .mouseEnteredAndExited,
                .activeAlways,
                .assumeInside,
            ]
            let trackingArea: NSTrackingArea = NSTrackingArea(rect: bounds, options: options, owner: self, userInfo: nil)
            addTrackingArea(trackingArea)
        }
        override func mouseEntered(with event: NSEvent) {
            onHover(true)
        }
        override func mouseExited(with event: NSEvent) {
            onHover(false)
        }
    }
}


// Just mouse accepter
class MyViewView : NSView {
    override func acceptsFirstMouse(for event: NSEvent?) -> Bool {
        return true
    }
}

// Representable wrapper (bridge to SwiftUI)
struct AcceptingFirstMouse : NSViewRepresentable {
    func makeNSView(context: NSViewRepresentableContext<AcceptingFirstMouse>) -> MyViewView {
        return MyViewView()
    }

    func updateNSView(_ nsView: MyViewView, context: NSViewRepresentableContext<AcceptingFirstMouse>) {
        nsView.setNeedsDisplay(nsView.bounds)
    }

    typealias NSViewType = MyViewView
    
}


enum ObjectType:String {
    case pod
    case service
    case deployment
    case node
    case statefulSet
    case ingress
}
