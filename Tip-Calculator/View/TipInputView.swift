//
//  TipInputView.swift
//  Tip-Calculator
//
//  Created by Aldrei Glenn Nuqui on 8/13/24.
//

import UIKit

class TipInputView: UIView {

    override init(frame: CGRect) {
        super.init(frame: .zero)
        setUI()
    }
    
    private func setUI() {
        backgroundColor = .blue
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
