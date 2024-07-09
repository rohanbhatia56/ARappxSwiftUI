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
    let arview = ARView(frame: .zero)
    var body: some View {

        VStack(spacing: Numbers.spacingMed) {
           if viewModel.showARView {
              ARViewContainer(viewModel: viewModel,arView: arview).edgesIgnoringSafeArea(.all)
          } else {
              Text(viewModel.selectedAssetName)
                .font(.title)
                .multilineTextAlignment(.center)
                .padding()
              
              Button(UIMessages.AeroplaneButtonString) {
                  viewModel.setAsset(name: GameAssets.Aeoplane)
                  viewModel.displayARView()
              }
              
              Button(UIMessages.CarButtonString) {
                  viewModel.setAsset(name: GameAssets.Car)
                  viewModel.displayARView()
              }
          }
        }
        .onAppear{
            viewModel.setupARConfigurations()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
