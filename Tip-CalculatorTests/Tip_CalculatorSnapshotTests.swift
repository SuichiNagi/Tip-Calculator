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
    
    //ResultView
    func testInitialResultView() {
        //given
        let size = CGSize(width: screenWidth, height: 224)
        //when
        let view = ResultView()
        //then
        assertSnapshot(of: view, as: .image(size: size))
    }
    
    func testResultViewWithValues() {
        //given
        let size = CGSize(width: screenWidth, height: 224)
        let result = Result(
            amountPerPerson: 100.25,
            totalBill: 45,
            totalTip: 60)
        //when
        let view = ResultView()
        view.configure(result: result)
        //then
        assertSnapshot(of: view, as: .image(size: size))
    }
    
    //TipInputView
    func testInitialTipInputView() {
        //given
        let size = CGSize(width: screenWidth, height: 56+56+16)
        //when
        let view = TipInputView()
        //then
        assertSnapshot(of: view, as: .image(size: size))
    }
    
    func testTipInputViewWithSelection() {
        //given
        let size = CGSize(width: screenWidth, height: 56+56+16)
        //when
        let view = TipInputView()
        let button = view.allSubviewsOf(type: UIButton.self).first
        button?.sendActions(for: .touchUpInside)
        //then
        assertSnapshot(of: view, as: .image(size: size))
    }
    
    //SplitInputView
    func testInitialSplitInputView() {
        //given
        let size = CGSize(width: screenWidth, height: 56)
        //when
        let view = SplitInputView()
        //then
        assertSnapshot(of: view, as: .image(size: size))
    }
    
    func testSplitInputViewWithSelection() {
        //given
        let size = CGSize(width: screenWidth, height: 56)
        //when
        let view = SplitInputView()
        let button = view.allSubviewsOf(type: UIButton.self).last
        button?.sendActions(for: .touchUpInside)
        //then
        assertSnapshot(of: view, as: .image(size: size))
    }
    
    //BillInputView
    func testInitialBillInputView() {
        //given
        let size = CGSize(width: screenWidth, height: 56)
        //when
        let view = BillInputView()
        //then
        assertSnapshot(of: view, as: .image(size: size))
    }
    
    func testBillInputViewWithValue() {
        //given
        let size = CGSize(width: screenWidth, height: 56)
        //when
        let view = BillInputView()
        let textField = view.allSubviewsOf(type: UITextField.self).first
        textField?.text = "500"
        //then
        assertSnapshot(of: view, as: .image(size: size))
    }
}

extension UIView {
    func allSubviewsOf<T: UIView>(type: T.Type) -> [T] {
        var all = [T]()
        
        func getSubviews(view: UIView) {
            if let aView = view as? T {
                all.append(aView)
            }
            guard view.subviews.count > 0 else { return }
            view.subviews.forEach{ getSubviews(view: $0) }
        }
        getSubviews(view: self)
        return all
    }
}
