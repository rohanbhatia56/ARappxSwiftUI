//
//  ARModel.swift
//  ARapp2
//
//  Created by Rohan Bhatia on 09/07/24.
//

import Foundation
import RealityKit

@available(iOS 13.0, *)
struct ARModel {
    
    private(set) var arView : ARView
    init() {
        arView = ARView(frame: .zero)
    }
}
