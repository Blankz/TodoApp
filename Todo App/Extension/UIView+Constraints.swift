//
//  UIView+Constraints.swift
//  Todo App
//
//  Created by Blankz on 29/1/2564 BE.
//

import UIKit

extension UIView {
    func updateConstraints() {
        guard let superview = superview else { return }
        
        topAnchor.constraint(equalTo: superview.topAnchor).isActive = true
        leadingAnchor.constraint(equalTo: superview.leadingAnchor).isActive = true
        trailingAnchor.constraint(equalTo: superview.trailingAnchor).isActive = true
        bottomAnchor.constraint(equalTo: superview.bottomAnchor).isActive = true
    }
}
