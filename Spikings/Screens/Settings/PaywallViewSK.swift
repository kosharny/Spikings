import SwiftUI
import StoreKit

struct PaywallViewSK: View {
    @EnvironmentObject var viewModel: MainViewModelSK
    @Environment(\.dismiss) var dismiss
    @State private var selectedTheme: ThemeModelSK?
    
    let premiumThemes = ThemeModelSK.allThemes.filter { $0.isPremium }
    
    @State private var showPurchaseConfirmation = false
    @State private var showSuccessAlert = false
    @State private var showErrorAlert = false
    @State private var errorMessage = ""
    @State private var pendingPurchaseTheme: ThemeModelSK?
    
    var body: some View {
        ZStack {
            GradientBackgroundSK(colors: [.egyptGold, .egyptOrange])
            
            VStack(spacing: 0) {
                HStack {
                    Button(action: { dismiss() }) {
                        Image(systemName: "chevron.left")
                            .font(.system(size: 18, weight: .semibold))
                            .foregroundColor(.white)
                            .padding(12)
                            .background(Color.white.opacity(0.2))
                            .clipShape(Circle())
                    }
                    Spacer()
                }
                .padding(.horizontal, 20)
                .padding(.top, 20)
                
                ScrollView {
                    VStack(spacing: 32) {
                        VStack(spacing: 16) {
                            Image(systemName: "crown.fill")
                                .font(.system(size: 60, weight: .bold))
                                .foregroundColor(.white)
                            
                            Text("Unlock Premium Themes")
                                .font(.system(size: 30, weight: .bold))
                                .foregroundColor(.white)
                                .multilineTextAlignment(.center)
                            
                            Text("Enhance your experience with exclusive color palettes inspired by Ancient Egypt")
                                .font(.system(size: 16, weight: .regular))
                                .foregroundColor(.white.opacity(0.9))
                                .multilineTextAlignment(.center)
                                .padding(.horizontal, 40)
                        }
                        .padding(.top, 20)
                        
                        VStack(spacing: 16) {
                            ForEach(premiumThemes) { theme in
                                let storeProduct = viewModel.storeManager.products.first(where: { $0.id == theme.id })
                                let displayPrice = storeProduct?.displayPrice ?? theme.price
                                Button(action: {
                                    selectedTheme = theme
                                }) {
                                    VStack(spacing: 16) {
                                        HStack(spacing: 16) {
                                            LinearGradient(
                                                gradient: Gradient(colors: theme.primaryGradient),
                                                startPoint: .topLeading,
                                                endPoint: .bottomTrailing
                                            )
                                            .frame(width: 80, height: 80)
                                            .cornerRadius(16)
                                            
                                            VStack(alignment: .leading, spacing: 8) {
                                                Text(theme.name)
                                                    .font(.system(size: 20, weight: .bold))
                                                    .foregroundColor(.white)
                                                
                                                Text(displayPrice)
                                                    .font(.system(size: 16, weight: .semibold))
                                                    .foregroundColor(.white.opacity(0.8))
                                                
                                                if viewModel.storeManager.hasAccess(to: theme.id) {
                                                    HStack(spacing: 4) {
                                                        Image(systemName: "checkmark.circle.fill")
                                                            .font(.system(size: 14))
                                                        Text("Purchased")
                                                            .font(.system(size: 13, weight: .medium))
                                                    }
                                                    .foregroundColor(.white)
                                                }
                                            }
                                            
                                            Spacer()
                                        }
                                        
                                        if selectedTheme?.id == theme.id && !viewModel.storeManager.hasAccess(to: theme.id) {
                                            CustomButtonSK(
                                                title: "Purchase \(displayPrice)",
                                                icon: "cart.fill",
                                                action: {
                                                    pendingPurchaseTheme = theme
                                                    showPurchaseConfirmation = true
                                                },
                                                theme: ThemeModelSK(
                                                    id: "paywall",
                                                    name: "Paywall",
                                                    isPremium: false,
                                                    price: "",
                                                    primaryGradient: [],
                                                    accentColor: .white,
                                                    textColor: .egyptGold,
                                                    cardBackground: .white
                                                )
                                            )
                                            .disabled(viewModel.storeManager.isLoading)
                                        }
                                    }
                                    .padding(20)
                                    .background(Color.white.opacity(selectedTheme?.id == theme.id ? 0.25 : 0.15))
                                    .cornerRadius(20)
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 20)
                                            .stroke(Color.white.opacity(selectedTheme?.id == theme.id ? 0.5 : 0), lineWidth: 2)
                                    )
                                }
                            }
                        }
                        .padding(.horizontal, 20)
                        
                        VStack(spacing: 12) {
                            FeatureRowSK(icon: "paintpalette.fill", text: "Exclusive color schemes")
                            FeatureRowSK(icon: "sparkles", text: "Premium gradients")
                            FeatureRowSK(icon: "eye.fill", text: "Enhanced visual experience")
                            FeatureRowSK(icon: "arrow.clockwise", text: "Restore on all devices")
                        }
                        .padding(.horizontal, 40)
                        
                        Button(action: { dismiss() }) {
                            Text("Not Now")
                                .font(.system(size: 16, weight: .medium))
                                .foregroundColor(.white.opacity(0.7))
                        }
                        .padding(.bottom, 40)
                    }
                }
            }
            if showPurchaseConfirmation {
                CustomAlertSK(
                    title: "Confirm Purchase",
                    message: "Do you really want to buy \(pendingPurchaseTheme?.name ?? "Premium Theme") for \(formattedPriceFor(pendingPurchaseTheme))?",
                    primaryButtonTitle: "Buy",
                    secondaryButtonTitle: "Cancel",
                    primaryAction: {
                        if let theme = pendingPurchaseTheme {
                            Task {
                                showPurchaseConfirmation = false
                                // Slight delay to avoid UI glitches
                                try? await Task.sleep(nanoseconds: 100_000_000)
                                
                                let result = await viewModel.storeManager.purchaseTheme(theme.id)
                                switch result {
                                case .success:
                                    showSuccessAlert = true
                                    viewModel.selectTheme(theme)
                                case .failed(let error):
                                    errorMessage = error.localizedDescription
                                    showErrorAlert = true
                                case .userCancelled, .pending:
                                    break
                                }
                            }
                        }
                    },
                    secondaryAction: {
                        showPurchaseConfirmation = false
                    },
                    theme: ThemeModelSK(
                        id: "alert_theme",
                        name: "Alert",
                        isPremium: false,
                        price: "",
                        primaryGradient: [.egyptGold, .egyptOrange],
                        accentColor: .egyptGold,
                        textColor: .black,
                        cardBackground: .white
                    )
                )
            }
            
