//
//  ScrollView.swift
//  Todo App
//
//  Created by Blankz on 29/1/2564 BE.
//

import UIKit

class ScrollView: UIScrollView {
    private var mainView: View!
    init() {
        super.init(frame: .zero)
        
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

//MARK: - SetupView
 extension ScrollView {
    func setupView() {
        translatesAutoresizingMaskIntoConstraints = false
        
        mainView = View()
        super.addSubview(mainView)
        
        let dic: [String: AnyObject] = ["mainView": mainView]
        var constraints = NSLayoutConstraint.constraints(withVisualFormat: "V:|[mainView]|", options: [], metrics: nil, views: dic)
        constraints += NSLayoutConstraint.constraints(withVisualFormat: "H:|[mainView]|", options: [], metrics: nil, views: dic)
        NSLayoutConstraint.activate(constraints)

        mainView.widthAnchor.constraint(equalTo: widthAnchor).isActive = true
        mainView.heightAnchor.constraint(equalTo: heightAnchor).isActive = true
    }
}

//MARK: - add
extension ScrollView {
    override func addSubview(_ view: UIView) {
        mainView.addSubview(view)
    }
}
