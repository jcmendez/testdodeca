//
//  GameViewController.swift
//  TestDodeca iOS
//
//  Created by juan.c.mendez on 3/22/22.
//

import UIKit
import SceneKit

class GameViewController: UIViewController {

  var gameView: SCNView {
    return self.view as! SCNView
  }

  var gameController: GameController!
  
  var currentXAngle: Float = 0.0
  var currentYAngle: Float = 0.0

  override func viewDidLoad() {
    super.viewDidLoad()

    self.gameController = GameController(sceneRenderer: gameView)

    // Don't allow the user to manipulate the camera
    self.gameView.allowsCameraControl = false

    // Show statistics such as fps and timing information
    self.gameView.showsStatistics = true

    // Configure the view
    self.gameView.backgroundColor = UIColor.black

    var gestureRecognizers = gameView.gestureRecognizers ?? []
    // Add a tap gesture recognizer
    let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTap(_:)))
    gestureRecognizers.insert(tapGesture, at: 0)
    // And a pan recognizer
    let panGesture = UIPanGestureRecognizer(target: self, action: #selector(handlePan(_:)))
    gestureRecognizers.insert(panGesture, at: 1)
    self.gameView.gestureRecognizers = gestureRecognizers
  }

  @objc
  func handleTap(_ gestureRecognizer: UIGestureRecognizer) {
    // Highlight the tapped nodes
    let p = gestureRecognizer.location(in: gameView)
    gameController.highlightNodes(atPoint: p)
  }
  
  @objc
  func handlePan(_ gestureRecognizer: UIPanGestureRecognizer) {
    let translation = gestureRecognizer.translation(in: gestureRecognizer.view!)
    var newXAngle = (Float)(translation.x)*Float.pi/180.0
    var newYAngle = (Float)(translation.y)*Float.pi/180.0
    newXAngle += currentXAngle
    newYAngle += currentYAngle
    gameController.rotateNodeTo(x: CGFloat(newXAngle), y: CGFloat(newYAngle))
    if(gestureRecognizer.state == UIGestureRecognizer.State.ended) {
      currentXAngle = newXAngle
      currentYAngle = newYAngle
    }
  }

  override var shouldAutorotate: Bool {
    return true
  }

  override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
    if UIDevice.current.userInterfaceIdiom == .phone {
      return .allButUpsideDown
    } else {
      return .all
    }
  }

  override var prefersStatusBarHidden: Bool {
    return true
  }

}
