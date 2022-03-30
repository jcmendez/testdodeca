//
//  GameViewController.swift
//  TestDodeca macOS
//
//  Created by juan.c.mendez on 3/22/22.
//

import Cocoa
import SceneKit

class GameViewController: NSViewController {
  
  var gameView: SCNView {
    return self.view as! SCNView
  }
  
  var gameController: GameController!
  
  var currentXAngle: Float = 0.0
  var currentYAngle: Float = 0.0
  
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    self.gameController = GameController(sceneRenderer: gameView)
    
    // Allow the user to manipulate the camera
    self.gameView.allowsCameraControl = false
    
    // Show statistics such as fps and timing information
    self.gameView.showsStatistics = true
    
    // Configure the view
    self.gameView.backgroundColor = NSColor.black
    
    // Add a click gesture recognizer
    let clickGesture = NSClickGestureRecognizer(target: self, action: #selector(handleClick(_:)))
    var gestureRecognizers = gameView.gestureRecognizers
    gestureRecognizers.insert(clickGesture, at: 0)
    // And a pan recognizer
    let panGesture = NSPanGestureRecognizer(target: self, action: #selector(handlePan(_:)))
    gestureRecognizers.insert(panGesture, at: 1)
    self.gameView.gestureRecognizers = gestureRecognizers
  }
  
  @objc
  func handleClick(_ gestureRecognizer: NSGestureRecognizer) {
    // Highlight the clicked nodes
    let p = gestureRecognizer.location(in: gameView)
    gameController.highlightNodes(atPoint: p)
  }
  
  @objc
  func handlePan(_ gestureRecognizer: NSPanGestureRecognizer) {
    let translation = gestureRecognizer.translation(in: gestureRecognizer.view!)
    var newXAngle = (Float)(translation.x)*Float.pi/180.0
    var newYAngle = (Float)(translation.y)*Float.pi/180.0
    newXAngle += currentXAngle
    newYAngle += currentYAngle
    gameController.rotateNodeTo(x: CGFloat(newXAngle), y: -CGFloat(newYAngle))
    if(gestureRecognizer.state == NSGestureRecognizer.State.ended) {
      currentXAngle = newXAngle
      currentYAngle = newYAngle
    }
  }
  
}
