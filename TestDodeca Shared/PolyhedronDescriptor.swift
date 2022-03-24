//
//  PolyhedronDescriptor.swift
//  TestDodeca
//
//  Created by juan.c.mendez on 3/22/22.
//

import Foundation
import SceneKit

protocol PolyhedronDescriptor {
  var vertices: [SCNVector3] { get }
  var faces: [[Int8]] { get }
  var wireframeIndices: [Int8] { get }
}
