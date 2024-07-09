import SwiftUI
import RealityKit
import ARKit

class ARViewModel: ObservableObject {
    @Published var assetName: String = ""
    @Published var showARView: Bool = false
    @Published var selectedAssetName = UIMessages.WelcomeMesage
    
    func setupARConfigurations() -> ARWorldTrackingConfiguration {
        let config = ARWorldTrackingConfiguration()
        config.planeDetection = [.horizontal,.vertical]
        config.environmentTexturing = .automatic
        return config
     }
    
    func displayARView() {
        self.showARView = true
    }
    
    func hideARView() {
        self.showARView = false
    }
    
    func setAsset(name: String){
        assetName = name
    }
    
    func setSelectedAssetName(name: String?){
        selectedAssetName = name ?? ""
    }
}
