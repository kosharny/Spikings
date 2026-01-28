import SwiftUI

struct CustomButtonSK: View {
    let title: String
    let icon: String?
    let action: () -> Void
    var isPrimary: Bool = true
    var theme: ThemeModelSK = .desertSands
    
    var body: some View {
        Button(action: action) {
            HStack(spacing: 8) {
                if let icon = icon {
                    Image(systemName: icon)
                        .font(.system(size: 16, weight: .semibold))
                }
                Text(title)
                    .font(.system(size: 17, weight: .semibold))
            }
            .foregroundColor(isPrimary ? theme.textColor : theme.accentColor)
            .frame(maxWidth: .infinity)
            .frame(height: 50)
            .background(backgroundView)
            .cornerRadius(12)
            .overlay(
                RoundedRectangle(cornerRadius: 12)
                    .stroke(theme.accentColor, lineWidth: isPrimary ? 0 : 2)
            )
            .shadow(color: theme.accentColor.opacity(0.3), radius: isPrimary ? 8 : 0, x: 0, y: 3)
        }
    }
    
    @ViewBuilder
    private var backgroundView: some View {
        if isPrimary {
            LinearGradient(
                gradient: Gradient(colors: [theme.accentColor, theme.accentColor.opacity(0.8)]),
                startPoint: .leading,
                endPoint: .trailing
            )
            .opacity(0.9)
        } else {
            LinearGradient(
                gradient: Gradient(colors: [theme.cardBackground, theme.cardBackground]),
                startPoint: .leading,
                endPoint: .trailing
            )
        }
    }
}

#Preview {
    VStack(spacing: 20) {
        CustomButtonSK(title: "Start Quest", icon: "play.fill", action: {})
        CustomButtonSK(title: "Learn More", icon: nil, action: {}, isPrimary: false)
    }
    .padding()
    .background(Color.egyptLightSand)
}
