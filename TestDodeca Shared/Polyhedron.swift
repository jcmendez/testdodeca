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
  let showNormals: Bool

  init(descriptor: PolyhedronDescriptor, showWireframes: Bool = true, showFaces: Bool = true, showVertices: Bool = false, showNormals: Bool = false) {
    self.descriptor = descriptor
    self.showFaces = showFaces
    self.showWireframes = showWireframes
    self.showVertices = showVertices
    self.showNormals = showNormals
  }

  lazy var wireframe: SCNGeometry = {
    return self.createGeometry(
      vertices: descriptor.vertices, indices: descriptor.wireframeIndices,
      primitiveType: SCNGeometryPrimitiveType.line)
  }()

  lazy var faceGeometryArray: [SCNGeometry] = {
    return descriptor.faces.map { faceIndices in
      let t = polygonIndexesToTriangles(arr: faceIndices)
      let g = createGeometry(vertices: descriptor.vertices, indices: t, primitiveType: .triangles)
      if let m = g.materials.first {
        m.isDoubleSided = true
        let c = SCNColor.random
        m.diffuse.contents = c
      }
      return g
    }
  }()

  lazy var normalVectors: [SCNVector3] = {
    return descriptor.faces.map { faceIndices in
      let points = faceIndices.map { descriptor.vertices[Int($0)] }
      let v1 = points[0]-points[1]
      let v2 = points[0]-points[2]
      return v2.cross(v1).normalized()
    }
  }()
  
  lazy var normalVectorGeometryArray: [SCNGeometry] = {
    let center = SCNVector3(0, 0, 0)
    return normalVectors.map { vector in
      return self.createGeometry(vertices: [center, vector], indices: [0,1], primitiveType: .line)
    }
  }()

  lazy var node: SCNNode = {
    let n = SCNNode()
    if showVertices {
      for (i, v) in descriptor.vertices.enumerated() {
        let text = String(i)
        let vNode = SCNNode(geometry: SCNText(string: text, extrusionDepth: 0.01))
        vNode.localTranslate(by: v)
        vNode.scale = SCNVector3(textScale, textScale, textScale)
        n.addChildNode(vNode)
      }
    }
    if showFaces {
      for (i, v) in faceGeometryArray.enumerated() {
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
    if showNormals {
      for (i,v) in normalVectorGeometryArray.enumerated() {
        let node = SCNNode(geometry: v)
        node.name = "normal \(i)"
        n.addChildNode(node)
        let text = String(i)
        let vNode = SCNNode(geometry: SCNText(string: text, extrusionDepth: 0.01))
        vNode.localTranslate(by: normalVectors[i])
        vNode.scale = SCNVector3(textScale, textScale, textScale)
        n.addChildNode(vNode)
      }
    }
    return n
  }()

  // Creates a geometry object from given vertex, index and type data
  internal func createGeometry(vertices: [SCNVector3], indices: [Int8], primitiveType: SCNGeometryPrimitiveType) -> SCNGeometry {

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
