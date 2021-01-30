//
//  View.swift
//  Todo App
//
//  Created by Blankz on 28/1/2564 BE.
//

import UIKit

class View: UIView {
    init() {
        super.init(frame: .zero)
        
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
