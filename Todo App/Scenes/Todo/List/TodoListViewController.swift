//
//  TodoListViewController.swift
//  Todo App
//
//  Created Blankz on 30/1/2564 BE.
//  Copyright © 2564 BE ___ORGANIZATIONNAME___. All rights reserved.
//
//  Template generated by Blankz
//

import UIKit

class TodoListViewController: UIViewController {
	var presenter: TodoListPresenterProtocol?
    
    private var tableView: UITableView!

	override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
        setupData()
    }
}

// MARK: - Setup
private extension TodoListViewController {
    func setupView() {
        setupNavitgationBar()
        setupBackground()
        setupTableView()
        setupLanguage()
    }
    
    func setupNavitgationBar() {
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Logout",
                                                           style: .done,
                                                           target: self,
                                                           action: #selector(didTapLogout))
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add,
                                                            target: self,
                                                            action: #selector(didTapAdd))
    }
    
    func setupBackground() {
        view.backgroundColor = .white
    }
    
    func setupTableView() {
        tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = UITableView.automaticDimension
        tableView.tableFooterView = UIView()
        view.addSubview(tableView)
        
        tableView.updateConstraints()
    }
    
    func setupLanguage() {
        title = "Todo List"
    }
}

// MARK:- setupData
private extension TodoListViewController {
    func setupData() {
        presenter?.performFetchTodoList()
    }
}

//MARK: - UpdateView
private extension TodoListViewController {
    func updateView() {
        tableView.reloadData()
    }
}

// MARK: - Datasource & Delegate
extension TodoListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView,
                   numberOfRowsInSection section: Int) -> Int {
        return presenter?.todoList?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView,
                   cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell")
        let todo = presenter?.todoList?[indexPath.row]
        
        cell?.textLabel?.text = todo?.description
        
        if todo?.isComplete ?? false {
            cell?.accessoryType = .checkmark
        } else {
            cell?.accessoryType = .none
        }
        
        return cell!
    }
    
    func tableView(_ tableView: UITableView,
                   didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: true)
        presenter?.didTapTodo(at: indexPath.row)
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            presenter?.performDeleteTodo(at: indexPath.row)
        }
    }
}

// MARK: - Action
private extension TodoListViewController {
    @objc func didTapAdd() {
        presentTodoCreateView()
    }
    
    @objc func didTapLogout() {
        presenter?.didTapLogout()
    }
}

// MARK: - Present
private extension  TodoListViewController {
    func presentTodoCreateView() {
        let alertView = UIAlertController(title: "Create Todo",
                                          message: "Description",
                                          preferredStyle: .alert)
        let btnCancel = UIAlertAction(title: "Cancel", style: .cancel)
        let btnConfirm = UIAlertAction(title: "Add", style: .default) { _ in
            guard let text = alertView.textFields?.first?.text,
                  !text.isEmpty
                  else {
                return
            }
            
            let form = TodoListItem.Request.CreateTodo(description: text)
            
            self.presenter?.performCreateTodo(form: form)
        }
        btnConfirm.isEnabled = false

        alertView.addTextField { (textField) in
            textField.placeholder = "Description"
            
            NotificationCenter.default.addObserver(forName: UITextField.textDidChangeNotification,
                                                   object: textField,
                                                   queue: .main) { _ in
                btnConfirm.isEnabled = textField.text != ""
            }
        }
        
        alertView.addAction(btnCancel)
        alertView.addAction(btnConfirm)
        
        present(alertView,
                animated: true)
    }
}

//MARK: - TodoListViewProtocol
extension TodoListViewController: TodoListViewProtocol {
    func reloadTodoList() {
        updateView()
    }
}