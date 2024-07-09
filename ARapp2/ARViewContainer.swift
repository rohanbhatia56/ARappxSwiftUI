//
//  ARViewContainer.swift
//  ARapp2
//
//  Created by Rohan Bhatia on 09/07/24.
//

import SwiftUI
import ARKit
import RealityKit

struct ARViewContainer: UIViewRepresentable {
    @ObservedObject var viewModel: ARViewModel
    let arView:ARView?

   func makeCoordinator() -> Coordinator {
       return Coordinator()
   }
    
    func makeUIView(context: Context) -> ARView {
        return arView!
    }
    
    func updateUIView(_ uiView: ARView, context: Context) {
        
       let anchorEntity = AnchorEntity(plane: .any)
           
       guard let modelEntity = try? Entity.loadModel(named: viewModel.assetName) else { return }

       modelEntity.generateCollisionShapes(recursive: true)
        
       anchorEntity.addChild(modelEntity)
        
        
       context.coordinator.view = uiView
       context.coordinator.viewModel = viewModel

        // Create a UILongPressGestureRecognizer to detect long-press gestures.
        let longPressGesture = UILongPressGestureRecognizer(target: context.coordinator, action: #selector(Coordinator.handleLongPress(_:)))
        let tapPressGesture = UITapGestureRecognizer(target: context.coordinator, action: #selector(Coordinator.handleTap(_:)))
        
        uiView.installGestures([.all], for: modelEntity as Entity & HasCollision)

        // Add the UILongPressGestureRecognizer to the 'uiView' for user interaction.
        uiView.addGestureRecognizer(longPressGesture)

        
       uiView.scene.addAnchor(anchorEntity)
    }
}
