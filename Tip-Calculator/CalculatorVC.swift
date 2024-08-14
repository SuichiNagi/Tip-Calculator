//
//  ViewController.swift
//  Tip-Calculator
//
//  Created by Aldrei Glenn Nuqui on 8/13/24.
//

import UIKit
import SnapKit

class CalculatorVC: UIViewController {
    
    private var arrayView: [UIView] = []

    override func viewDidLoad() {
        super.viewDidLoad()

        setUI()
    }
    
    private func setUI() {
        view.backgroundColor = ThemeColor.bg
        
        arrayView = [logoView, resultView, billInputView, tipInputView, splitInputView]
        
        view.addSubview(vStackView)
        vStackView.snp.makeConstraints { make in
            make.leading.equalTo(view.snp.leadingMargin).offset(16)
            make.trailing.equalTo(view.snp.trailingMargin).offset(-16)
            make.bottom.equalTo(view.snp.bottomMargin).offset(-85)
            make.top.equalTo(view.snp.topMargin).offset(16)
        }
        
        logoView.snp.makeConstraints { make in
            make.height.equalTo(48)
        }
        
        resultView.snp.makeConstraints { make in
            make.height.equalTo(224)
        }
        
        billInputView.snp.makeConstraints { make in
            make.height.equalTo(56)
        }
        
        tipInputView.snp.makeConstraints { make in
            make.height.equalTo(56+56+16)
        }
        
        splitInputView.snp.makeConstraints { make in
            make.height.equalTo(56)
        }
    }
    
    private lazy var vStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: arrayView)
        stackView.axis = .vertical
        stackView.spacing = 36
        return stackView
    }()

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

#Preview() {
    CalculatorVC()
}

