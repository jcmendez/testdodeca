//
//  Polyhedron.swift
//  TestDodeca
//
//  Created by juan.c.mendez on 3/22/22.
//

import Foundation
import SceneKit

class Polyhedron {
  
  let descriptor: PolyhedronDescriptor
  let showFaces: Bool
  let showWireframes: Bool
  let showVertices: Bool
  
  init(descriptor: PolyhedronDescriptor, showWireframes: Bool = true, showFaces: Bool = true, showVertices: Bool = false) {
    self.descriptor = descriptor
    self.showFaces = showFaces
    self.showWireframes = showWireframes
    self.showVertices = showVertices
  }

  
  lazy var wireframe:SCNGeometry = {
    return self.createGeometry(
      vertices: descriptor.vertices, indices: descriptor.wireframeIndices,
      primitiveType: SCNGeometryPrimitiveType.line)
  }()
  
  lazy var faceGeometryArray:[SCNGeometry] = {
    return descriptor.faces.map { faceIndices in
      let t = polygonIndexesToTriangles(arr: faceIndices)
      let g = createGeometry(vertices: descriptor.vertices, indices: t, primitiveType: .triangles)
      if let m = g.materials.first {
        m.isDoubleSided = true
        let c = SCNColor.random
        m.emission.contents = c
      }
      return g
    }
  }()
  
  // For now unused
  lazy var planes:SCNGeometry = {
    return self.createGeometry(
      vertices: descriptor.vertices, indices: descriptor.planeIndices,
      primitiveType: SCNGeometryPrimitiveType.line)
  }()
  
  lazy var node: SCNNode = {
    let n = SCNNode()
    if showVertices {
      for (i,v) in descriptor.vertices.enumerated() {
        let text = String(i)
        let vNode = SCNNode(geometry: SCNText(string: text, extrusionDepth: 0.01))
        vNode.localTranslate(by: v)
        vNode.scale = SCNVector3(textScale, textScale, textScale)
        n.addChildNode(vNode)
      }
    }
    if showFaces {
      for (i,v) in faceGeometryArray.enumerated() {
        let faceNode = SCNNode(geometry: v)
        faceNode.name = "face \(i)"
        n.addChildNode(faceNode)
      }
    }
    if showWireframes {
      let wireframeNode = SCNNode(geometry: wireframe)
      wireframeNode.name = "wireframe"
      n.addChildNode(wireframeNode)
    }
    return n
  }()
  
  // Creates a geometry object from given vertex, index and type data
  internal func createGeometry(vertices:[SCNVector3], indices:[Int8], primitiveType:SCNGeometryPrimitiveType) -> SCNGeometry {
    
    let vertexSource = SCNGeometrySource(vertices: vertices)
    let element = SCNGeometryElement(indices: indices, primitiveType: primitiveType)
    let geometry = SCNGeometry(sources: [vertexSource], elements: [element])
    return geometry
  }
}

private let textScale: CGFloat = 0.004

private func polygonIndexesToTriangles(arr: [Int8]) -> [Int8] {
  switch arr.count {
  case 3:
    return arr
  case 5:
    return [arr[0], arr[1], arr[2], arr[0], arr[2], arr[3], arr[0], arr[3], arr[4]]
  default:
    abort()
  }
}
