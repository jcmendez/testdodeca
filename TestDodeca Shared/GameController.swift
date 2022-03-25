//
//  GameController.swift
//  TestDodeca Shared
//
//  Created by juan.c.mendez on 3/22/22.
//

import SceneKit

#if os(watchOS)
import WatchKit
#endif

class GameController: NSObject, SCNSceneRendererDelegate {

  let scene: SCNScene
  let sceneRenderer: SCNSceneRenderer
  let dodeca = Polyhedron(descriptor: DodecahedronDescriptor(), showWireframes: false, showNormals: true)

  init(sceneRenderer renderer: SCNSceneRenderer) {
    sceneRenderer = renderer
    scene = SCNScene()

    super.init()

    sceneRenderer.delegate = self
    let dodecaNode = dodeca.node
    dodecaNode.name = "dodeca"

    scene.rootNode.addChildNode(dodecaNode)
    sceneRenderer.scene = scene
  }

  func rotateNodeTo(x: CGFloat, y: CGFloat) {
    if let dodecaNode = scene.rootNode.childNode(withName: "dodeca", recursively: false) {
      dodecaNode.transform = SCNMatrix4Mult(SCNMatrix4MakeRotation(SCNFloat(x), 1, 0, 0), SCNMatrix4MakeRotation(SCNFloat(y), 0, 1, 0))
    }
  }
  
  func highlightNodes(atPoint point: CGPoint) {

    let hitResults = self.sceneRenderer.hitTest(point, options: [:])
    guard let result = hitResults.first(where: { $0.node.name?.starts(with: "face") ?? false }) else { return }

    if let name = result.node.name {
      print("Hit \(name)")
      print(result.node.worldOrientation, result.node.eulerAngles)
      if let faceIndex = Int(name.dropFirst(5)), let dodecaNode = result.node.parent {
        dodecaNode.removeAllActions()
        let rotationQuaternion = SCNQuaternion( dodeca.quaternionsForRotation[faceIndex].vector)
        print(faceIndex, rotationQuaternion)
        SCNTransaction.animationDuration = 2.0
        SCNTransaction.begin()
        dodecaNode.orientation = rotationQuaternion
        SCNTransaction.commit()
      }
    }
  }

  func renderer(_ renderer: SCNSceneRenderer, updateAtTime time: TimeInterval) {
    // Called before each frame is rendered
  }

}
