//
//  LandingRouter.swift
//  Todo App
//
//  Created Blankz on 28/1/2564 BE.
//  Copyright © 2564 BE ___ORGANIZATIONNAME___. All rights reserved.
//
//  Template generated by Blankz
//

import UIKit

class LandingRouter: LandingWireframeProtocol {

    weak var viewController: UIViewController?

    static func createModule() -> UIViewController {
        let view = LandingViewController()
        let interactor = LandingInteractor()
        let router = LandingRouter()
        let presenter = LandingPresenter(interface: view,
                                         interactor: interactor,
                                         router: router)

        view.presenter = presenter
        interactor.presenter = presenter
        router.viewController = view

        return view
    }
    
    func presentTodoList() {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        let landingView = TodoListRouter.createModule()
        
        if #available(iOS 13.0, *) {
            if let scene = UIApplication.shared.connectedScenes.first {
                guard let windowScene = (scene as? UIWindowScene) else { return }
            
                let window: UIWindow = UIWindow(frame: windowScene.coordinateSpace.bounds)
                window.windowScene = windowScene //Make sure to do this
                window.rootViewController = landingView
                window.makeKeyAndVisible()
                appDelegate.window = window
            }
        } else {
            appDelegate.window?.rootViewController = landingView
            appDelegate.window?.makeKeyAndVisible()
        }
    }

}
