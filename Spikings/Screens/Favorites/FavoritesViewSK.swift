import SwiftUI

struct FavoritesViewSK: View {
    @EnvironmentObject var viewModel: MainViewModelSK
    @State private var selectedSegment = 0
    
    var body: some View {
        ZStack {
            GradientBackgroundSK(colors: viewModel.selectedTheme.primaryGradient)
            
            VStack(spacing: 0) {
                CustomHeaderSK(
                    title: "Favorites",
                    subtitle: "Your saved content",
                    showSettingsButton: true,
                    theme: viewModel.selectedTheme
                )
                
                Picker("", selection: $selectedSegment) {
                    Text("Articles").tag(0)
                    Text("Quests").tag(1)
                }
                .pickerStyle(.segmented)
                .padding(.horizontal, 20)
                .padding(.vertical, 12)
                
                ScrollView {
                    if selectedSegment == 0 {
                        if viewModel.favoriteArticlesList.isEmpty {
                            VStack(spacing: 16) {
                                Image(systemName: "heart")
                                    .font(.system(size: 60))
                                    .foregroundColor(viewModel.selectedTheme.textColor.opacity(0.3))
                                
                                Text("No favorite articles")
                                    .font(.system(size: 18, weight: .semibold))
                                    .foregroundColor(viewModel.selectedTheme.textColor.opacity(0.6))
                                
                                Text("Tap the heart icon to save articles")
                                    .font(.system(size: 14, weight: .regular))
                                    .foregroundColor(viewModel.selectedTheme.textColor.opacity(0.5))
                            }
                            .frame(maxWidth: .infinity)
                            .padding(.top, 100)
                        } else {
                            LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 16) {
                                ForEach(viewModel.favoriteArticlesList) { article in
                                    NavigationLink(destination: ArticleDetailViewSK(article: article).environmentObject(viewModel)) {
                                        ArticleCardSK(
                                            article: article,
                                            isRead: viewModel.readArticles.contains(article.id),
                                            isFavorite: true,
                                            theme: viewModel.selectedTheme
                                        )
                                        .frame(height: 280)
                                    }
                                }
                            }
                            .padding(.horizontal, 20)
                            .padding(.bottom, 100)
                        }
                    } else {
                        if viewModel.favoriteTasksList.isEmpty {
                            VStack(spacing: 16) {
                                Image(systemName: "heart")
                                    .font(.system(size: 60))
                                    .foregroundColor(viewModel.selectedTheme.textColor.opacity(0.3))
                                
                                Text("No favorite quests")
                                    .font(.system(size: 18, weight: .semibold))
                                    .foregroundColor(viewModel.selectedTheme.textColor.opacity(0.6))
                                
                                Text("Tap the heart icon to save quests")
                                    .font(.system(size: 14, weight: .regular))
                                    .foregroundColor(viewModel.selectedTheme.textColor.opacity(0.5))
                            }
                            .frame(maxWidth: .infinity)
                            .padding(.top, 100)
                        } else {
                            LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 16) {
                                ForEach(viewModel.favoriteTasksList) { task in
                                    NavigationLink(destination: TaskDetailViewSK(task: task).environmentObject(viewModel)) {
                                        TaskCardSK(
                                            task: task,
                                            progress: viewModel.taskProgress(taskId: task.id),
                                            isFavorite: true,
                                            theme: viewModel.selectedTheme
                                        )
                                        .frame(height: 280)
                                    }
                                }
                            }
                            .padding(.horizontal, 20)
                            .padding(.bottom, 100)
                        }
                    }
                }
            }
        }
        .navigationBarHidden(true)
    }
}

#Preview {
    FavoritesViewSK()
        .environmentObject(MainViewModelSK())
}
