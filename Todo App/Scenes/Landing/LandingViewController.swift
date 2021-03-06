//
//  LandingViewController.swift
//  Todo App
//
//  Created Blankz on 28/1/2564 BE.
//  Copyright © 2564 BE ___ORGANIZATIONNAME___. All rights reserved.
//
//  Template generated by Blankz
//

import UIKit

class LandingViewController: UIViewController, LandingViewProtocol {
	var presenter: LandingPresenterProtocol?
    private var scrollView: ScrollView!
    private var segmentView: UISegmentedControl!
    private var svVertical: UIStackView!
    private var inputName: InputTextfieldView!
    private var inputAge: InputTextfieldView!
    private var inputEmail: InputTextfieldView!
    private var inputPassword: InputTextfieldView!
    private var btnAccept: UIButton!
    
	override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
    }
}

//MARK: - Setup View
private extension LandingViewController {
    func setupView() {
        setupBackground()
        setupScrollView()
        setupInputView()
        setupLanguage()
    }
    
    func setupBackground() {
        view.backgroundColor = .white
    }
    
    func setupScrollView() {
        scrollView = ScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(scrollView)
        
        scrollView.updateConstraints()
    }
    
    func setupInputView() {
        let segmentItem = ["Login", "Register"]
        
        segmentView = UISegmentedControl(items: segmentItem)
        segmentView.selectedSegmentIndex = 0
        segmentView.addTarget(self,
                              action: #selector(didChangeSegment(segment:)),
                              for: .valueChanged)
        
        inputName = InputTextfieldView()
        inputName.isHidden = true
        
        inputAge = InputTextfieldView()
        inputAge.isHidden = true
        inputAge.isNumpad = true
        
        inputEmail = InputTextfieldView()
        
        inputPassword = InputTextfieldView()
        inputPassword.isSecureTextEntry = true
        
        btnAccept = UIButton()
        btnAccept.backgroundColor = .systemBlue
        btnAccept.layer.cornerRadius = 4
        btnAccept.addTarget(self,
                            action: #selector(didTapAccept),
                            for: .touchUpInside)
        
        svVertical = UIStackView(arrangedSubviews: [segmentView,
                                                    inputName,
                                                    inputAge,
                                                    inputEmail,
                                                    inputPassword,
                                                    btnAccept])
        svVertical.translatesAutoresizingMaskIntoConstraints = false
        svVertical.axis = .vertical
        svVertical.distribution = .fill
        svVertical.alignment = .fill
        scrollView.addSubview(svVertical)
        
        setLoginConstraints()
    }
    
    func setLoginConstraints() {
        svVertical.setCustomSpacing(24, after: segmentView)
        svVertical.setCustomSpacing(24, after: inputPassword)
        
        let dic: [String: AnyObject] = ["svVertical": svVertical]
        var constraints = NSLayoutConstraint.constraints(withVisualFormat: "V:|-150-[svVertical]", options: [], metrics: nil, views: dic)
        constraints += NSLayoutConstraint.constraints(withVisualFormat: "H:|-32-[svVertical]-32-|", options: [], metrics: nil, views: dic)
        NSLayoutConstraint.activate(constraints)
    }
    
    func setupLanguage() {
        inputName.set(title: "Name")
        inputAge.set(title: "Age")
        inputEmail.set(title: "Email")
        inputPassword.set(title: "Password")
        btnAccept.setTitle("Login", for: .normal)
    }
}

// update
extension LandingViewController {
    func displayError(from error: [LandingItem.View]) {
        error.forEach { error in
            switch error {
            case .name:
                inputName.setError()
            case .age:
                inputAge.setError()
            case .email:
                inputEmail.setError()
            case .password:
                inputPassword.setError()
            }
        }
        
        switch error.first {
        case .name:
            _ = inputName.becomeFirstResponder()
        case .age:
            _ = inputAge.becomeFirstResponder()
        case .email:
            _ = inputEmail.becomeFirstResponder()
        case .password:
            _ = inputPassword.becomeFirstResponder()
        case .none:
            break
        }

    }
}

//MARK:- action
private extension LandingViewController {
    @objc func didChangeSegment(segment: UISegmentedControl) {
        if segment.selectedSegmentIndex == 0 {
            inputName.isHidden = true
            inputAge.isHidden = true
        } else {
            inputName.isHidden = false
            inputAge.isHidden = false
        }
        
        inputName.setTextColorDefault()
        inputAge.setTextColorDefault()
        inputEmail.setTextColorDefault()
        inputPassword.setTextColorDefault()
        
        inputName.setEmpty()
        inputAge.setEmpty()
        inputEmail.setEmpty()
        inputPassword.setEmpty()
    }
    
    @objc func didTapAccept() {
        view.endEditing(true)
        
        let form = LandingItem.Request(isLogin: segmentView.selectedSegmentIndex == 0,
                                       name: inputName.text,
                                       age: inputAge.text,
                                       email: inputEmail.text,
                                       password: inputPassword.text)
    
        presenter?.validate(form: form)
    }
}
