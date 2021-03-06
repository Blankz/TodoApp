//
//  TodoDetailProtocols.swift
//  Todo App
//
//  Created Blankz on 30/1/2564 BE.
//  Copyright © 2564 BE ___ORGANIZATIONNAME___. All rights reserved.
//
//  Template generated by Blankz
//

import Foundation

//MARK: Wireframe -
protocol TodoDetailWireframeProtocol: class {
    static func presentTodoDetail(from view: AnyObject,
                                  todoItem: TodoItem) 
}
//MARK: Presenter -
protocol TodoDetailPresenterProtocol: class {
    var interactor: TodoDetailInteractorInputProtocol? { get set }
    var delegate: TodoListDelegate? { get set }
    var todoItem: TodoItem? { get set }
    func performSave(form: TodoDetailItem.Request.UpdateTodo)
}

//MARK: Interactor -
protocol TodoDetailInteractorOutputProtocol: class {

    func didReceive(Error message: String)
    func didReceive(todoItem response: TodoDetailItem.Response.Update)
}

protocol TodoDetailInteractorInputProtocol: class {

    var presenter: TodoDetailInteractorOutputProtocol?  { get set }

    func updateTodo(from todo: TodoDetailItem.Request.UpdateTodo)
}

//MARK: View -
protocol TodoDetailViewProtocol: class {

    var presenter: TodoDetailPresenterProtocol?  { get set }

    func displayAlert(message: String)
}
