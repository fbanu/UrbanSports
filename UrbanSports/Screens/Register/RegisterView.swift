//
//  RegisterView.swift
//  UrbanSports
//
//  Created by Farheen Banu on 08/03/24.
//

import Foundation
import SwiftUI

struct RegisterView: View {
    
    @Binding var isActive: Bool
    @State private var email: String = ""
    @State private var password: String = ""
    @ObservedObject var viewModel = LoginViewModel()
    @Environment(\.presentationMode) var presentationMode
    
    var isLoginEnabled: Bool {
        return viewModel.usernameErrorMessage == nil && viewModel.passwordErrorMessage == nil &&
        !viewModel.username.isEmpty && !viewModel.password.isEmpty
    }
    
    var body: some View {
        VStack {
            
            ScrollView {
                VStack {
                    Spacer()
                    Text("Hello! Register to get started")
                        .font(.title)
                        .fontWeight(.bold)
                        .padding(.bottom, 30)
                        .frame(maxWidth: .infinity, alignment: .leading)
                    
                    CustomTextField(title: "Email", text: $viewModel.username, placeholder: "Enter your email", errorMessage: viewModel.usernameErrorMessage)
                    
                    CustomTextField(title: "Name", text: $viewModel.username, placeholder: "Enter your full name", errorMessage: viewModel.usernameErrorMessage)
                    
                    CustomTextField(title: "Password", text: $viewModel.password, placeholder: "Enter your password", isSecure: true, errorMessage: viewModel.passwordErrorMessage)
                    
                    CustomTextField(title: "Confirm Password", text: $viewModel.password, placeholder: "Enter your password", isSecure: true, errorMessage: viewModel.passwordErrorMessage)
                    
                    // Login button
                    CustomButton(title: "REGISTER", style: .filled, action: {
                        viewModel.login()
                        // self.areYouGoingToSecondView = true // Step 4
                    })
                    .padding(.top, 20)
                    .disabled(!isLoginEnabled)
                    .opacity(isLoginEnabled ? 1.0 : 0.5)
                    
                    VStack {
                        ZStack {
                            Divider()
                                .background(Color.secondary.opacity(0.5)) // Set color as desired
                                .frame(height: 1)
                            
                            Text("or register with")
                                .foregroundColor(.secondary) // Set color as desired
                                .padding(.horizontal, 8) // Adjust padding as needed
                                .padding(.vertical, 4)
                                .background(Color(UIColor.systemBackground)) // Match background color
                            
                        }
                        .frame(height: 30)
                    }
                    .padding(.top, 20)
                    
                    HStack(spacing: 20) {
                        Button(action: {
                            // Action for Facebook button
                        }) {
                            
                            RoundedRectangle(cornerRadius: 8)
                                .fill(Color.white)
                                .overlay(
                                    Image(ImageResource(name:   "facebook", bundle: .main))
                                        .resizable()
                                        .aspectRatio(contentMode: .fit)
                                        .frame(width: 30, height: 30)
                                        .foregroundColor(.blue)
                                )
                                .frame(height: 56)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 8)
                                        .stroke(Color.gray.opacity(0.5), lineWidth: 0.5)
                                )
                                .shadow(color: Color.gray.opacity(0.1), radius: 3, x: 0, y: 2)
                        }
                        
                        Button(action: {
                            // Action for Facebook button
                        }) {
                            RoundedRectangle(cornerRadius: 8)
                                .fill(Color.white)
                                .overlay(
                                    Image(ImageResource(name: "google", bundle: .main))
                                        .resizable()
                                        .aspectRatio(contentMode: .fit)
                                        .frame(width: 30, height: 30)
                                        .foregroundColor(.green)
                                )
                                .frame(height: 56)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 8)
                                        .stroke(Color.gray.opacity(0.5), lineWidth: 0.5)
                                )
                                .shadow(color: Color.gray.opacity(0.1), radius: 3, x: 0, y: 2)
                        }
                        Button(action: {
                            // Action for Facebook button
                        }) {
                            RoundedRectangle(cornerRadius: 8)
                                .fill(Color.white)
                                .overlay(
                                    Image(ImageResource(name: "apple", bundle: .main))
                                        .resizable()
                                        .aspectRatio(contentMode: .fit)
                                        .frame(width: 30, height: 30)
                                        .foregroundColor(.black)
                                )
                                .frame(height: 56)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 8)
                                        .stroke(Color.gray.opacity(0.5), lineWidth: 0.5)
                                )
                                .shadow(color: Color.gray.opacity(0.1), radius: 3, x: 0, y: 2)
                        }
                    }
                    .padding(.top, 20)
                }
                
                .padding(20)
                .navigationBarBackButtonHidden(true)
                .navigationBarItems(leading: CustomBackButton())
            }
            
            Spacer()
            
            Button {
                presentationMode.wrappedValue.dismiss()
            } label: {
                HStack(spacing: 3) {
                    Text("Already have an account?")
                        .foregroundColor(.secondary)
                    Text("Login Now")
                        .fontWeight(.bold)
                        .foregroundColor(CustomColorScheme.primary)
                }
                .font(.system(size: 14))
            }
        }
    }
}

struct RegisterView_Previews: PreviewProvider {
    static var previews: some View {
        RegisterView(isActive: .constant(true))
    }
}
