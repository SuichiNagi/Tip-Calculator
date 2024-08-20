//
//  TipInputView.swift
//  Tip-Calculator
//
//  Created by Aldrei Glenn Nuqui on 8/13/24.
//

import UIKit
import Combine
import CombineCocoa

class TipInputView: UIView {
    
    private var cancellable = Set<AnyCancellable>()
    
    private let tipSubject = CurrentValueSubject<Tip, Never>(.none)
    var valuePublisher: AnyPublisher<Tip, Never> {
        return tipSubject.eraseToAnyPublisher()
    }
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        setUI()
        observe()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func reset() {
        tipSubject.send(.none)
    }
    
    private func observe() {
        tipSubject.sink { [unowned self] tip in
            resetView()
            switch tip {
            case .none:
                break
            case .tenPercent:
                tenPercentTipButton.backgroundColor = ThemeColor.secondary
            case .fifteenPercent:
                fifteenPercentTipButton.backgroundColor = ThemeColor.secondary
            case .twentyPercent:
                twentyPercentTipButton.backgroundColor = ThemeColor.secondary
            case .custom(let value):
                print(value)
                customTipButton.backgroundColor = ThemeColor.secondary
                let text = NSMutableAttributedString(
                    string: "₱\(value)",
                    attributes: [.font: ThemeFont.bold(ofSize: 20)])
                text.addAttributes([.font: ThemeFont.bold(ofSize: 14)], range: NSMakeRange(0, 1))
                customTipButton.setAttributedTitle(text, for: .normal)
            }
        }.store(in: &cancellable)
    }
    
    private func resetView() {
        [tenPercentTipButton, 
         fifteenPercentTipButton,
         twentyPercentTipButton,
         customTipButton].forEach {
            $0.backgroundColor = ThemeColor.primary
        }
        let text = NSMutableAttributedString(
            string: "Custom Tip",
            attributes: [.font: ThemeFont.bold(ofSize: 20)])
        customTipButton.setAttributedTitle(text, for: .normal)
    }
    
    private func handleCustomTipButton() {
        parentViewController?.present(alertController, animated: true)
    }
    
    private func setUI() {
        [headerView, buttonStackView].forEach(addSubview(_:))
        
        buttonStackView.snp.makeConstraints { make in
            make.top.bottom.trailing.equalToSuperview()
        }
        
        headerView.snp.makeConstraints { make in
            make.leading.equalToSuperview()
            make.trailing.equalTo(buttonStackView.snp.leading).offset(-24)
            make.width.equalTo(68)
            make.centerY.equalTo(buttonHStackView.snp.centerY)
        }
    }
    
    private lazy var alertController: UIAlertController = {
        let controller = UIAlertController(
            title: "Enter Custom Tip",
            message: nil,
            preferredStyle: .alert)
        controller.addTextField { textfield in
            textfield.placeholder = "Make it generous!"
            textfield.keyboardType = .numberPad
            textfield.autocorrectionType = .no
            textfield.accessibilityIdentifier = ScreenIdentifier.TipInputView.customTipAlertTextField.rawValue
        }
        let cancelAction = UIAlertAction(
            title: "Cancel",
            style: .default)
        let okAction = UIAlertAction(
            title: "Ok",
            style: .default) { [weak self] _ in
                guard let text = controller.textFields?.first?.text,
                      let value = Int(text) else { return }
                self?.tipSubject.send(.custom(value: value))
            }
        [cancelAction, okAction].forEach(controller.addAction(_:))
        return controller
    }()
    
    private lazy var headerView: UIView = {
        let view = HeaderView()
        view.configure(topText: "Choose", bottomText: "your tip")
        return view
    }()
    
    private func buildTipButton(tip: Tip) -> UIButton {
        let button = UIButton(type: .custom)
        button.backgroundColor = ThemeColor.primary
        button.addCornerRadius(radius: 8.0)
        let text = NSMutableAttributedString(
            string: tip.stringValue,
            attributes: [
                .font: ThemeFont.bold(ofSize: 20),
                .foregroundColor: UIColor.white
            ])
        text.addAttributes([.font: ThemeFont.demibold(ofSize: 14)], range: NSMakeRange(2, 1))
        button.setAttributedTitle(text, for: .normal)
        return button
    }
    
    private lazy var tenPercentTipButton: UIButton = {
        let button = buildTipButton(tip: .tenPercent)
        button.accessibilityIdentifier = ScreenIdentifier.TipInputView.tenPercentButton.rawValue
        button.tapPublisher.flatMap({
            Just(Tip.tenPercent)
        }).assign(to: \.value, on: tipSubject)
            .store(in: &cancellable)
       
        return button
    }()
    
    private lazy var fifteenPercentTipButton: UIButton = {
        let button = buildTipButton(tip: .fifteenPercent)
        button.accessibilityIdentifier = ScreenIdentifier.TipInputView.fifteenPercentButton.rawValue
        button.tapPublisher.flatMap({
            Just(Tip.fifteenPercent)
        }).assign(to: \.value, on: tipSubject)
            .store(in: &cancellable)
        return button
    }()
    
    private lazy var twentyPercentTipButton: UIButton = {
        let button = buildTipButton(tip: .twentyPercent)
        button.accessibilityIdentifier = ScreenIdentifier.TipInputView.twentyPercentButton.rawValue
        button.tapPublisher.flatMap({
            Just(Tip.twentyPercent)
        }).assign(to: \.value, on: tipSubject)
            .store(in: &cancellable)
        return button
    }()
    
    private lazy var customTipButton: UIButton = {
        let button = UIButton()
        button.setTitle("Custom Tip", for: .normal)
        button.titleLabel?.font = ThemeFont.bold(ofSize: 20)
        button.backgroundColor = ThemeColor.primary
        button.tintColor = .white
        button.addCornerRadius(radius: 8.0)
        button.accessibilityIdentifier = ScreenIdentifier.TipInputView.customTipButton.rawValue
        button.tapPublisher.sink { [weak self] _ in
            self?.handleCustomTipButton()
        }.store(in: &cancellable)
        return button
    }()
    
    private lazy var buttonHStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [
            tenPercentTipButton,
            fifteenPercentTipButton,
            twentyPercentTipButton])
        stackView.distribution = .fillEqually
        stackView.spacing = 16
        stackView.axis = .horizontal
        return stackView
    }()
    
    private lazy var buttonStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [
            buttonHStackView,
            customTipButton
        ])
        stackView.axis = .vertical
        stackView.spacing = 16
        stackView.distribution = .fillEqually
        return stackView
    }()
}
