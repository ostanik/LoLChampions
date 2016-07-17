//
//  LoLChampionsUITests.swift
//  LoLChampionsUITests
//
//  Created by Alan Ostanik on 1/9/16.
//  Copyright © 2016 Ostanik. All rights reserved.
//

import XCTest
@testable import LoLChampions

class LoLChampionsUITests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false
        //        // UI tests must launch the application that they test. Doing this in setup will make sure it happens for each test method.
        XCUIApplication().launch()

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testExample() {
        // Use recording to get started writing UI tests.
        // Use XCTAssert and related functions to verify your tests produce the correct results.

        let app = XCUIApplication()
        let arrItens = ["Ahri", "Alistar"]

//        snapshot("Lista")
        //Go for the four first itens.
        for item in arrItens {
            selectItemAndGoBack(item, app: app)
        }
        //Test if all cell has beem created.
        //scrollToLastCell(app)
    }
    
    /**
     Select an iten, scrolls to show his information.

     - parameter itemTitle: String with the item name
     - parameter app:       XCUIApplication that is runing.
     */
    func selectItemAndGoBack(itemTitle:String, app: XCUIApplication){
        app.tables.staticTexts[itemTitle].tap()
        NSThread.sleepForTimeInterval(1)
//        snapshot("i\(itemTitle)")
        scrollToLastCell(app)
//        snapshot("i\(itemTitle)1")
        app.navigationBars[itemTitle].buttons["Lista de Campeões"].tap()
    }
    
    /**
     Scroll to the last item of the table.
     
     - parameter app: XCUIApplication that is runing
     */
    func scrollToLastCell(app: XCUIApplication) {
        let app = XCUIApplication()
        let table = app.tables.elementBoundByIndex(0)
        let lastCell = table.cells.elementBoundByIndex(table.cells.count-1)
        table.scrollToElement(lastCell)
    }
}

extension XCUIElement {
    func scrollToElement(element: XCUIElement) {
        while !element.visible() {
            swipeUp()
        }
    }
    
    func visible() -> Bool {
        guard self.exists && !CGRectIsEmpty(self.frame) else { return false }
        return CGRectContainsRect(XCUIApplication().windows.elementBoundByIndex(0).frame, self.frame)
    }
    
}
