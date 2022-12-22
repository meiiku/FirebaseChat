//
//  LoginViewModel.swift
//  FirebaseChat
//
//  Created by Fedor on 22.12.2022.
//

import Foundation

class LoginViewModel {
    var email: String?
    var password: String?
    
    var formIsValid: Bool {
        return email?.isEmpty == false && password?.isEmpty == false
    }
}
