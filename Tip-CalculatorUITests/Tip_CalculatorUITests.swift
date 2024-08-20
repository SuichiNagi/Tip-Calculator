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
    
    func testRegularTip() {
        //User enter ₱100 bill
        screen.enterBill(amount: 100)
        XCTAssertEqual(screen.totalAmountPerPersonValueLabel.label, "₱100")
        XCTAssertEqual(screen.totalBillValueLabel.label, "₱100")
        XCTAssertEqual(screen.totalTipValueLabel.label, "₱0")
        
        //User selects 10%
        screen.selectTip(tip: .tenPercent)
        XCTAssertEqual(screen.totalAmountPerPersonValueLabel.label, "₱110")
        XCTAssertEqual(screen.totalBillValueLabel.label, "₱110")
        XCTAssertEqual(screen.totalTipValueLabel.label, "₱10")
        
        //User selects 15%
        screen.selectTip(tip: .fifteenPercent)
        XCTAssertEqual(screen.totalAmountPerPersonValueLabel.label, "₱115")
        XCTAssertEqual(screen.totalBillValueLabel.label, "₱115")
        XCTAssertEqual(screen.totalTipValueLabel.label, "₱15")
        
        //User selects 20%
        screen.selectTip(tip: .twentyPercent)
        XCTAssertEqual(screen.totalAmountPerPersonValueLabel.label, "₱120")
        XCTAssertEqual(screen.totalBillValueLabel.label, "₱120")
        XCTAssertEqual(screen.totalTipValueLabel.label, "₱20")
        
        //User splits the bill by 4
        screen.selectIncrementButton(numberOfTaps: 3)
        XCTAssertEqual(screen.totalAmountPerPersonValueLabel.label, "₱30")
        XCTAssertEqual(screen.totalBillValueLabel.label, "₱120")
        XCTAssertEqual(screen.totalTipValueLabel.label, "₱20")
        
        //User splits the bill by 2
        screen.selectDecrementButton(numberOfTaps: 2)
        XCTAssertEqual(screen.totalAmountPerPersonValueLabel.label, "₱60")
        XCTAssertEqual(screen.totalBillValueLabel.label, "₱120")
        XCTAssertEqual(screen.totalTipValueLabel.label, "₱20")
    }

}
