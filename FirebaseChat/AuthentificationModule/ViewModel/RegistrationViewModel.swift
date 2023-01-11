//
//  RegistrationViewModel.swift
//  FirebaseChat
//
//  Created by Fedor on 22.12.2022.
//

import Foundation

class RegistrationViewModel: AuthenticationProtocol {
    var email: String?
    var password: String?
    var fullname: String?
    var username: String?
    
    var formIsValid: Bool {
        return email?.isEmpty == false && password?.isEmpty == false
            && fullname?.isEmpty == false && username?.isEmpty == false
    }
}
