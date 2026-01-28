import SwiftUI

struct SplashViewSK: View {
    @State private var scale: CGFloat = 0.5
    @State private var opacity: Double = 0
    @Binding var isActive: Bool
    
    var body: some View {
        ZStack {
            GradientBackgroundSK(colors: [.egyptGold, .egyptOrange, .egyptSand])
            
            VStack(spacing: 20) {
                Image(systemName: "pyramid.fill")
                    .font(.system(size: 100, weight: .bold))
                    .foregroundColor(.white)
                    .scaleEffect(scale)
                    .opacity(opacity)
                
                Text("SPIKINGS")
                    .font(.system(size: 48, weight: .black))
                    .foregroundColor(.white)
                    .opacity(opacity)
                
                Text("Ancient Egypt Awaits")
                    .font(.system(size: 18, weight: .medium))
                    .foregroundColor(.white.opacity(0.9))
                    .opacity(opacity)
            }
        }
        .onAppear {
            withAnimation(.easeOut(duration: 0.8)) {
                scale = 1.0
                opacity = 1.0
            }
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                withAnimation(.easeInOut(duration: 0.5)) {
                    isActive = false
                }
            }
        }
    }
}

#Preview {
    SplashViewSK(isActive: .constant(false))
}
