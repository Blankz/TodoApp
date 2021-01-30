//
//  TodoListItem.swift
//  Todo App
//
//  Created Blankz on 30/1/2564 BE.
//  Copyright © 2564 BE ___ORGANIZATIONNAME___. All rights reserved.
//
//  Template generated by Blankz
//

import Foundation

struct TodoItem: Decodable {
    let id: String
    var description: String
    var isComplete: Bool
    let createdAt: String
    let updatedAt: String
    
    private enum CodingKeys: String, CodingKey {
        case id = "_id"
        case description, completed, createdAt, updatedAt
    }
    
    init(from decoder: Decoder) throws {
        let root = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try root.decode(String.self, forKey: .id)
        self.description = try root.decode(String.self, forKey: .description)
        self.isComplete = try root.decode(Bool.self, forKey: .completed)
        self.createdAt = try root.decode(String.self, forKey: .createdAt).getDate()
        self.updatedAt = try root.decode(String.self, forKey: .updatedAt).getDate()
    }
}

struct TodoListItem {
    struct Request {
        struct CreateTodo {
            let description: String
        }
    }
    
    struct Response {
        struct TodoList: Decodable {
            let count: Int
            let list: [TodoItem]
            
            private enum RootKey: String, CodingKey {
                case data, count
            }

            init(from decoder: Decoder) throws {
                let root = try decoder.container(keyedBy: RootKey.self)
                count = try root.decode(Int.self, forKey: .count)
                list = try root.decode([TodoItem].self, forKey: .data)
            }
        }
        
        struct CreateTodo: Decodable {
            let todo: TodoItem
        
            private enum RootKey: String, CodingKey {
                case data
            }

            init(from decoder: Decoder) throws {
                let root = try decoder.container(keyedBy: RootKey.self)
                todo = try root.decode(TodoItem.self, forKey: .data)
            }
        }
        
        struct DeleteTodo: Decodable {
            let isSuccess: Bool
            
            private enum RootKey: String, CodingKey {
                case success
            }

            init(from decoder: Decoder) throws {
                let root = try decoder.container(keyedBy: RootKey.self)
                isSuccess = try root.decode(Bool.self, forKey: .success)
            }
        }
        
        struct Logout: Decodable {
            let isSuccess: Bool
            
            private enum RootKey: String, CodingKey {
                case success
            }

            init(from decoder: Decoder) throws {
                let root = try decoder.container(keyedBy: RootKey.self)
                isSuccess = try root.decode(Bool.self, forKey: .success)
            }
        }

    }
}
