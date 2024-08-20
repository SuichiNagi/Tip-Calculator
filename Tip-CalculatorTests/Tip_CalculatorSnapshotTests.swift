//
//  Tip_CalculatorSnapshotTests.swift
//  Tip-CalculatorTests
//
//  Created by Aldrei Glenn Nuqui on 8/20/24.
//

import XCTest
import SnapshotTesting
@testable import Tip_Calculator

final class Tip_CalculatorSnapshotTests: XCTestCase {
    
    private var screenWidth: CGFloat {
        return UIScreen.main.bounds.size.width
    }
    
    func testLogoView() {
        //given
        let size = CGSize(width: screenWidth, height: 48)
        //when
        let view = LogoView()
        //then
        assertSnapshot(of: view, as: .image(size: size))
//        assertSnapshot(of: view, as: .image(size: size), record: true) - add record: true to record or take snapshot
    }
    
    func testInitialResultView() {
        //given
        let size = CGSize(width: screenWidth, height: 224)
        //when
        let view = ResultView()
        //then
        assertSnapshot(of: view, as: .image(size: size))
    }
    
    func testInitialTipInputView() {
        //given
        let size = CGSize(width: screenWidth, height: 56+56+16)
        //when
        let view = TipInputView()
        //then
        assertSnapshot(of: view, as: .image(size: size))
    }
    
    func testInitialSplitInputView() {
        //given
        let size = CGSize(width: screenWidth, height: 56)
        //when
        let view = SplitInputView()
        //then
        assertSnapshot(of: view, as: .image(size: size))
    }
    
    func testBillInputView() {
        //given
        let size = CGSize(width: screenWidth, height: 56)
        //when
        let view = BillInputView()
        //then
        assertSnapshot(of: view, as: .image(size: size))
    }
}
