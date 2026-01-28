import SwiftUI

struct MainViewSK: View {
    @EnvironmentObject var viewModel: MainViewModelSK
    @State private var showSplash = true
    @State private var showOnboarding = false
    
    var body: some View {
        Group {
            if showSplash {
                SplashViewSK(isActive: $showSplash)
            } else if !PersistenceManagerSK.shared.hasCompletedOnboarding {
                OnboardingViewSK(isComplete: $showOnboarding)
                    .environmentObject(viewModel)
            } else {
                NavigationStack {
                    TabContainerViewSK()
                        .environmentObject(viewModel)
                }
            }
        }
        .onChange(of: showOnboarding) { newValue in
            if newValue {
                showOnboarding = false
            }
        }
    }
}

struct TabContainerViewSK: View {
    @EnvironmentObject var viewModel: MainViewModelSK
    
    var body: some View {
        ZStack(alignment: .bottom) {
            Group {
                switch viewModel.selectedTab {
                case 0:
                    HomeViewSK()
                case 1:
                    JournalViewSK()
                case 2:
                    SearchViewSK()
                case 3:
                    FavoritesViewSK()
                case 4:
                    StatViewSK()
                default:
                    HomeViewSK()
                }
            }
            
            CustomTabBarSK(selectedTab: $viewModel.selectedTab, theme: viewModel.selectedTheme)
        }
        .ignoresSafeArea(.keyboard)
    }
}

#Preview {
    MainViewSK()
        .environmentObject(MainViewModelSK())
}
