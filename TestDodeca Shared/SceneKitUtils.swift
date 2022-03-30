//
//  SceneKitUtils.swift
//  TestDodeca
//
//  Created by juan.c.mendez on 3/23/22.
//

import SceneKit

#if os(macOS)
typealias SCNColor = NSColor
#else
typealias SCNColor = UIColor
#endif

extension SCNColor {
  static var random: SCNColor {
    let red =   UInt32.random(in: 0...255)
    let green = UInt32.random(in: 0...255)
    let blue =  UInt32.random(in: 0...255)
    let color = SCNColor(red: CGFloat(red) / 255, green: CGFloat(green) / 255, blue: CGFloat(blue) / 255, alpha: 1)
    return color
  }

  convenience init?(hexaRGB: String, alpha: CGFloat = 1) {
    var chars = Array(hexaRGB.hasPrefix("#") ? hexaRGB.dropFirst() : hexaRGB[...])
    switch chars.count {
    case 3: chars = chars.flatMap { [$0, $0] }
    case 6: break
    default: return nil
    }
    self.init(red: .init(strtoul(String(chars[0...1]), nil, 16)) / 255,
              green: .init(strtoul(String(chars[2...3]), nil, 16)) / 255,
              blue: .init(strtoul(String(chars[4...5]), nil, 16)) / 255,
              alpha: alpha)
  }
  
  static let chartColors: [SCNColor] = [
    SCNColor(hexaRGB: "#90A4AE")!,
    SCNColor(hexaRGB: "#F44336")!,
    SCNColor(hexaRGB: "#5C6BC0")!,
    SCNColor(hexaRGB: "#009688")!,
    SCNColor(hexaRGB: "#FFEB3B")!,
    SCNColor(hexaRGB: "#795548")!,
    SCNColor(hexaRGB: "#5E35B1")!,
    SCNColor(hexaRGB: "#00ACC1")!,
    SCNColor(hexaRGB: "#C0CA33")!,
    SCNColor(hexaRGB: "#F48FB1")!,
    SCNColor(hexaRGB: "#90CAF9")!,
    SCNColor(hexaRGB: "#A5D6A7")!,
    SCNColor(hexaRGB: "#FFE082")!
  ]
}
