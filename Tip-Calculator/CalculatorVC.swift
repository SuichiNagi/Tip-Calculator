//
//  ViewController.swift
//  Tip-Calculator
//
//  Created by Aldrei Glenn Nuqui on 8/13/24.
//

import UIKit
import SnapKit
import Combine
import CombineCocoa

class CalculatorVC: UIViewController {
    
    private let calculatorVM = CalculatorViewModel()
    private var cancellable = Set<AnyCancellable>()
    
    private var arrayView: [UIView] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUI()
        bind()
    }
    
    private func bind() {
        
        let input = CalculatorViewModel.Input(
            billPublisher: billInputView.valuePublisher,
            tipPublisher: tipInputView.valuePublisher,
            splitPublisher: splitInputView.valuePublisher,
            logoViewTapPublisher: logoViewTapPublisher,
            viewTapPublisher: viewTapPublisher)
        
        let output = calculatorVM.transform(input: input)
        
        output.updateViewPublisher.sink { [unowned self] result in
            resultView.configure(result: result)
        }.store(in: &cancellable)
        
        output.resetCalculatorPublisher.sink { [unowned self] _ in
            billInputView.reset()
            tipInputView.reset()
            splitInputView.reset()
            
            tapLogoAnimation()
        }.store(in: &cancellable)
        
        output.endEditingPublisher.sink { [unowned self] _ in
            view.endEditing(true)
        }.store(in: &cancellable)
    }
    
    private lazy var viewTapPublisher: AnyPublisher<Void, Never> = {
        let tapGesture = UITapGestureRecognizer(target: self, action: nil)
        view.addGestureRecognizer(tapGesture)
        return tapGesture.tapPublisher.flatMap { _ in
            Just(())
        }.eraseToAnyPublisher()
    }()
    
    private lazy var logoViewTapPublisher: AnyPublisher<Void, Never> = {
        let tapGesture = UITapGestureRecognizer(target: self, action: nil)
        tapGesture.numberOfTapsRequired = 2
        logoView.addGestureRecognizer(tapGesture)
        return tapGesture.tapPublisher.flatMap { _ in
            Just(())
        }.eraseToAnyPublisher()
    }()
    
    func tapLogoAnimation() {
        UIView.animate(
            withDuration: 0.1,
            delay: 0,
            usingSpringWithDamping: 5.0,
            initialSpringVelocity: 0.5,
            options: .curveEaseInOut) {
                self.logoView.transform = .init(scaleX: 1.5, y: 1.5)
            } completion: { _ in
                UIView.animate(withDuration: 0.1) {
                    self.logoView.transform = .identity
                }
            }
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

