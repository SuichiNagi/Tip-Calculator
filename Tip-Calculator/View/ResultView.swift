//
//  ResultView.swift
//  Tip-Calculator
//
//  Created by Aldrei Glenn Nuqui on 8/13/24.
//

import UIKit

class ResultView: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        setUI()
    }
    
    private func setUI() {
        backgroundColor = .white
        addShadow(offset: CGSize(width: 0, height: 3), color: .black, radius: 12.0, opacity: 0.1)
        
        addSubview(vStackView)
        vStackView.snp.makeConstraints { make in
            make.top.leading.equalTo(self).offset(24)
            make.trailing.bottom.equalTo(self).offset(-24)
        }
        
        horizontalLineView.snp.makeConstraints { make in
            make.height.equalTo(2)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func buildSpacerView(height: CGFloat) -> UIView {
        let view = UIView()
        view.heightAnchor.constraint(equalToConstant: height).isActive = true
        return view
    }
    
    private lazy var headerLabel: UILabel = {
        LabelFactory.build(text: "Total p/person", font: ThemeFont.demibold(ofSize: 18))
    }()
    
    private lazy var amountPerPersonLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        let text = NSMutableAttributedString(
            string: "$0",
            attributes: [.font: ThemeFont.bold(ofSize: 48)])
        text.addAttributes([
            .font: ThemeFont.bold(ofSize: 24)
        ], range: NSMakeRange(0, 1))
        label.attributedText = text
        return label
    }()
    
    private lazy var horizontalLineView: UIView = {
        let lineView = UIView()
        lineView.backgroundColor = ThemeColor.separator
        return lineView
    }()
    
    private lazy var vStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [
            headerLabel,
            amountPerPersonLabel,
            horizontalLineView,
            buildSpacerView(height: 0),
            hStackView
        ])
        stackView.axis = .vertical
        stackView.spacing = 8
        return stackView
    }()
    
    private lazy var hStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [
            AmountView(title: "Total bill"),
            UIView(),
            AmountView(title: "Total tip")
        ])
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        return stackView
    }()
}
