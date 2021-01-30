//
//  Loading.swift
//  Todo App
//
//  Created by Blankz on 30/1/2564 BE.
//

import UIKit

class Loading {
    static var shared = Loading()
    private var view: View?
    private var viewGroup: View?
    private var activity: NVActivityIndicatorView?
    
    private init() {}
    func show() {
        let window: UIWindow = UIApplication.shared.keyWindow!
        
        view = View()
        window.addSubview(view!)
        window.bringSubviewToFront(view!)
        
        viewGroup = View()
        viewGroup?.layer.cornerRadius = 5
        viewGroup?.backgroundColor = UIColor.black.withAlphaComponent(0.4)
        view?.addSubview(viewGroup!)
        
        activity = NVActivityIndicatorView(color: .white, padding: 20)
        activity?.translatesAutoresizingMaskIntoConstraints = false
        activity?.startAnimating()
        view?.addSubview(activity!)
        
        let dic: [String: Any] = ["view": view!]
        var constraints = NSLayoutConstraint.constraints(withVisualFormat: "V:|[view]|", options: [], metrics: nil, views: dic)
        constraints += NSLayoutConstraint.constraints(withVisualFormat: "H:|[view]|", options: [], metrics: nil, views: dic)
        viewGroup?.widthAnchor.constraint(equalTo: viewGroup!.heightAnchor).isActive = true
        viewGroup?.widthAnchor.constraint(equalToConstant: 70).isActive = true
        viewGroup?.centerXAnchor.constraint(equalTo: view!.centerXAnchor).isActive = true
        viewGroup?.centerYAnchor.constraint(equalTo: view!.centerYAnchor).isActive = true
        activity?.centerXAnchor.constraint(equalTo: view!.centerXAnchor).isActive = true
        activity?.centerYAnchor.constraint(equalTo: view!.centerYAnchor).isActive = true
        NSLayoutConstraint.activate(constraints)
    }
    
    func hide() {
        DispatchQueue.main.async {
            self.activity?.stopAnimating()
            self.view?.removeFromSuperview()
            self.view = nil
            self.viewGroup = nil
            self.activity = nil
        }
    }
}
