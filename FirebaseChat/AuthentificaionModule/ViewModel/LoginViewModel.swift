//
//  LoginViewModel.swift
//  FirebaseChat
//
//  Created by Fedor on 22.12.2022.
//

import Foundation

class LoginViewModel: AuthenticationProtocol {
    
    var email: String? = nil
    var password: String? = nil
    
    var formIsValid: Bool {
        return email?.isEmpty == false && password?.isEmpty == false
    }
}
