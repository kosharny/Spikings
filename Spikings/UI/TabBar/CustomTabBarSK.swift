import SwiftUI

struct CustomTabBarSK: View {
    @Binding var selectedTab: Int
    var theme: ThemeModelSK
    
    let tabs: [(icon: String, title: String)] = [
        ("house.fill", "Home"),
        ("book.fill", "Journal"),
        ("magnifyingglass", "Search"),
        ("heart.fill", "Favorites"),
        ("chart.bar.fill", "Stats")
    ]
    
    var body: some View {
        HStack(spacing: 8) {
            ForEach(0..<tabs.count, id: \.self) { index in
                Button(action: {
                    withAnimation(.spring(response: 0.3, dampingFraction: 0.7)) {
                        selectedTab = index
                    }
                }) {
                    VStack(spacing: 4) {
                        Image(systemName: tabs[index].icon)
                            .font(.system(size: 20, weight: .semibold))
                            .foregroundColor(selectedTab == index ? .egyptOrange : theme.textColor.opacity(0.5))
                        
                        Text(tabs[index].title)
                            .font(.system(size: 9, weight: .medium))
                            .foregroundColor(selectedTab == index ? .egyptOrange : theme.textColor.opacity(0.5))
                    }
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 10)
                    .background(
                        selectedTab == index ? 
                        Color.egyptOrange.opacity(0.15) : Color.clear
                    )
                    .cornerRadius(30)
                }
            }
        }
        .padding(.horizontal, 8)
        .padding(.vertical, 8)
        .background(
            Capsule()
                .fill(.ultraThinMaterial.opacity(0.8))
                .overlay(
                    Capsule()
                        .stroke(Color.egyptOrange.opacity(0.3), lineWidth: 1)
                )
        )
        .padding(.horizontal, 16)
        .padding(.bottom, 8)
        .shadow(color: .black.opacity(0.15), radius: 20, x: 0, y: 10)
    }
}

#Preview {
    CustomTabBarSK(selectedTab: .constant(0), theme: .desertSands)
}
