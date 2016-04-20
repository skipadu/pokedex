//
//  pokedex_by_skipaduUITests.swift
//  pokedex-by-skipaduUITests
//
//  Created by Sami Korpela on 20.4.2016.
//  Copyright © 2016 skipadu. All rights reserved.
//

import XCTest

class pokedex_by_skipaduUITests: XCTestCase {
  
  override func setUp() {
    super.setUp()
    
    // Put setup code here. This method is called before the invocation of each test method in the class.
    
    // In UI tests it is usually best to stop immediately when a failure occurs.
    continueAfterFailure = false
    // UI tests must launch the application that they test. Doing this in setup will make sure it happens for each test method.
    //        XCUIApplication().launch()
    
    let app = XCUIApplication()
    setupSnapshot(app)
    app.launch()
  }
  
  override func tearDown() {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    super.tearDown()
  }
  
  func testExample() {
    // Use recording to get started writing UI tests.
    // Use XCTAssert and related functions to verify your tests produce the correct results.
    
    let app = XCUIApplication()
    snapshot("01-MainView")
    app.collectionViews.images["1"].tap()
    snapshot("02-DetailsView")
    app.buttons["arrow"].tap()
  }
  
}
