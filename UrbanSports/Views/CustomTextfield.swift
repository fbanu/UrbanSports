//
//  CustomTextfield.swift
//  UrbanSports
//
//  Created by Farheen Banu on 27/02/24.
//

import Foundation
import SwiftUI

struct CustomTextField: View {
    @Binding var text: String
    var placeholder: String
    var title: String
    @State private var isSecure: Bool
    var shouldShowSecure: Bool
    var errorMessage: String?
    
    init(title: String, text: Binding<String>, placeholder: String, isSecure: Bool = false, errorMessage: String? = nil) {
        self.title = title
        self._text = text
        self.placeholder = placeholder
        self._isSecure = State(initialValue: isSecure)
        self.shouldShowSecure = isSecure
        self.errorMessage = errorMessage
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            Text(self.title)
                .foregroundColor(.primary)
                .font(.subheadline)
                .padding(.leading, 8)
            
            ZStack(alignment: .leading) {
                if text.isEmpty {
                    Text(placeholder)
                        .foregroundColor(Color.gray.opacity(0.5))
                        .padding(.leading, 8)
                }
                if isSecure {
                    SecureField("", text: $text)
                        .padding(.leading, 8)
                } else {
                    TextField("", text: $text)
                        .padding(.leading, 8)
                }
                HStack {
                    Spacer()
                    if shouldShowSecure {
                        Button(action: {
                            self.isSecure.toggle()
                        }) {
                            Image(systemName: "eye" + (isSecure ? "" : ".slash"))
                                .padding(.trailing, 10)
                                .foregroundColor(.gray)
                        }
                    }
                }
            }
            .frame(height: 50)
            .background(Color.white)
            .cornerRadius(8)
            .shadow(radius: 0.5)
            
                
                if let errorMessage = errorMessage {
                    Text(errorMessage)
                        .foregroundColor(.red)
                        .font(.caption)
                        .padding(.leading, 8)
                } else {
                    Text("some")
                        .foregroundColor(.clear)
                        .font(.caption)
                }
            
        }
    }
}

struct CustomTextField_Previews: PreviewProvider {
    static var previews: some View {
        CustomTextField(title: "Test", text: .constant(""), placeholder: "Hello", errorMessage: "mmmmmmmm")
    }
}
