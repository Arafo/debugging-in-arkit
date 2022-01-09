//
//  SelectorViewController.swift
//  DebuggingInARKit
//
//  Created by Marcen, Rafael on 8/1/22.
//

import Foundation
import UIKit

class SelectorViewController: UIViewController {
    
    private lazy var container: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [arkitButton, scenekitButton])
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.distribution = .fillProportionally
        stack.axis = .vertical
        return stack
    }()
    
    private lazy var arkitButton: UIButton = {
        let button = UIButton(type: .custom,
                              primaryAction: UIAction(title: "ARKit",
                                                      handler: { _ in
            self.present(ARKitViewController(), animated: true, completion: nil)
        }))
        button.backgroundColor = .systemBlue
        return button
    }()
    
    private lazy var scenekitButton: UIButton = {
        let button = UIButton(type: .custom,
                              primaryAction: UIAction(title: "SceneKit",
                                                      handler: { _ in
            self.present(SceneKitViewController(), animated: true, completion: nil)
        }))
        button.backgroundColor = .systemGreen
        return button
    }()
    
    override func loadView() {
        super.loadView()
        
        view.addSubview(container)
        NSLayoutConstraint.activate([
            container.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            container.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            container.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            container.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor)
        ])
    }
}
