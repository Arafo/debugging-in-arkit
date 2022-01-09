//
//  SCNBoundingVolume+Debug.swift
//  DebuggingInARKit
//
//  Created by Marcen, Rafael on 2/1/22.
//

import Foundation
import SceneKit

extension SCNBoundingVolume {
    private var height: Float {
        let (min, max) = self.boundingBox
        return max.y - min.y
    }
    
    private var width: Float {
        let (min, max) = self.boundingBox
        return max.x - min.x
    }
    
    private var length: Float {
        let (min, max) = self.boundingBox
        return max.z - min.z
    }
    
    var lengthOfTheGreatestSide: Float {
        return max(width, max(height, length))
    }
}
