//
//  Tip_CalculatorUITests.swift
//  Tip-CalculatorUITests
//
//  Created by Aldrei Glenn Nuqui on 8/13/24.
//

import XCTest

final class Tip_CalculatorUITests: XCTestCase {

    private var app: XCUIApplication!
    
    private var screen: CalculatorScreen {
        CalculatorScreen(app: app)
    }
    
    override func setUp() {
        super.setUp()
        app = .init()
        app.launch()
    }
    
    override func tearDown() {
        super.tearDown()
        app = nil
    }
    
    func testResultViewDefaultValues() {
        XCTAssertEqual(screen.totalAmountPerPersonValueLabel.label, "₱0")
                XCTAssertEqual(screen.totalBillValueLabel.label, "₱0")
        XCTAssertEqual(screen.totalTipValueLabel.label, "₱0")
    }

}
