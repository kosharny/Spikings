import SwiftUI

struct OnboardingViewSK: View {
    @EnvironmentObject var viewModel: MainViewModelSK
    @State private var currentPage = 0
    @Binding var isComplete: Bool
    
    let pages: [(icon: String, title: String, description: String)] = [
        ("pyramid.fill", "Discover Ancient Egypt", "Explore the mysteries of pharaohs, pyramids, and ancient technologies through rich educational content."),
        ("map.fill", "Interactive Quests", "Embark on step-by-step journeys to learn about pyramid construction, hieroglyphics, and archaeological discoveries."),
        ("star.fill", "Track Your Progress", "Complete quests, read articles, and build your knowledge of one of history's greatest civilizations.")
    ]
    
    var body: some View {
        ZStack {
            LinearGradient(
                gradient: Gradient(colors: [.black, Color(hex: "2C2416"), .egyptOrange]),
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
            .ignoresSafeArea()
            
            VStack(spacing: 0) {
                HStack {
                    Spacer()
                    
                    if currentPage < pages.count - 1 {
                        Button(action: {
                            PersistenceManagerSK.shared.hasCompletedOnboarding = true
                            isComplete = true
                        }) {
                            Text("Skip")
                                .font(.system(size: 16, weight: .semibold))
                                .foregroundColor(.egyptOrange)
                                .padding(.horizontal, 20)
                                .padding(.vertical, 10)
                                .background(Color.white.opacity(0.15))
                                .cornerRadius(20)
                        }
                    }
                }
                .padding(.horizontal, 20)
                .padding(.top, 20)
                
                Spacer()
                
                TabView(selection: $currentPage) {
                    ForEach(0..<pages.count, id: \.self) { index in
                        VStack(spacing: 24) {
                            Image(systemName: pages[index].icon)
                                .font(.system(size: 80, weight: .bold))
                                .foregroundColor(.egyptOrange)
                            
                            Text(pages[index].title)
                                .font(.system(size: 32, weight: .bold))
                                .foregroundColor(.white)
                                .multilineTextAlignment(.center)
                            
                            Text(pages[index].description)
                                .font(.system(size: 18, weight: .regular))
                                .foregroundColor(.egyptSand.opacity(0.9))
                                .multilineTextAlignment(.center)
                                .padding(.horizontal, 40)
                        }
                        .tag(index)
                    }
                }
                .tabViewStyle(.page(indexDisplayMode: .always))
                .indexViewStyle(.page(backgroundDisplayMode: .always))
                .frame(height: 400)
                
                Spacer()
                
                Button(action: {
                    if currentPage == pages.count - 1 {
                        PersistenceManagerSK.shared.hasCompletedOnboarding = true
                        isComplete = true
                    } else {
                        withAnimation {
                            currentPage += 1
                        }
                    }
                }) {
                    Text(currentPage == pages.count - 1 ? "Get Started" : "Continue")
                        .font(.system(size: 18, weight: .semibold))
                        .foregroundColor(.black)
                        .frame(maxWidth: .infinity)
                        .frame(height: 56)
                        .background(
                            LinearGradient(
                                gradient: Gradient(colors: [.egyptOrange, .egyptGold]),
                                startPoint: .leading,
                                endPoint: .trailing
                            )
                        )
                        .cornerRadius(16)
                }
                .padding(.horizontal, 40)
                .padding(.bottom, 40)
            }
        }
    }
}

#Preview {
    OnboardingViewSK(isComplete: .constant(false))
        .environmentObject(MainViewModelSK())
}
