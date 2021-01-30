//
//  LandingPresenter.swift
//  Todo App
//
//  Created Blankz on 28/1/2564 BE.
//  Copyright © 2564 BE ___ORGANIZATIONNAME___. All rights reserved.
//
//  Template generated by Blankz
//

import UIKit

class LandingPresenter: LandingPresenterProtocol, LandingInteractorOutputProtocol {

    weak private var view: LandingViewProtocol?
    var interactor: LandingInteractorInputProtocol?
    private let router: LandingWireframeProtocol

    init(interface: LandingViewProtocol,
         interactor: LandingInteractorInputProtocol?,
         router: LandingWireframeProtocol
    ) {
        self.view = interface
        self.interactor = interactor
        self.router = router
    }
    
    func validate(form: LandingItem.Request) {
        var error: [LandingItem.View] = []
        if !form.isLogin,
           form.name.isEmpty {
            error.append(.name)
        }
        if !form.isLogin,
           (Int(form.age) ?? 0 < 5
            || Int(form.age) ?? 0 > 80) {
            error.append(.age)
        }
        if !form.email.isValidEmail {
            error.append(.email)
        }
        if form.password.count < 7
            || form.password.count > 20 {
            error.append(.password)
        }
        
        if error.isEmpty {
            if form.isLogin {
                interactor?.performLogin(form: form)
            } else {
                interactor?.performRegister(form: form)
            }
        } else {
            view?.displayError(from: error)
        }
    }
    
    func didReceive(responseSuccess: LandingItem.Reponse) {
        KeychainAccess.shared.set(token: responseSuccess.token)
        router.presentTodoList()
    }
    
    func didReceive(errorMessage: String) {
        view?.displayAlert(message: errorMessage)
    }
}
