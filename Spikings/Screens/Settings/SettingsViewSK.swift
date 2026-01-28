import SwiftUI

struct SettingsViewSK: View {
    @EnvironmentObject var viewModel: MainViewModelSK
    @Environment(\.dismiss) var dismiss
    @State private var showPaywall = false
    @State private var showRestoreAlert = false
    
    var body: some View {
        ZStack {
            GradientBackgroundSK(colors: viewModel.selectedTheme.primaryGradient)
            
            VStack(spacing: 0) {
                CustomHeaderSK(
                    title: "Settings",
                    subtitle: "Customize your experience",
                    showBackButton: true,
                    onBack: { dismiss() },
                    theme: viewModel.selectedTheme
                )
                
                ScrollView {
                    VStack(alignment: .leading, spacing: 24) {
                        VStack(alignment: .leading, spacing: 12) {
                            Text("Themes")
                                .font(.system(size: 20, weight: .bold))
                                .foregroundColor(viewModel.selectedTheme.textColor)
                                .padding(.horizontal, 20)
                            
                            VStack(spacing: 12) {
                                ForEach(ThemeModelSK.allThemes) { theme in
                                    Button(action: {
                                        if theme.isPremium && !viewModel.storeManager.hasAccess(to: theme.id) {
                                            showPaywall = true
                                        } else {
                                            viewModel.selectTheme(theme)
                                        }
                                    }) {
                                        HStack(spacing: 16) {
                                            ZStack {
                                                LinearGradient(
                                                    gradient: Gradient(colors: theme.primaryGradient),
                                                    startPoint: .topLeading,
                                                    endPoint: .bottomTrailing
                                                )
                                                .frame(width: 60, height: 60)
                                                .cornerRadius(12)
                                                
                                                if viewModel.selectedTheme.id == theme.id {
                                                    Image(systemName: "checkmark.circle.fill")
                                                        .font(.system(size: 24, weight: .bold))
                                                        .foregroundColor(.white)
                                                }
                                            }
                                            
                                            VStack(alignment: .leading, spacing: 4) {
                                                HStack(spacing: 8) {
                                                    Text(theme.name)
                                                        .font(.system(size: 16, weight: .semibold))
                                                        .foregroundColor(viewModel.selectedTheme.textColor)
                                                    
                                                    if theme.isPremium && !viewModel.storeManager.hasAccess(to: theme.id) {
                                                        PremiumBadgeSK(size: 18)
                                                    }
                                                }
                                                
                                                Text(theme.price)
                                                    .font(.system(size: 13, weight: .regular))
                                                    .foregroundColor(viewModel.selectedTheme.textColor.opacity(0.6))
                                            }
                                            
                                            Spacer()
                                            
                                            if theme.isPremium && !viewModel.storeManager.hasAccess(to: theme.id) {
                                                Image(systemName: "lock.fill")
                                                    .font(.system(size: 18))
                                                    .foregroundColor(viewModel.selectedTheme.textColor.opacity(0.4))
                                            }
                                        }
                                        .padding(16)
                                        .background(viewModel.selectedTheme.cardBackground)
                                        .cornerRadius(16)
                                        .overlay(
                                            RoundedRectangle(cornerRadius: 16)
                                                .stroke(viewModel.selectedTheme.id == theme.id ? viewModel.selectedTheme.accentColor : Color.clear, lineWidth: 2)
                                        )
                                    }
                                }
                            }
                            .padding(.horizontal, 20)
                        }
                        
                        VStack(alignment: .leading, spacing: 12) {
                            Text("Account")
                                .font(.system(size: 20, weight: .bold))
                                .foregroundColor(viewModel.selectedTheme.textColor)
                                .padding(.horizontal, 20)
                            
                            VStack(spacing: 12) {
                                Button(action: {
                                    Task {
                                        await viewModel.storeManager.restorePurchases()
                                        showRestoreAlert = true
                                    }
                                }) {
                                    HStack {
                                        Image(systemName: "arrow.clockwise")
                                            .font(.system(size: 18, weight: .semibold))
                                            .foregroundColor(viewModel.selectedTheme.accentColor)
                                        
                                        Text("Restore Purchases")
                                            .font(.system(size: 16, weight: .medium))
                                            .foregroundColor(viewModel.selectedTheme.textColor)
                                        
                                        Spacer()
                                        
                                        Image(systemName: "chevron.right")
                                            .font(.system(size: 14))
                                            .foregroundColor(viewModel.selectedTheme.textColor.opacity(0.4))
                                    }
                                    .padding(16)
                                    .background(viewModel.selectedTheme.cardBackground)
                                    .cornerRadius(12)
                                }
                                
                                NavigationLink(destination: AboutViewSK().environmentObject(viewModel)) {
                                    HStack {
                                        Image(systemName: "info.circle")
                                            .font(.system(size: 18, weight: .semibold))
                                            .foregroundColor(viewModel.selectedTheme.accentColor)
                                        
                                        Text("About Spikings")
                                            .font(.system(size: 16, weight: .medium))
                                            .foregroundColor(viewModel.selectedTheme.textColor)
                                        
                                        Spacer()
                                        
                                        Image(systemName: "chevron.right")
                                            .font(.system(size: 14))
                                            .foregroundColor(viewModel.selectedTheme.textColor.opacity(0.4))
                                    }
                                    .padding(16)
                                    .background(viewModel.selectedTheme.cardBackground)
                                    .cornerRadius(12)
                                }
                            }
                            .padding(.horizontal, 20)
                        }
                        
                        Spacer(minLength: 40)
                    }
                    .padding(.top, 8)
                }
            }
        }
        .sheet(isPresented: $showPaywall) {
            PaywallViewSK()
                .environmentObject(viewModel)
        }
        .alert("Restore", isPresented: $showRestoreAlert, actions: {
            Button("OK", role: .cancel) { }
        }, message: {
            Text(viewModel.storeManager.restoreMessage ?? "")
        })
        .navigationBarHidden(true)
    }
}

#Preview {
    SettingsViewSK()
        .environmentObject(MainViewModelSK())
}
