//
//  AmountView.swift
//  Tip-Calculator
//
//  Created by Aldrei Glenn Nuqui on 8/14/24.
//

import UIKit

class AmountView: UIView {
    
    private let title: String
    
    init(title: String) {
        self.title = title
        super.init(frame: .zero)
        setUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(amount: Double) {
        let text = NSMutableAttributedString(
            string: amount.currencyFormatted,
            attributes: [.font: ThemeFont.bold(ofSize: 24)])
        text.addAttributes([.font: ThemeFont.bold(ofSize: 16)], range: NSMakeRange(0, 1))
        amountLabel.attributedText = text
    }
    
    private func setUI() {
        addSubview(stackView)
        stackView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    private lazy var titleLabel: UILabel = {
        LabelFactory.build(
            text: title,
            font: ThemeFont.regular(ofSize: 18),
            textColor: ThemeColor.text,
            textAlignment: .left)
    }()
    
    private lazy var amountLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.textColor = ThemeColor.primary
        let text = NSMutableAttributedString(string: "₱0", attributes: [.font: ThemeFont.bold(ofSize: 24)])
        text.addAttributes([.font: ThemeFont.bold(ofSize: 16)], range: NSMakeRange(0, 1))
        label.attributedText = text
        return label
    }()
    
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [titleLabel, amountLabel])
        stackView.axis = .vertical
        return stackView
    }()
}
