//
//  Coordinator.swift
//  ARapp2
//
//  Created by Rohan Bhatia on 09/07/24.
//

import SwiftUI
import ARKit
import RealityKit

class Coordinator: NSObject {   
    var view: ARView?
    var viewModel: ARViewModel?

    @objc
    func handleLongPress(_ recognizer: UITapGestureRecognizer? = nil) {
        guard let view = self.view else { return }
        let tapLocation = recognizer!.location(in: view)
        if let entity = view.entity(at: tapLocation) as? ModelEntity {
            if let anchorEntity = entity.anchor {
                viewModel?.setSelectedAssetName(name: viewModel?.assetName)
                viewModel?.hideARView()
            }
        }
    }
    
    @objc
    func handleTap(_ recognizer: UITapGestureRecognizer? = nil) {
        //TODO
    }
}
