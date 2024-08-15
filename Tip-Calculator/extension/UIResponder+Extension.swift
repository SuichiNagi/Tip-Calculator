//
//  UIResponder+Extension.swift
//  Tip-Calculator
//
//  Created by Aldrei Glenn Nuqui on 8/15/24.
//

import UIKit

extension UIResponder {
    var parentViewController: UIViewController? {
        return next as? UIViewController ?? next?.parentViewController
    }
}
