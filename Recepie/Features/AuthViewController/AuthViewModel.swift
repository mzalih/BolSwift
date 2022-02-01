//
//  AuthViewModel.swift
//  Recepie
//
//  Created by Muhammed salih T A on 30/01/22.
//

import Foundation
import Combine

extension AuthViewController{
    
    class ViewModel {
        
        func isUserLoggedIn() -> AnyPublisher<AuthState, Error>{
                return Future {
                    promoise in
                    DispatchQueue.global().asyncAfter(deadline: .now() + 1) {
                        promoise(.success(.authenticatedUser))
                    }
                }.eraseToAnyPublisher()
        }
    }
    
}
