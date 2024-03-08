//
//  CustomButton.swift
//  UrbanSports
//
//  Created by Farheen Banu on 16/02/24.
//

import Foundation
import SwiftUI

enum ButtonStyle {
    case filled
    case bordered
}

struct CustomButton: View {
    var title: String
    var style: ButtonStyle
    var action: () -> Void
    var errorMessage: String?
    
    var body: some View {
        Button(action: action) {
            Text(title)
                .foregroundColor(.white)
                .padding()
                .frame(minWidth: 0, maxWidth: .infinity)
                .frame(height: 56)
                .background(buttonBackground)
                .cornerRadius(8)
                .overlay(buttonBorder)
            if let errorMessage = errorMessage {
                
            } else {
                
            }
        }
    }
    
    private var buttonBackground: some View {
        switch style {
        case .filled:
            return AnyView(CustomColorScheme.primary)
        case .bordered:
            return AnyView(Color.clear)
        }
    }
    
    private var buttonBorder: some View {
        switch style {
        case .filled:
            return AnyView(Color.clear)
        case .bordered:
            return AnyView(RoundedRectangle(cornerRadius: 8)
                .stroke(Color.white, lineWidth: 2))
        }
    }
}


struct CustomButton_Previews: PreviewProvider {
    static var previews: some View {
        CustomButton(title: "Test", style: .filled, action: {})
    }
}
