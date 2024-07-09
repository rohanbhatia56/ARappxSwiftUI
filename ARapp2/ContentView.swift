//
//  ContentView.swift
//  ARapp2
//
//  Created by Rohan Bhatia on 09/07/24.
//

import SwiftUI
import RealityKit
import ARKit

struct ContentView : View {
    @StateObject private var viewModel = ARViewModel()
    var body: some View {
        VStack(spacing: 20) {
          // Your view to show/hide conditionally
           if viewModel.showARView {
              ARViewContainer(viewModel: viewModel).edgesIgnoringSafeArea(.all)
          }else {
              Text(viewModel.selectedAssetName)
                .font(.title)
                .multilineTextAlignment(.center)
                .padding()
              // Your other UI elements here
              Button("Airplane experience") {
                  // Add your button action here (e.g., print a message)
                  print("Button clicked!")
                    viewModel.assetName = "toy_biplane_idle.usdz"
                    viewModel.displayARView()
              }
              Button("Car experience") {
                // Add your button action here (e.g., print a message)
                  viewModel.assetName = "toy_car.usdz"
                print("Button clicked!")
                  viewModel.displayARView()
              }
          }
        }
    }
}

struct ARViewContainer: UIViewRepresentable {
    @ObservedObject var viewModel: ARViewModel

    // Instantiate and return a Coordinator object
   func makeCoordinator() -> Coordinator {
       return Coordinator()
   }
    
    func makeUIView(context: Context) -> ARView {
        
        let arView = ARView(frame: .zero)
        
        let config = ARWorldTrackingConfiguration()
        config.planeDetection = [.horizontal,.vertical]
        config.environmentTexturing = .automatic

        return arView
    }
    
    func updateUIView(_ uiView: ARView, context: Context) {

       let anchorEntity = AnchorEntity(plane: .any)
           
        guard let modelEntity = try? Entity.loadModel(named: viewModel.assetName) else { return }

       modelEntity.generateCollisionShapes(recursive: true)
       
       anchorEntity.addChild(modelEntity)

       // Set the 'view' property of the coordinator to the 'uiView' passed as an argument.
       context.coordinator.view = uiView
        context.coordinator.viewModel = viewModel
       // Create a UILongPressGestureRecognizer to detect long-press gestures.
       let longPressGesture = UILongPressGestureRecognizer(target: context.coordinator, action: #selector(Coordinator.handleLongPress(_:)))

       // Add the UILongPressGestureRecognizer to the 'uiView' for user interaction.
       uiView.addGestureRecognizer(longPressGesture)
       uiView.installGestures([.all], for: modelEntity as Entity & HasCollision)
       uiView.scene.addAnchor(anchorEntity)
    }
}

class Coordinator: NSObject {
    var view: ARView?
    var viewModel: ARViewModel?

    @objc
    func handleLongPress(_ recognizer: UITapGestureRecognizer? = nil) {
        print("handleLongPress")
        
        // Check if there is a view to work with
        guard let view = self.view else { return }

        // Obtain the location of a tap or touch gesture
        let tapLocation = recognizer!.location(in: view)

        // Checking if there's an entity at the tapped location within the view
        if let entity = view.entity(at: tapLocation) as? ModelEntity {
  
            // Check if this entity is anchored to an anchor
            if let anchorEntity = entity.anchor {
                // Remove the model from the scene
//                anchorEntity.removeFromParent()
                viewModel?.selectedAssetName = viewModel?.assetName ?? "asset name"
                
                print(anchorEntity.name)
                
                viewModel?.hideARView()
            }else{
                
            }
        }
    }
    
    @objc
    func handleTap(_ recognizer: UITapGestureRecognizer? = nil) {
        print("handle Tap")
    }
}

#Preview {
    ContentView()
}
