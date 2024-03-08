//
//  ContentView.swift
//  UrbanSports
//
//  Created by Farheen Banu on 13/02/24.
//

import SwiftUI

struct ContentView: View {
    @State private var isRegisterViewActive = false
    @State private var isLoginViewActive = false

    var body: some View {
        NavigationView {
            ZStack {
                // Background image
                Image("welcome")
                    .resizable()
                    .scaledToFill()
                    .edgesIgnoringSafeArea(.all)
                
                VStack {
                    Spacer()
                    Spacer()
                    Spacer()
                    
                    // Logo image
                    Image("urbanshadow")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 200, height: 80)
                        .padding(.bottom, 10)
                    
                    

                    NavigationLink(
                        destination: LoginView(isActive: $isLoginViewActive),
                        isActive: $isLoginViewActive,
                        label: {
                            // Register button
                            // Login button
                            CustomButton(title: "LOGIN", style: .filled, action: {
                                // Handle login action here if needed
                                isLoginViewActive = true
                            })
                            .padding(.bottom, 20)
                        }
                    )
                    
                    
                    NavigationLink(
                        destination: RegisterView(isActive: $isRegisterViewActive),
                        isActive: $isRegisterViewActive,
                        label: {
                            // Register button
                            CustomButton(title: "REGISTER", style: .bordered, action: {
                                // Handle register action here if needed
                                isRegisterViewActive = true
                            })
                            .padding(.bottom, 20)
                        }
                    )
                    
                    // Continue as guest button
                    Button(action: {
                        // Action for continue as guest button
                    }) {
                        Text("Continue as Guest")
                            .foregroundColor(.white)
                            .underline()
                    }
                    
                    Spacer()
                }
                .padding(30)
            }
            .navigationBarBackButtonHidden(true)
            .navigationBarTitle("")
            .navigationBarItems(leading: CustomBackButton())
        }
    }
}

struct CustomBackButton: View {
    @Environment(\.presentationMode) var presentationMode

    var body: some View {
        Button(action: {
            // Handle custom back button action
            self.presentationMode.wrappedValue.dismiss()
        }) {
            Image(systemName: "chevron.left") // Custom back button icon
                .foregroundColor(.primary) // Customize with your desired color
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
