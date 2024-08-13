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
    }
    
    private func setUI() {
        backgroundColor = .systemPink
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
