//
//  ARKitViewController.swift
//  DebuggingInARKit
//
//  Created by Marcen, Rafael on 8/1/22.
//

import Foundation
import UIKit
import ARKit

class ARKitViewController: UIViewController {
    
    private lazy var scene: SCNScene = {
        let scene = SCNScene(named: "art.scnassets/ship.scn")!
        return scene
    }()
    
    private lazy var shipNode: SCNNode? = self.scene.rootNode.childNode(withName: "shipMesh", recursively: true)
    
    private lazy var sceneView: ARSCNView = {
        let sceneView = ARSCNView()
        sceneView.translatesAutoresizingMaskIntoConstraints = false
        
        // Show statistics such as fps and timing information
        sceneView.showsStatistics = true
        
        // Set the scene to the view
        sceneView.scene = scene
        
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
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Create a session configuration
        let configuration = ARWorldTrackingConfiguration()

        // Run the view's session
        sceneView.session.run(configuration)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        // Pause the view's session
        sceneView.session.pause()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        shipNode?.debugOptions = [.showLocalAxes]
    }
}
