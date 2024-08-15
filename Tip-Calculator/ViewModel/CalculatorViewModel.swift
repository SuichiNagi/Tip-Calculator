//
//  CalculatorViewModel.swift
//  Tip-Calculator
//
//  Created by Aldrei Glenn Nuqui on 8/14/24.
//

import Foundation
import Combine

class CalculatorViewModel {
    
    var cancellable = Set<AnyCancellable>()
    
    struct Input {
        let billPublisher: AnyPublisher<Double, Never>
        let tipPublisher: AnyPublisher<Tip, Never>
        let splitPublisher: AnyPublisher<Int, Never>
    }
    
    struct Output {
        let updateViewPublisher: AnyPublisher<Result, Never>
    }
    
    func transform(input: Input) -> Output {
        
        input.splitPublisher.sink { split in
            print(split)
        }.store(in: &cancellable)
        
        let result = Result(amountPerPerson: 500, totalBill: 1000, totalTip: 50.0)
        
        return Output(updateViewPublisher: Just(result).eraseToAnyPublisher())
    }
    
}
