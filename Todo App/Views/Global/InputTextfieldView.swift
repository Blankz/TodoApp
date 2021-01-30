//
//  InputTextfieldView.swift
//  Todo App
//
//  Created by Blankz on 29/1/2564 BE.
//

import UIKit

class InputTextfieldView: UIView {
    private var svVertical: UIStackView!
    private var lblTitle: UILabel!
    private var tf: PaddingTextField!
    private var line: UIView!
    
    var isNumpad: Bool = false {
        didSet {
            tf.keyboardType = .numberPad
        }
    }
    
    var isSecureTextEntry: Bool = false {
        didSet {
            tf.isSecureTextEntry = isSecureTextEntry
        }
    }
    
    var text: String {
        get {
            return tf.text ?? ""
        }
        set {
            tf.text = newValue
        }
    }
    
    var isEditing: Bool = true {
        didSet {
            if isEditing {
                tf.isUserInteractionEnabled = true
                tf.backgroundColor = UIColor.lightGray.withAlphaComponent(0.3)
            } else {
                tf.backgroundColor = .white
                tf.isUserInteractionEnabled = false
            }
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

//MARK: - setup view
private extension InputTextfieldView {
    func setupView() {
        lblTitle = UILabel()
        lblTitle.textColor = .black
        
        tf = PaddingTextField()
        tf.backgroundColor = UIColor.lightGray.withAlphaComponent(0.3)
        tf.addTarget(self,
                     action: #selector(didChangeValue(_:)),
                     for: .editingChanged)
        tf.layer.cornerRadius = 4
                
        line = View()
        line.backgroundColor = .gray
        line.heightAnchor.constraint(equalToConstant: 1).isActive = true
        
        svVertical = UIStackView(arrangedSubviews: [View(),
                                                    lblTitle,
                                                    tf,
                                                    line])
        svVertical.translatesAutoresizingMaskIntoConstraints = false
        svVertical.spacing = 8
        svVertical.axis = .vertical
        svVertical.distribution = .fillProportionally
        addSubview(svVertical)
        
        svVertical.updateConstraints()
    }
}

//MARK: - Action
private extension InputTextfieldView {
    @objc func didChangeValue(_ textfield: UITextField) {
        setTextColorDefault()
    }
}

//MARK: - Configure
extension InputTextfieldView {
    func set(title: String) {
        lblTitle.text = title
    }
    
    func setError() {
        line.backgroundColor = .systemRed
        lblTitle.textColor = .systemRed
    }
    
    func setTextColorDefault() {
        lblTitle.textColor = .black
        line.backgroundColor = .gray
    }
    
    func setEmpty() {
        tf.text = nil
    }
    
    override func becomeFirstResponder() -> Bool {
        tf.becomeFirstResponder()
        return true
    }
}
