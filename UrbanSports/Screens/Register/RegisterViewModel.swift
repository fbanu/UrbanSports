//
//  RegisterViewModel.swift
//  UrbanSports
//
//  Created by Farheen Banu on 08/03/24.
//

import Foundation
import SwiftUI
import Combine

class RegisterViewModel: ObservableObject {
    @Published var email: String = ""
    @Published var name: String = ""
    @Published var password: String = ""
    @Published var confirmPassword: String = ""
    @Published var usernameErrorMessage: String?
    @Published var passwordErrorMessage: String?
    @Published var nameErrorMessage: String?
    @Published var confirmPasswordErrorMessage: String?

    private var cancellableSet: Set<AnyCancellable> = []

    @Published var isRegisterButtonEnabled: Bool?
  
    init() {
        // Validation Publishers
        
        var isEmailValidPublisher: AnyPublisher<Bool, Never> {
            $email.map { email in
                let isValid = email.isValidEmail()
                self.usernameErrorMessage = isValid || email.isEmpty ? nil : "Enter a valid email address"
                return isValid
            }.eraseToAnyPublisher()
        }
        
        var arePasswordsValidPublisher: AnyPublisher<Bool, Never> {
            Publishers.CombineLatest($password, $confirmPassword)
                .map { password, confirmPassword in
                    let isValid = password.count >= 6
                    let doesMatch = password == confirmPassword
                    self.passwordErrorMessage = isValid ? nil : "Password must be at least 6 characters"
                    self.confirmPasswordErrorMessage = doesMatch ? nil : "Passwords do not match"
                    return isValid && doesMatch
                }
                .eraseToAnyPublisher()
        }
          
        let usernameValidationPublisher = $email
            .receive(on: DispatchQueue.main)
            .map { username in
                return username.count >= 5 || username.isEmpty ? nil : "Email must be at least 5 characters"
            }
        
        let passwordValidationPublisher = $password
            .receive(on: DispatchQueue.main)
            .map { password in
                return password.count >= 6 || password.isEmpty ? nil : "Password must be at least 6 characters"
            }
        
        let isNameValidPublisher = $name
            .receive(on: DispatchQueue.main)
            .map { name in
                return name.count >= 3 || name.isEmpty ? nil : "Name must be at least 3 characters"
            }
        
        
        Publishers.CombineLatest4(isEmailValidPublisher, passwordValidationPublisher, isNameValidPublisher, arePasswordsValidPublisher)
            .sink { [weak self] validEmail, passwordError, nameError, validPass in
                self?.passwordErrorMessage = passwordError
                self?.nameErrorMessage = nameError
                
                if validEmail == true && passwordError == nil && nameError == nil && validPass == true {
                    self?.isRegisterButtonEnabled = true
                } else {
                    self?.isRegisterButtonEnabled = false
                }
                
            }
            .store(in: &cancellableSet)
    }

    func register() {
        guard usernameErrorMessage == nil, passwordErrorMessage == nil, nameErrorMessage == nil else {
            // Handle invalid input error
            return
        }

        // Perform register logic here
        print("Registering with email: \(email), password: \(password), name: \(name)")
    }
}

extension String {
    func isValidEmail() -> Bool {
        // Regular expression for basic email validation
        let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPredicate = NSPredicate(format: "SELF MATCHES %@", emailRegex)
        return emailPredicate.evaluate(with: self)
    }
}
