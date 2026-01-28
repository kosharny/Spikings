//
//  CustomAlertSK.swift
//  Spikings
//
//  Created by Maksim Kosharny on 28.01.2026.
//

import SwiftUI

struct CustomAlertSK: View {
    let title: String
    let message: String
    let primaryButtonTitle: String
    let secondaryButtonTitle: String?
    let primaryAction: () -> Void
    let secondaryAction: (() -> Void)?
    var theme: ThemeModelSK = .desertSands
    
    var body: some View {
        ZStack {
            Color.black.opacity(0.6)
                .edgesIgnoringSafeArea(.all)
                .onTapGesture {
                    
                }
            
            VStack(spacing: 20) {
                Text(title)
                    .font(.system(size: 22, weight: .bold))
                    .foregroundColor(theme.textColor)
                    .multilineTextAlignment(.center)
                
                Text(message)
                    .font(.system(size: 16, weight: .regular))
                    .foregroundColor(theme.textColor.opacity(0.8))
                    .multilineTextAlignment(.center)
                    .padding(.horizontal)
                
                HStack(spacing: 16) {
                    if let secondaryTitle = secondaryButtonTitle {
                        Button(action: {
                            secondaryAction?()
                        }) {
                            Text(secondaryTitle)
                                .font(.system(size: 16, weight: .semibold))
                                .foregroundColor(theme.textColor.opacity(0.7))
                                .padding(.vertical, 12)
                                .frame(maxWidth: .infinity)
                                .background(theme.cardBackground)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 12)
                                        .stroke(theme.textColor.opacity(0.3), lineWidth: 1)
                                )
                                .cornerRadius(12)
                        }
                    }
                    
                    Button(action: {
                        primaryAction()
                    }) {
                        Text(primaryButtonTitle)
                            .font(.system(size: 16, weight: .semibold))
                            .foregroundColor(.white) // Primary text usually white on accent
                            .padding(.vertical, 12)
                            .frame(maxWidth: .infinity)
                            .background(
                                LinearGradient(
                                    gradient: Gradient(colors: theme.primaryGradient),
                                    startPoint: .topLeading,
                                    endPoint: .bottomTrailing
                                )
                            )
                            .cornerRadius(12)
                            .shadow(color: theme.accentColor.opacity(0.3), radius: 4, x: 0, y: 2)
                    }
                }
                .padding(.top, 10)
            }
            .padding(24)
            .background(theme.cardBackground)
            .cornerRadius(20)
            .shadow(radius: 20)
            .padding(.horizontal, 40)
            .frame(maxWidth: 400)
        }
        .transition(.opacity)
        .zIndex(100) // Ensure it sits on top
    }
}

#Preview {
    ZStack {
        Image("custom_background") // Placeholder
        CustomAlertSK(
            title: "Confirm Purchase",
            message: "Do you really want to buy Golden Pharaoh for $1.99?",
            primaryButtonTitle: "Buy",
            secondaryButtonTitle: "Cancel",
            primaryAction: {},
            secondaryAction: {}
        )
    }
}
