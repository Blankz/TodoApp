//
//  UIViewController+Alert.swift
//  Todo App
//
//  Created by Blankz on 30/1/2564 BE.
//

import UIKit

extension UIViewController {
    func displayAlert(message: String) {
        let alertView = UIAlertController(title: message,
                                          message: nil,
                                          preferredStyle: .alert)
        alertView.addAction(UIAlertAction(title: "OK",
                                          style: .default))
        self.present(alertView, animated: true)
    }
}
