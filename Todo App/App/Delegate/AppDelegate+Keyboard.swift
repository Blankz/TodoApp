//
//  AppDelegate+Keyboard.swift
//  Todo App
//
//  Created by Blankz on 30/1/2564 BE.
//

import IQKeyboardManagerSwift

extension AppDelegate {
    func setupKeyboard() {
        IQKeyboardManager.shared.enable = true
        IQKeyboardManager.shared.shouldToolbarUsesTextFieldTintColor = true
        IQKeyboardManager.shared.keyboardDistanceFromTextField = 40
        IQKeyboardManager.shared.shouldResignOnTouchOutside = true

    }
}
