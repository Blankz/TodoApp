//
//  LandingProtocols.swift
//  Todo App
//
//  Created Blankz on 28/1/2564 BE.
//  Copyright © 2564 BE ___ORGANIZATIONNAME___. All rights reserved.
//
//  Template generated by Blankz
//

import Foundation

//MARK: Wireframe -
protocol LandingWireframeProtocol: class {
    func presentTodoList()
}

//MARK: Presenter -
protocol LandingPresenterProtocol: class {

    var interactor: LandingInteractorInputProtocol? { get set }
    
    func validate(form: LandingItem.Request) 
}

//MARK: Interactor -
protocol LandingInteractorOutputProtocol: class {

    /* Interactor -> Presenter */
    func didReceive(responseSuccess: LandingItem.Reponse)
    func didReceive(errorMessage: String)
}

protocol LandingInteractorInputProtocol: class {

    var presenter: LandingInteractorOutputProtocol?  { get set }

    func performLogin(form: LandingItem.Request)
    func performRegister(form: LandingItem.Request)
}

//MARK: View -
protocol LandingViewProtocol: class {

    var presenter: LandingPresenterProtocol?  { get set }

    func displayError(from error: [LandingItem.View])
    func displayAlert(message: String) 
}
