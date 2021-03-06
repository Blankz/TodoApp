//
//  String.swift
//  Todo App
//
//  Created by Blankz on 30/1/2564 BE.
//

import Foundation

extension String {
    var isValidEmail: Bool {
        let regularExpressionForEmail = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let testEmail = NSPredicate(format:"SELF MATCHES %@",
                                    regularExpressionForEmail)
        return testEmail.evaluate(with: self)
    }
}
