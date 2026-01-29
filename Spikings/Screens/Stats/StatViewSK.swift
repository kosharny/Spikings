import SwiftUI

struct StatViewSK: View {
    @EnvironmentObject var viewModel: MainViewModelSK
    
    var completionPercentage: Double {
        let totalContent = Double(viewModel.articles.count + viewModel.tasks.count)
        let completedContent = Double(viewModel.totalArticlesRead + viewModel.totalTasksCompleted)
        return totalContent > 0 ? (completedContent / totalContent) * 100 : 0
    }
    
    var body: some View {
        ZStack {
            GradientBackgroundSK(colors: viewModel.selectedTheme.primaryGradient)
            
            ScrollView {
                VStack(alignment: .leading, spacing: 24) {
                    CustomHeaderSK(
                        title: "Statistics",
                        subtitle: "Track your progress",
                        showSettingsButton: true,
                        theme: viewModel.selectedTheme
                    )
                    
                    VStack(spacing: 16) {
                        ZStack {
                            Circle()
                                .stroke(viewModel.selectedTheme.textColor.opacity(0.2), lineWidth: 20)
                                .frame(width: 180, height: 180)
                            
                            Circle()
                                .trim(from: 0, to: completionPercentage / 100)
                                .stroke(
                                    LinearGradient(
                                        gradient: Gradient(colors: [viewModel.selectedTheme.textColor, viewModel.selectedTheme.textColor.opacity(0.7)]),
                                        startPoint: .topLeading,
                                        endPoint: .bottomTrailing
                                    ),
                                    style: StrokeStyle(lineWidth: 20, lineCap: .round)
                                )
                                .frame(width: 180, height: 180)
                                .rotationEffect(.degrees(-90))
                            
                            VStack(spacing: 4) {
                                Text("\(Int(completionPercentage))%")
                                    .font(.system(size: 42, weight: .bold))
                                    .foregroundColor(viewModel.selectedTheme.textColor)
                                
                                Text("Complete")
                                    .font(.system(size: 14, weight: .medium))
                                    .foregroundColor(viewModel.selectedTheme.textColor.opacity(0.7))
                            }
                        }
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 20)
                    }
                    
                    VStack(spacing: 12) {
                        StatCardSK(
                            icon: "book.fill",
                            title: "Articles Read",
                            value: "\(viewModel.totalArticlesRead)",
                            subtitle: "of \(viewModel.articles.count) total",
                            theme: viewModel.selectedTheme
                        )
                        
                        StatCardSK(
                            icon: "checkmark.seal.fill",
                            title: "Quests Completed",
                            value: "\(viewModel.totalTasksCompleted)",
                            subtitle: "of \(viewModel.tasks.count) total",
                            theme: viewModel.selectedTheme
                        )
                        
                        StatCardSK(
                            icon: "clock.fill",
                            title: "Reading Time",
                            value: "\(viewModel.totalReadingTime)",
                            subtitle: "minutes spent learning",
                            theme: viewModel.selectedTheme
                        )
                        
                        StatCardSK(
                            icon: "heart.fill",
                            title: "Favorites",
                            value: "\(viewModel.favoriteArticles.count + viewModel.favoriteTasks.count)",
                            subtitle: "items saved",
                            theme: viewModel.selectedTheme
                        )
                    }
                    .padding(.horizontal, 20)
                    
                    VStack(alignment: .leading, spacing: 12) {
                        Text("Achievements")
                            .font(.system(size: 22, weight: .bold))
                            .foregroundColor(viewModel.selectedTheme.textColor)
                            .padding(.horizontal, 20)
                        
                        VStack(spacing: 12) {
                            AchievementCardSK(
                                icon: "star.fill",
                                title: "First Steps",
                                description: "Read your first article",
                                isUnlocked: viewModel.totalArticlesRead > 0,
                                theme: viewModel.selectedTheme
                            )
                            
                            AchievementCardSK(
                                icon: "flame.fill",
                                title: "Knowledge Seeker",
                                description: "Read 10 articles",
                                isUnlocked: viewModel.totalArticlesRead >= 10,
                                theme: viewModel.selectedTheme
                            )
                            
                            AchievementCardSK(
                                icon: "trophy.fill",
                                title: "Quest Master",
                                description: "Complete 5 quests",
                                isUnlocked: viewModel.totalTasksCompleted >= 5,
                                theme: viewModel.selectedTheme
                            )
                            
                            AchievementCardSK(
                                icon: "crown.fill",
                                title: "Pharaoh Scholar",
                                description: "Complete all content",
                                isUnlocked: completionPercentage == 100,
                                theme: viewModel.selectedTheme
                            )
                        }
                        .padding(.horizontal, 20)
                    }
                    
                    Spacer(minLength: 100)
                }
            }
        }
    }
}

struct StatCardSK: View {
    let icon: String
    let title: String
    let value: String
    let subtitle: String
    var theme: ThemeModelSK
    
    var body: some View {
        HStack(spacing: 16) {
            Image(systemName: icon)
                .font(.system(size: 32, weight: .semibold))
                .foregroundColor(theme.accentColor)
                .frame(width: 60, height: 60)
                .background(theme.accentColor.opacity(0.15))
                .cornerRadius(12)
            
            VStack(alignment: .leading, spacing: 4) {
                Text(title)
                    .font(.system(size: 14, weight: .medium))
                    .foregroundColor(theme.textColor.opacity(0.7))
                
                Text(value)
                    .font(.system(size: 28, weight: .bold))
                    .foregroundColor(theme.textColor)
                
                Text(subtitle)
                    .font(.system(size: 12, weight: .regular))
                    .foregroundColor(theme.textColor.opacity(0.6))
            }
            
            Spacer()
        }
        .padding(16)
        .background(theme.cardBackground)
        .cornerRadius(16)
        .shadow(color: .black.opacity(0.05), radius: 8, x: 0, y: 4)
    }
}

struct AchievementCardSK: View {
    let icon: String
    let title: String
    let description: String
    let isUnlocked: Bool
    var theme: ThemeModelSK
    
    var body: some View {
        HStack(spacing: 16) {
            Image(systemName: icon)
                .font(.system(size: 28, weight: .semibold))
                .foregroundColor(isUnlocked ? theme.accentColor : theme.textColor.opacity(0.3))
                .frame(width: 56, height: 56)
                .background(isUnlocked ? theme.accentColor.opacity(0.15) : theme.textColor.opacity(0.05))
                .cornerRadius(12)
            
            VStack(alignment: .leading, spacing: 4) {
                Text(title)
                    .font(.system(size: 16, weight: .semibold))
                    .foregroundColor(theme.textColor)
                
                Text(description)
                    .font(.system(size: 13, weight: .regular))
                    .foregroundColor(theme.textColor.opacity(0.6))
            }
            
            Spacer()
            
            if isUnlocked {
                Image(systemName: "checkmark.circle.fill")
                    .font(.system(size: 24))
                    .foregroundColor(.green)
            } else {
                Image(systemName: "lock.fill")
                    .font(.system(size: 20))
                    .foregroundColor(theme.textColor.opacity(0.3))
            }
        }
        .padding(16)
        .background(theme.cardBackground)
        .cornerRadius(16)
        .opacity(isUnlocked ? 1.0 : 0.6)
    }
}

#Preview {
    StatViewSK()
        .environmentObject(MainViewModelSK())
}
