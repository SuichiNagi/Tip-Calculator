//
//  ViewController.swift
//  Tip-Calculator
//
//  Created by Aldrei Glenn Nuqui on 8/13/24.
//

import UIKit

class CalculatorVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        view.backgroundColor = .yellow
    }
    
    func setUI() {
        
    }

    private lazy var logoView: LogoView = {
        let logoView = LogoView()
        return logoView
    }()
    
    private lazy var resultView: ResultView = {
        let resultView = ResultView()
        return resultView
    }()
    
    private lazy var billInputView: BillInputView = {
        let billInputView = BillInputView()
        return billInputView
    }()
    
    private lazy var tipInputView: TipInputView = {
        let tipInputView = TipInputView()
        return tipInputView
    }()
    
    private lazy var splitInputView: SplitInputView = {
        let splitInputView = SplitInputView()
        return splitInputView
    }()
}

