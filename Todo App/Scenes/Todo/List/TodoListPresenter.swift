//
//  TodoListPresenter.swift
//  Todo App
//
//  Created Blankz on 30/1/2564 BE.
//  Copyright © 2564 BE ___ORGANIZATIONNAME___. All rights reserved.
//
//  Template generated by Blankz
//

import UIKit

protocol TodoListDelegate: class {
    func didUpdateTodo(todo: TodoItem)
}

class TodoListPresenter: TodoListPresenterProtocol {
    weak private var view: TodoListViewProtocol?
    var interactor: TodoListInteractorInputProtocol?
    private let router: TodoListWireframeProtocol
    
    var todoList: [TodoItem]?

    init(interface: TodoListViewProtocol, interactor: TodoListInteractorInputProtocol?, router: TodoListWireframeProtocol) {
        self.view = interface
        self.interactor = interactor
        self.router = router
    }
    
    func didTapLogout() {
        interactor?.logout()
    }

    func performFetchTodoList() {
        interactor?.fetchTodoList()
    }
    
    func performCreateTodo(form: TodoListItem.Request.CreateTodo) {
        interactor?.createTodo(form: form)
    }
    
    func didTapTodo(at index: Int) {
        guard let item = todoList?[index] else { return }
        
        router.presentToDoDetail(todoItem: item)
    }
    
    func performDeleteTodo(at index: Int) {
        guard let id = todoList?[index].id else { return }
        
        interactor?.deteteTodo(id: id)
    }
}

extension TodoListPresenter: TodoListInteractorOutputProtocol {
    func didReceive(Error message: String) {
        view?.displayAlert(message: message)
    }

    func didReceive(List response: TodoListItem.Response.TodoList) {
        todoList = response.list
        
        view?.reloadTodoList()
    }
    
    func didReceive(todoItem response: TodoListItem.Response.CreateTodo) {
        if todoList == nil {
            todoList = []
        }
        
        todoList?.append(response.todo)
        
        view?.reloadTodoList()
    }
    
    func didReceiveDeleteTodo(response: TodoListItem.Response.DeleteTodo,
                              id: String) {
        if response.isSuccess {
            todoList = todoList?.filter { $0.id != id }
            view?.reloadTodoList()
        } else {
            view?.displayAlert(message: "can't delete todo")
        }
    }
     
    func didReceiveLogout(response: TodoListItem.Response.Logout) {
        if response.isSuccess {
            do {
                try KeychainAccess.shared.clear()
                router.presentLanding()
            } catch let error {
                view?.displayAlert(message: error.localizedDescription)
            }
        } else {
            view?.displayAlert(message: "Error: can't Logout")
        }

    }
}

//MARK:- Delegate
extension TodoListPresenter: TodoListDelegate {
    func didUpdateTodo(todo: TodoItem) {
        guard let index = todoList?.firstIndex(where: { $0.id == todo.id }) else { return }
        
        todoList?[index] = todo
        
        view?.reloadTodoList()
    }
}