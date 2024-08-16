//
//  Tip_CalculatorTests.swift
//  Tip-CalculatorTests
//
//  Created by Aldrei Glenn Nuqui on 8/13/24.
//

import XCTest
import Combine
@testable import Tip_Calculator

final class Tip_CalculatorTests: XCTestCase {

    //SUT -> System Under Test
    private var sut: CalculatorViewModel!
    private var cancellable: Set<AnyCancellable>!
    
    private let logoViewTapSubject = PassthroughSubject<Void, Never>()
    private let viewTapSubject = PassthroughSubject<Void, Never>()
    
    override func setUp() {
        sut = .init()
        cancellable = .init()
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
        sut = nil
        cancellable = .init()
    }
    
    func testResultWithoutTipFor1Person() {
        //given
        let bill: Double = 100.0
        let tip: Tip = .none
        let split: Int = 1
        let input = buildInput(
            bill: bill,
            tip: tip,
            split: split)
        //when
        let output = sut.transform(input: input)
        //then
        output.updateViewPublisher.sink { result in
            XCTAssertEqual(result.amountPerPerson, 100)
            XCTAssertEqual(result.totalBill, 100)
            XCTAssertEqual(result.totalTip, 0)
        }.store(in: &cancellable)
    }
    
    private func buildInput(bill: Double, tip: Tip, split: Int) -> CalculatorViewModel.Input {
        return .init(
            billPublisher: Just(bill).eraseToAnyPublisher(),
            tipPublisher: Just(tip).eraseToAnyPublisher(),
            splitPublisher: Just(split).eraseToAnyPublisher(),
            logoViewTapPublisher: logoViewTapSubject.eraseToAnyPublisher(),
            viewTapPublisher: viewTapSubject.eraseToAnyPublisher()
        )
    }
}
