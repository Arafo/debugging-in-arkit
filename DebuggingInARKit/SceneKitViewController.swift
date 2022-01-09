//
//  SceneKitViewController.swift
//  DebuggingInARKit
//
//  Created by Marcen, Rafael on 1/1/22.
//

import UIKit
import SceneKit

class SceneKitViewController: UIViewController {
    
    private lazy var scene: SCNScene = {
        let scene = SCNScene(named: "art.scnassets/ship.scn")!
        return scene
    }()
    
    private lazy var shipNode: SCNNode? = self.scene.rootNode.childNode(withName: "shipMesh", recursively: true)

    private lazy var sceneView: SCNView = {
        let sceneView = SCNView()
        sceneView.translatesAutoresizingMaskIntoConstraints = false
        
        // Show statistics such as fps and timing information
        sceneView.showsStatistics = true
        
        // Set the scene to the view
        sceneView.scene = scene
        
        // Allows camera control
        sceneView.allowsCameraControl = true
        
        // Show debug options
        sceneView.debugOptions = [
            .showBoundingBoxes,
            //.showWireframe,
            //.renderAsWireframe,
            .showSkeletons,
            .showCreases,
            .showConstraints,
            .showCameras,
            .showLightInfluences,
            .showLightExtents,
            .showPhysicsShapes,
            .showPhysicsFields,
            .showFeaturePoints,
            .showWorldOrigin
        ]
        return sceneView
    }()
    
    private lazy var closeButton: UIButton = {
        var config = UIButton.Configuration.tinted()
        config.image = UIImage(systemName: "xmark")

        let button = UIButton(configuration: config,
                              primaryAction: UIAction() { _ in
            self.dismiss(animated: true, completion: nil)
        })
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private lazy var debugButton: UIButton = {
        var config = UIButton.Configuration.tinted()
        config.image = UIImage(systemName: "ladybug")
        config.imagePlacement = .trailing
        config.imagePadding = 8.0

        let button = UIButton(configuration: config,
                              primaryAction: UIAction() { _ in
            guard let node = self.shipNode else { return }
            node.debugOptions = node.debugOptions.contains(.showLocalAxes) ? [] : [.showLocalAxes]
        })
        button.configurationUpdateHandler = { [unowned self] button in
            var config = button.configuration
            guard let node = self.shipNode else { return }
            config?.title = node.debugOptions.contains(.showLocalAxes) ? "Hide local axes" : "Show local axes"
            button.configuration = config
        }
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    override func loadView() {
        super.loadView()
        
        view.addSubview(sceneView)
        view.addConstraints([
            sceneView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            sceneView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            sceneView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            sceneView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
        ])
        
        view.addSubview(closeButton)
        NSLayoutConstraint.activate([
            closeButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 8),
            closeButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -8)
        ])
        
        view.addSubview(debugButton)
        NSLayoutConstraint.activate([
            debugButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -24),
            debugButton.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor)
        ])
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        shipNode?.runAction(SCNAction.repeatForever(SCNAction.rotateBy(x: 0, y: 2, z: 0, duration: 5)))
    }
}
