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
  
  init(sceneRenderer renderer: SCNSceneRenderer) {
    sceneRenderer = renderer
    scene = SCNScene(named: "Art.scnassets/ship.scn")!
    
    super.init()
    
    sceneRenderer.delegate = self
    
    if let ship = scene.rootNode.childNode(withName: "ship", recursively: true) {
      ship.removeFromParentNode()
    }
    
    let icosa = Polyhedron(descriptor: IcosahedronDescriptor(),showWireframes: true, showFaces: true)
    let icosaNode = icosa.node

    let dodeca = Polyhedron(descriptor: DodecahedronDescriptor(),showVertices: true)
    let dodecaNode = dodeca.node
    
    scene.rootNode.addChildNode(dodecaNode)
    scene.rootNode.addChildNode(icosaNode)
    
    icosaNode.localTranslate(by: SCNVector3(-2,0,0))
    icosaNode.runAction(SCNAction.repeatForever(SCNAction.rotateBy(x: -0.01, y: -0.2, z: -0.01, duration: 1)))
    
    dodecaNode.localTranslate(by: SCNVector3(2,0,0))
    dodecaNode.runAction(SCNAction.repeatForever(SCNAction.rotateBy(x: 0.01, y: 0.2, z: 0.01, duration: 1)))
    sceneRenderer.scene = scene
  }
  
  func highlightNodes(atPoint point: CGPoint) {
    let hitResults = self.sceneRenderer.hitTest(point, options: [:])
    for result in hitResults {
      
      if let name = result.node.name {
        print("Hit \(name)")
      }
      
      // get its material
      guard let material = result.node.geometry?.firstMaterial else {
        return
      }
      
      let oldEmissionContents = material.emission.contents
      
      // highlight it
      SCNTransaction.begin()
      SCNTransaction.animationDuration = 0.5
      
      // on completion - unhighlight
      SCNTransaction.completionBlock = {
        SCNTransaction.begin()
        SCNTransaction.animationDuration = 0.5
        
        material.emission.contents = oldEmissionContents
        
        SCNTransaction.commit()
      }
      
      material.emission.contents = SCNColor.red
      
      SCNTransaction.commit()
    }
  }
  
  func renderer(_ renderer: SCNSceneRenderer, updateAtTime time: TimeInterval) {
    // Called before each frame is rendered
  }
  
}