            if showSuccessAlert {
                CustomAlertSK(
                    title: "Purchase Successful",
                    message: "You successfully purchased the theme!",
                    primaryButtonTitle: "OK",
                    secondaryButtonTitle: nil,
                    primaryAction: {
                        showSuccessAlert = false
                        dismiss()
                    },
                    secondaryAction: nil,
                    theme: ThemeModelSK(
                        id: "alert_theme",
                        name: "Alert",
                        isPremium: false,
                        price: "",
                        primaryGradient: [.egyptGold, .egyptOrange],
                        accentColor: .egyptGold,
                        textColor: .black,
                        cardBackground: .white
                    )
                )
            }
            
            if showErrorAlert {
                CustomAlertSK(
                    title: "Purchase Failed",
                    message: errorMessage,
                    primaryButtonTitle: "OK",
                    secondaryButtonTitle: nil,
                    primaryAction: {
                        showErrorAlert = false
                    },
                    secondaryAction: nil,
                    theme: ThemeModelSK(
                        id: "alert_theme",
                        name: "Alert",
                        isPremium: false,
                        price: "",
                        primaryGradient: [.egyptGold, .egyptOrange],
                        accentColor: .egyptGold,
                        textColor: .black,
                        cardBackground: .white
                    )
                )
            }
        }
        .onChange(of: viewModel.storeManager.purchasedProductIDs) { newValue in
            if let selected = selectedTheme, newValue.contains(selected.id) {
                if !showSuccessAlert && !showPurchaseConfirmation {
                    viewModel.selectTheme(selected)
                }
            }
        }
        .onAppear {
            if viewModel.storeManager.products.isEmpty {
                Task {
                    await viewModel.storeManager.fetchProducts()
                }
            }
        }
    }
    
    private func formattedPriceFor(_ theme: ThemeModelSK?) -> String {
        guard let theme = theme else { return "" }
        let storeProduct = viewModel.storeManager.products.first(where: { $0.id == theme.id })
        return storeProduct?.displayPrice ?? theme.price
    }
}

struct FeatureRowSK: View {
    let icon: String
    let text: String
    
    var body: some View {
        HStack(spacing: 12) {
            Image(systemName: icon)
                .font(.system(size: 18, weight: .semibold))
                .foregroundColor(.white)
                .frame(width: 32, height: 32)
            
            Text(text)
                .font(.system(size: 15, weight: .medium))
                .foregroundColor(.white)
            
            Spacer()
        }
    }
}

#Preview {
    PaywallViewSK()
        .environmentObject(MainViewModelSK())
}
