import SwiftUI

struct GradientBackgroundSK: View {
    let colors: [Color]
    
    var body: some View {
        LinearGradient(
            gradient: Gradient(colors: colors),
            startPoint: .topLeading,
            endPoint: .bottomTrailing
        )
        .ignoresSafeArea()
    }
}

#Preview {
    GradientBackgroundSK(colors: [.egyptGold, .egyptSand])
}
