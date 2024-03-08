//
//  LoginViewModel.swift
//  UrbanSports
//
//  Created by Farheen Banu on 07/03/24.
//

import Foundation
import SwiftUI
import Combine

class LoginViewModel: ObservableObject {
    @Published var email: String = ""
    @Published var password: String = ""
    @Published var usernameErrorMessage: String?
    @Published var passwordErrorMessage: String?

    private var cancellableSet: Set<AnyCancellable> = []

    init() {
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
        
        Publishers.CombineLatest(usernameValidationPublisher, passwordValidationPublisher)
            .sink { [weak self] usernameError, passwordError in
                self?.usernameErrorMessage = usernameError
                self?.passwordErrorMessage = passwordError
            }
            .store(in: &cancellableSet)
    }

    func login() {
        guard usernameErrorMessage == nil, passwordErrorMessage == nil else {
            // Handle invalid input error
            return
        }

        // Perform login logic here
        print("Logging in with email: \(email), password: \(password)")
    }
}
