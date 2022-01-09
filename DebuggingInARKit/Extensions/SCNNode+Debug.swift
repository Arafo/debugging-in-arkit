//
//  SCNNode+Debug.swift
//  DebuggingInARKit
//
//  Created by Marcen, Rafael on 2/1/22.
//

import Foundation
import SceneKit

public extension SCNNode {
    
    enum SCNDebugOptions: String {
        case showLocalAxes
    }

    // MARK: - Debug options
    
    private static var _debugOptions = [String: [SCNDebugOptions]]()
    
    var debugOptions: [SCNDebugOptions] {
        get {
            let tmpAddress = String(format: "%p", unsafeBitCast(self, to: Int.self))
            return SCNNode._debugOptions[tmpAddress] ?? []
        }
        set(newValue) {
            let tmpAddress = String(format: "%p", unsafeBitCast(self, to: Int.self))
            SCNNode._debugOptions[tmpAddress] = newValue
            
            removeAxes()
            newValue.forEach { value in
                switch value {
                case .showLocalAxes:
                    addAxes()
                }
            }
        }
    }
}

// MARK: - Utils

private extension SCNNode {
    
    private func addAxes() {
        
        func axis(color: UIColor, rotation: SCNVector4) -> SCNNode {
            let geometry = SCNBox(width: 0.01 * CGFloat(geometry?.lengthOfTheGreatestSide ?? 0),
                                  height: CGFloat(geometry?.lengthOfTheGreatestSide ?? 0) * 0.5,
                                  length: 0.01 * CGFloat(geometry?.lengthOfTheGreatestSide ?? 0),
                                  chamferRadius: 0.0)
            
            let material = SCNMaterial()
            material.diffuse.contents = color
            material.readsFromDepthBuffer = false
            geometry.materials = [material]
            
            let axis = SCNNode(geometry: geometry)
            let offset = geometry.lengthOfTheGreatestSide * 0.5
            axis.pivot = SCNMatrix4MakeTranslation(0, -offset, 0)
            axis.rotation = rotation
            return axis
        }

        let xAxisNode = axis(color: .red, rotation: SCNVector4(0, 0, 1, -.pi * 0.5))
        let yAxisNode = axis(color: .green, rotation: SCNVector4(0, 0, 0, 0))
        let zAxisNode = axis(color: .blue, rotation: SCNVector4(1, 0, 0, .pi * 0.5))
        
        let axesNode = SCNNode()
        axesNode.addChildNode(xAxisNode)
        axesNode.addChildNode(yAxisNode)
        axesNode.addChildNode(zAxisNode)
        
        axesNode.name = SCNDebugOptions.showLocalAxes.rawValue
        axesNode.transform = SCNMatrix4Identity
        addChildNode(axesNode)
    }
    
    private func removeAxes() {
        if let axesNode = childNode(withName: SCNDebugOptions.showLocalAxes.rawValue, recursively: false) {
            axesNode.removeFromParentNode()
        }
    }
}
