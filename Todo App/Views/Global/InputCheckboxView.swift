//
//  InputCheckboxView.swift
//  Todo App
//
//  Created by Blankz on 30/1/2564 BE.
//

import UIKit

class InputCheckboxView: UIView {
    private var lblTitle: UILabel!
    private var switchView: UISwitch!
    private var line: UIView!
    
    var isEditing: Bool = false {
        didSet {
            if isEditing {
                switchView.isEnabled = true
            } else {
                switchView.isEnabled = false
            }
        }
    }
    
    var isComplete: Bool {
        get {
            return switchView.isOn
        }
        set {
            switchView.isOn = newValue
        }
    }
    
    init() {
        super.init(frame: .zero)
        
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

//MARK: - Setup
private extension InputCheckboxView {
    func setupView() {
        lblTitle = UILabel()
        lblTitle.textColor = .black
        
        switchView = UISwitch()
        switchView.isEnabled = false
        
        line = View()
        line.backgroundColor = .gray
        line.heightAnchor.constraint(equalToConstant: 1).isActive = true
        
        let svHorizontal = UIStackView(arrangedSubviews: [lblTitle,
                                                          View(),
                                                          switchView])
        svHorizontal.translatesAutoresizingMaskIntoConstraints = false
        svHorizontal.spacing = 8
        svHorizontal.axis = .horizontal
        svHorizontal.distribution = .fill
        svHorizontal.alignment = .center

        let svVertical = UIStackView(arrangedSubviews: [svHorizontal,
                                                        line])
        svVertical.translatesAutoresizingMaskIntoConstraints = false
        svVertical.spacing = 16
        svVertical.axis = .vertical
        svVertical.distribution = .fillProportionally
        addSubview(svVertical)
        
        svVertical.updateConstraints()
    }
}

//MARK: - Configure
extension InputCheckboxView {
    func set(title: String) {
        lblTitle.text = title
    }
}
