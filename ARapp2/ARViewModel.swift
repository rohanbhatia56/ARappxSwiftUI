import SwiftUI
import RealityKit

class ARViewModel: ObservableObject {
    @Published var assetName: String = ""
    @Published var showARView: Bool = false
    @Published var selectedAssetName = "Go the experience and long press the asset to display its name"
    // Add more properties and methods as needed
    func displayARView() {
        self.showARView = true
    }
    func hideARView() {
        self.showARView = false
    }
}
