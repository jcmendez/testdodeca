//
//  IcosahedronDescriptor.swift
//  TestDodeca
//
//  Created by juan.c.mendez on 3/22/22.
//

import Foundation
import SceneKit

private let t = (1.0 + sqrt(5.0)) / 2.0;

struct IcosahedronDescriptor: PolyhedronDescriptor {
  let vertices = [
    SCNVector3(-1,  t, 0).normalized(),
    SCNVector3( 1,  t, 0).normalized(),
    SCNVector3(-1, -t, 0).normalized(),
    SCNVector3( 1, -t, 0).normalized(),
    
    SCNVector3(0, -1,  t).normalized(),
    SCNVector3(0,  1,  t).normalized(),
    SCNVector3(0, -1, -t).normalized(),
    SCNVector3(0,  1, -t).normalized(),
    
    SCNVector3( t,  0, -1).normalized(),
    SCNVector3( t,  0,  1).normalized(),
    SCNVector3(-t,  0, -1).normalized(),
    SCNVector3(-t,  0,  1).normalized()
  ]
  
  let planeIndices: [Int8] = [
    7, 5,
    5, 4,
    4, 6,
    6, 7,
    
    0, 1,
    1, 3,
    3, 2,
    2, 0,
    
    10, 11,
    11, 9,
    9, 8,
    8, 10
  ]
  
  let faces: [[Int8]] = [
    [0, 11, 5],
    [0, 5, 1],
    [0, 1, 7],
    [0, 7, 10],
    [0, 10, 11],
    [1, 5, 9],
    [5, 11, 4],
    [11, 10, 2],
    [10, 7, 6],
    [7, 1, 8],
    [3, 9, 4],
    [3, 4, 2],
    [3, 2, 6],
    [3, 6, 8],
    [3, 8, 9],
    [4, 9, 5],
    [2, 4, 11],
    [6, 2, 10],
    [8, 6, 7],
    [9, 8, 1]
  ]
  
  let wireframeIndices: [Int8] = [
    0, 5,
    1, 0,
    1, 5,
    1, 7,
    1, 8,
    1, 9,
    2, 3,
    2, 4,
    2, 6,
    2, 10,
    2, 11,
    3, 6,
    3, 8,
    3, 9,
    4, 3,
    4, 5,
    4, 9,
    5, 9,
    6, 7,
    6, 8,
    6, 10,
    9, 8,
    8, 7,
    7, 0,
    10, 0,
    10, 7,
    10, 11,
    11, 0,
    11, 4,
    11, 5
  ]
}
