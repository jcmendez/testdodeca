//
//  DodecahedronDescriptor.swift
//  TestDodeca
//
//  Created by juan.c.mendez on 3/22/22.
//

import Foundation
import SceneKit

private let t = (1.0 + sqrt(5.0)) / 2.0

struct DodecahedronDescriptor: PolyhedronDescriptor {
  let vertices = [
    SCNVector3(-1, -1, -1).normalized(), // 0
    SCNVector3( 1, -1, -1).normalized(), // 1
    SCNVector3(-1, 1, -1).normalized(), // 2
    SCNVector3( 1, 1, -1).normalized(), // 3
    SCNVector3(-1, -1, 1).normalized(), // 4
    SCNVector3( 1, -1, 1).normalized(), // 5
    SCNVector3(-1, 1, 1).normalized(), // 6
    SCNVector3( 1, 1, 1).normalized(), // 7

    SCNVector3( 0, t, -1/t).normalized(), // 8
    SCNVector3( 0, -t, -1/t).normalized(), // 9
    SCNVector3( 0, t, 1/t).normalized(), // 10
    SCNVector3( 0, -t, 1/t).normalized(), // 11

    SCNVector3(-1/t, 0, t).normalized(), // 12
    SCNVector3(-1/t, 0, -t).normalized(), // 13
    SCNVector3( 1/t, 0, t).normalized(), // 14
    SCNVector3( 1/t, 0, -t).normalized(), // 15

    SCNVector3( t, -1/t, 0).normalized(), // 16
    SCNVector3(-t, -1/t, 0).normalized(), // 17
    SCNVector3( t, 1/t, 0).normalized(), // 18
    SCNVector3(-t, 1/t, 0).normalized()  // 19
  ]

  let faces: [[Int8]] = [
    [1, 9, 11, 5, 16],
    [1, 15, 13, 0, 9],
    [9, 0, 17, 4, 11],
    [11, 4, 12, 14, 5],
    [5, 14, 7, 18, 16],
    [16, 18, 3, 15, 1],
    [0, 13, 2, 19, 17],
    [15, 3, 8, 2, 13],
    [18, 7, 10, 8, 3],
    [14, 12, 6, 10, 7],
    [4, 17, 19, 6, 12],
    [10, 8, 2, 19, 6]
  ]

  let wireframeIndices: [Int8] = [
    0, 9,
    0, 13,
    0, 17,
    1, 9,
    1, 15,
    1, 16,
    2, 8,
    2, 13,
    2, 19,
    3, 8,
    3, 15,
    3, 18,
    4, 11,
    4, 12,
    4, 17,
    5, 11,
    5, 14,
    5, 16,
    6, 10,
    6, 12,
    6, 19,
    7, 10,
    7, 14,
    7, 18,
    8, 10,
    9, 11,
    12, 14,
    13, 15,
    16, 18,
    17, 19
  ]

  /**
   * This is a way to calculate the arrays of indices
   init() {
   var allV = [Int8]()
   for fromV in 0...18 {
   for toV in (fromV+1)...19 {
   let dist = vertices[fromV].distance(vector: vertices[toV])
   if dist < 1.0 {
   allV.append(Int8(fromV))
   allV.append(Int8(toV))
   print("\(fromV), \(toV),")
   }
   }
   }
   wireframeIndices = allV
   }
   
   */
}
