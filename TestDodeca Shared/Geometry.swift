//
//  Geometry.swift
//  TestDodeca
//
//  Created by juan.c.mendez on 3/22/22.
//

import Foundation
import SceneKit

class Geometry : NSObject {
  
  // Creates a geometry object from given vertex, index and type data
  internal func createGeometry(vertices:[SCNVector3], indices:[Int32], primitiveType:SCNGeometryPrimitiveType) -> SCNGeometry {
    
    // Computed property that indicates the number of primitives to create based on primitive type
    var primitiveCount:Int {
      get {
        switch primitiveType {
        case .line:
          return indices.count / 2
        case .point:
          return indices.count
        case .triangles, .triangleStrip:
          return indices.count / 3
        case .polygon:
          abort()
        @unknown default:
          abort()
        }
      }
    }
    
    // Create the source and elements in the appropriate format
    let data = NSData(bytes: vertices, length: MemoryLayout<SCNVector3>.size * vertices.count) as Data
    let vertexSource = SCNGeometrySource(
      data: data, semantic: SCNGeometrySource.Semantic.vertex,
      vectorCount: vertices.count, usesFloatComponents: true, componentsPerVector: 3,
      bytesPerComponent: MemoryLayout<Float>.size, dataOffset: 0, dataStride: MemoryLayout<SCNVector3>.size)
    let indexData: Data = NSData(bytes: indices, length: MemoryLayout<Int32>.size * indices.count) as Data
    let element = SCNGeometryElement(
      data: indexData, primitiveType: primitiveType,
      primitiveCount: primitiveCount, bytesPerIndex: MemoryLayout<Int32>.size)
    
    return SCNGeometry(sources: [vertexSource], elements: [element])
  }
}
