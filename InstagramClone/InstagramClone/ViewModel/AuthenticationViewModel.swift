//
//  AuthenticationViewModel.swift
//  InstagramClone
//
//  Created by Burak Erden on 9.04.2023.
//

import Foundation
import UIKit

protocol FormViewModel {
    func updateForm()
}

protocol AuthenticationViewModel {
    var formIsValid: Bool {get}
    var buttonBgColour: UIColor {get}
    
}

struct LoginViewModel: AuthenticationViewModel {
    var email: String?
    var password: String?
    
    var formIsValid: Bool {
        return email?.isEmpty == false && password?.isEmpty == false
    }
    
    var buttonBgColour: UIColor {
        return formIsValid ? UIColor(red: 134/255, green: 0/255, blue: 224/255, alpha: 0.6) : UIColor(red: 134/255, green: 0/255, blue: 224/255, alpha: 0.2)
    }
}

struct RegistrationViewModel: AuthenticationViewModel {
    var email: String?
    var password: String?
    var fullName: String?
    var userName: String?
    
    var formIsValid: Bool {
        return email?.isEmpty == false && password?.isEmpty == false && fullName?.isEmpty == false && userName?.isEmpty == false
    }
    var buttonBgColour: UIColor {
        return formIsValid ? UIColor(red: 134/255, green: 0/255, blue: 224/255, alpha: 0.6) : UIColor(red: 134/255, green: 0/255, blue: 224/255, alpha: 0.2)
    }
    
}

struct ResetPasswordViewModel: AuthenticationViewModel {
    var email: String?

    var formIsValid: Bool {
        return email?.isEmpty == false
    }
    
    var buttonBgColour: UIColor {
        return formIsValid ? UIColor(red: 134/255, green: 0/255, blue: 224/255, alpha: 0.6) : UIColor(red: 134/255, green: 0/255, blue: 224/255, alpha: 0.2)
    }
    
    
}
