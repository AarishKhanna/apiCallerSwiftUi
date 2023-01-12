//
//  UserViewModel.swift
//  apiCallerSwiftUi
//
//  Created by Aarish Khanna on 11/01/23.
//

import Foundation

final class UsersViewModel: ObservableObject {
    
    @Published var hasError = false
    @Published var error: UserError?
    
    @Published var users: [User] = []
    @Published var todos: [ToDoListItem] = []
    @Published private(set) var isRefreshing = false
    
    
    func fetchUsers() {
        
        hasError = false
        isRefreshing = true
        
        let usersUrlString = "https://jsonplaceholder.typicode.com/users"
        if let url = URL(string: usersUrlString) {
            
            URLSession
                .shared
                .dataTask(with: url) { [weak self] data, response, error in
                
                    
                    DispatchQueue.main.async {
                        
                        defer {
                            self?.isRefreshing = false
                        }
                        
                        if let error = error {
                            self?.hasError = true
                            self?.error = UserError.custom(error: error)
                        } else {
                            
                            let decoder = JSONDecoder()
                            decoder.keyDecodingStrategy = .convertFromSnakeCase
                            
                            if let data = data,
                               let users = try? decoder.decode([User].self, from: data) {
                                self?.users = users
                            } else {
                                self?.hasError = true
                                self?.error = UserError.failedToDecode
                            }
                        }
                    }
                    
                }.resume()

        }
    }
    
    func fetchToDos() {
        
        hasError = false
        isRefreshing = true
        
        let usersUrlString = "https://jsonplaceholder.typicode.com/todos"
        if let url = URL(string: usersUrlString) {
            
            URLSession
                .shared
                .dataTask(with: url) { [weak self] data, response, error in
                
                    
                    DispatchQueue.main.async {
                        
                        defer {
                            self?.isRefreshing = false
                        }
                        
                        if let error = error {
                            self?.hasError = true
                            self?.error = UserError.custom(error: error)
                        } else {
                            
                            let decoder = JSONDecoder()
                            decoder.keyDecodingStrategy = .convertFromSnakeCase 
                            
                            if let data = data,
                               let todos = try? decoder.decode([ToDoListItem].self, from: data) {
                              self?.todos = todos                        
                            } else {
                                self?.hasError = true
                                self?.error = UserError.failedToDecode
                            }
                        }
                    }
                    
                }.resume()

        }
    }
}

extension UsersViewModel {
    enum UserError: LocalizedError {
        case custom(error: Error)
        case failedToDecode
        
        var errorDescription: String? {
            switch self {
            case .failedToDecode:
                return "Failed to decode response"
            case .custom(let error):
                return error.localizedDescription
            }
        }
    }
}
