import SwiftUI

struct AboutViewSK: View {
    @EnvironmentObject var viewModel: MainViewModelSK
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        ZStack {
            GradientBackgroundSK(colors: viewModel.selectedTheme.primaryGradient)
            
            VStack(spacing: 0) {
                HStack {
                    Button(action: { dismiss() }) {
                        Image(systemName: "chevron.left")
                            .font(.system(size: 18, weight: .semibold))
                            .foregroundColor(viewModel.selectedTheme.textColor)
                            .padding(12)
                            .background(viewModel.selectedTheme.cardBackground)
                            .clipShape(Circle())
                    }
                    Spacer()
                }
                .padding(.horizontal, 20)
                .padding(.top, 20)
                
                ScrollView {
                    VStack(spacing: 32) {
                        VStack(spacing: 16) {
                            Image(systemName: "pyramid.fill")
                                .font(.system(size: 80, weight: .bold))
                                .foregroundColor(viewModel.selectedTheme.accentColor)
                            
                            Text("SPIKINGS")
                                .font(.system(size: 36, weight: .black))
                                .foregroundColor(viewModel.selectedTheme.textColor)
                            
                            Text("Version 1.0.0")
                                .font(.system(size: 14, weight: .medium))
                                .foregroundColor(viewModel.selectedTheme.textColor.opacity(0.6))
                        }
                        .padding(.top, 40)
                        
                        VStack(alignment: .leading, spacing: 16) {
                            Text("About")
                                .font(.system(size: 22, weight: .bold))
                                .foregroundColor(viewModel.selectedTheme.textColor)
                            
                            Text("Spikings is an educational application dedicated to exploring the mysteries and wonders of Ancient Egypt. Dive deep into the world of pharaohs, pyramids, ancient technologies, and archaeological discoveries through rich articles and interactive quests.")
                                .font(.system(size: 16, weight: .regular))
                                .foregroundColor(viewModel.selectedTheme.textColor.opacity(0.8))
                                .lineSpacing(6)
                        }
                        .padding(.horizontal, 20)
                        .padding(20)
                        .background(viewModel.selectedTheme.cardBackground.opacity(0.7))
                        .cornerRadius(16)
                        .padding(.horizontal, 20)
                        
                        VStack(alignment: .leading, spacing: 16) {
                            Text("Features")
                                .font(.system(size: 22, weight: .bold))
                                .foregroundColor(viewModel.selectedTheme.textColor)
                                .padding(.horizontal, 20)
                            
                            VStack(spacing: 12) {
                                AboutFeatureSK(
                                    icon: "book.fill",
                                    title: "Rich Articles",
                                    description: "Extensive educational content about Ancient Egypt",
                                    theme: viewModel.selectedTheme
                                )
                                
                                AboutFeatureSK(
                                    icon: "map.fill",
                                    title: "Interactive Quests",
                                    description: "Step-by-step learning experiences",
                                    theme: viewModel.selectedTheme
                                )
                                
                                AboutFeatureSK(
                                    icon: "chart.bar.fill",
                                    title: "Progress Tracking",
                                    description: "Monitor your learning journey",
                                    theme: viewModel.selectedTheme
                                )
                                
                                AboutFeatureSK(
                                    icon: "paintbrush.fill",
                                    title: "Custom Themes",
                                    description: "Beautiful Ancient Egypt inspired designs",
                                    theme: viewModel.selectedTheme
                                )
                            }
                            .padding(.horizontal, 20)
                        }
                    }
                }
            }
        }
        .navigationBarHidden(true)
    }
}

struct AboutFeatureSK: View {
    let icon: String
    let title: String
    let description: String
    var theme: ThemeModelSK
    
    var body: some View {
        HStack(spacing: 16) {
            Image(systemName: icon)
                .font(.system(size: 24, weight: .semibold))
                .foregroundColor(theme.accentColor)
                .frame(width: 50, height: 50)
                .background(theme.accentColor.opacity(0.15))
                .cornerRadius(12)
            
            VStack(alignment: .leading, spacing: 4) {
                Text(title)
                    .font(.system(size: 16, weight: .semibold))
                    .foregroundColor(theme.textColor)
                
                Text(description)
                    .font(.system(size: 13, weight: .regular))
                    .foregroundColor(theme.textColor.opacity(0.7))
            }
            
            Spacer()
        }
        .padding(16)
        .background(theme.cardBackground)
        .cornerRadius(12)
    }
}

#Preview {
    AboutViewSK()
        .environmentObject(MainViewModelSK())
}
