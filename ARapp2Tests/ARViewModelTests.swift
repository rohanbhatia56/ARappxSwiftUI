//
//  ARapp2Tests.swift
//  ARapp2Tests
//
//  Created by Rohan Bhatia on 09/07/24.
//

import XCTest
@testable import ARapp2

class ARViewModelTests: XCTestCase {
    
    var viewModel: ARViewModel!
    
    override func setUpWithError() throws {
        try super.setUpWithError()
        viewModel = ARViewModel()
    }
    
    override func tearDownWithError() throws {
        viewModel = nil
        try super.tearDownWithError()
    }
    
    func testSetupARConfigurations() {
        let config = viewModel.setupARConfigurations()
        
        XCTAssertEqual(config.planeDetection, [.horizontal, .vertical])
        XCTAssertEqual(config.environmentTexturing, .automatic)
    }
    
    func testDisplayARView() {
        viewModel.displayARView()
        
        XCTAssertTrue(viewModel.showARView)
    }
    
    func testHideARView() {
        viewModel.hideARView()
        
        XCTAssertFalse(viewModel.showARView)
    }
    
    func testSetAsset() {
        let assetName = "ExampleAsset"
        viewModel.setAsset(name: assetName)
        
        XCTAssertEqual(viewModel.assetName, assetName)
    }
    
    func testSetSelectedAssetName() {
        let assetName = "SelectedAssetName"
        viewModel.setSelectedAssetName(name: assetName)
        
        XCTAssertEqual(viewModel.selectedAssetName, assetName)
    }
}
