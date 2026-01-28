import SwiftUI

struct CustomHeaderSK: View {
    let title: String
    let subtitle: String?
    let showBackButton: Bool
    let onBack: (() -> Void)?
    let showSettingsButton: Bool
    var theme: ThemeModelSK = .desertSands
    
    init(title: String, subtitle: String? = nil, showBackButton: Bool = false, onBack: (() -> Void)? = nil, showSettingsButton: Bool = false, theme: ThemeModelSK = .desertSands) {
        self.title = title
        self.subtitle = subtitle
        self.showBackButton = showBackButton
        self.onBack = onBack
        self.showSettingsButton = showSettingsButton
        self.theme = theme
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack(alignment: .top) {
                VStack(alignment: .leading, spacing: 8) {
                    if showBackButton {
                        Button(action: { onBack?() }) {
                            HStack(spacing: 6) {
                                Image(systemName: "chevron.left")
                                    .font(.system(size: 16, weight: .semibold))
                                Text("Back")
                                    .font(.system(size: 16, weight: .medium))
                            }
                            .foregroundColor(theme.textColor)
                        }
                        .padding(.bottom, 4)
                    }
                    
                    Text(title)
                        .font(.system(size: 32, weight: .bold))
                        .foregroundColor(theme.textColor)
                    
                    if let subtitle = subtitle {
                        Text(subtitle)
                            .font(.system(size: 16, weight: .regular))
                            .foregroundColor(theme.textColor.opacity(0.7))
                    }
                }
                
                Spacer()
                
                if showSettingsButton {
                    NavigationLink(destination: SettingsViewSK()) {
                        Image(systemName: "gearshape.fill")
                            .font(.system(size: 24, weight: .semibold))
                            .foregroundColor(theme.accentColor)
                            .padding(12)
                            .background(theme.cardBackground)
                            .clipShape(Circle())
                    }
                }
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(.horizontal, 20)
        .padding(.vertical, 16)
    }
}

#Preview {
    VStack(spacing: 0) {
        CustomHeaderSK(
            title: "Ancient Mysteries",
            subtitle: "Discover the secrets of Egypt",
            showBackButton: true,
            onBack: {},
            showSettingsButton: true
        )
        Spacer()
    }
    .background(Color.egyptLightSand)
}
