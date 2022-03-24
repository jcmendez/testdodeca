//
//  SceneKitUtils.swift
//  TestDodeca
//
//  Created by juan.c.mendez on 3/23/22.
//

import SceneKit

#if os(macOS)
typealias SCNColor = NSColor

extension NSColor {
    static var random: NSColor {
        let red =   UInt32.random(in: 0...255)
        let green = UInt32.random(in: 0...255)
        let blue =  UInt32.random(in: 0...255)
        let color = NSColor(red: CGFloat(red) / 255, green: CGFloat(green) / 255, blue: CGFloat(blue) / 255, alpha: 1)
        return color
    }
}
#else
typealias SCNColor = UIColor

extension UIColor {
    static var random: UIColor {
        let red =   UInt32.random(in: 0...255)
        let green = UInt32.random(in: 0...255)
        let blue =  UInt32.random(in: 0...255)
        let color = UIColor(red: CGFloat(red) / 255, green: CGFloat(green) / 255, blue: CGFloat(blue) / 255, alpha: 1)
        return color
    }
}
#endif
