import SwiftUI

struct PremiumBadgeSK: View {
    var size: CGFloat = 24
    
    var body: some View {
        HStack(spacing: 4) {
            Image(systemName: "lock.fill")
                .font(.system(size: size * 0.5, weight: .bold))
            Text("PRO")
                .font(.system(size: size * 0.5, weight: .bold))
        }
        .foregroundColor(.white)
        .padding(.horizontal, size * 0.5)
        .padding(.vertical, size * 0.3)
        .background(
            LinearGradient(
                gradient: Gradient(colors: [Color.egyptGold, Color(hex: "B8860B")]),
                startPoint: .leading,
                endPoint: .trailing
            )
        )
        .cornerRadius(size * 0.4)
        .shadow(color: .black.opacity(0.3), radius: 4, x: 0, y: 2)
    }
}

#Preview {
    VStack(spacing: 20) {
        PremiumBadgeSK()
        PremiumBadgeSK(size: 32)
    }
    .padding()
    .background(Color.egyptLightSand)
}
