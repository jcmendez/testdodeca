//
//  SCNVector3+Utils.swift
//  TestDodeca
//
//  Created by juan.c.mendez on 3/22/22.
//

import Foundation
import SceneKit

extension SCNVector3 {
  func length() -> CGFloat {
    return sqrt(x*x + y*y + z*z)
  }
  
  func normalized() -> SCNVector3 {
    if self.length() == 0 {
      return self
    }
    return self / self.length()
  }
  
  /**
   * Divides the x, y and z fields of a SCNVector3 by the same scalar value and
   * returns the result as a new SCNVector3.
   */
  static func / (vector: SCNVector3, scalar: CGFloat) -> SCNVector3 {
      return SCNVector3Make(vector.x / scalar, vector.y / scalar, vector.z / scalar)
  }
}

