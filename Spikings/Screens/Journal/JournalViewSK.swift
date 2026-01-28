import SwiftUI

struct JournalViewSK: View {
    @EnvironmentObject var viewModel: MainViewModelSK
    @State private var selectedSegment = 0
    
    var body: some View {
        ZStack {
            GradientBackgroundSK(colors: viewModel.selectedTheme.primaryGradient)
            
            VStack(spacing: 0) {
                CustomHeaderSK(
                    title: "Journal",
                    subtitle: "Your learning history",
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
                        if viewModel.readArticlesList.isEmpty {
                            VStack(spacing: 16) {
                                Image(systemName: "book.closed")
                                    .font(.system(size: 60))
                                    .foregroundColor(viewModel.selectedTheme.textColor.opacity(0.3))
                                
                                Text("No articles read yet")
                                    .font(.system(size: 18, weight: .semibold))
                                    .foregroundColor(viewModel.selectedTheme.textColor.opacity(0.6))
                                
                                Text("Start exploring to build your knowledge")
                                    .font(.system(size: 14, weight: .regular))
                                    .foregroundColor(viewModel.selectedTheme.textColor.opacity(0.5))
                            }
                            .frame(maxWidth: .infinity)
                            .padding(.top, 100)
                        } else {
                            LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 16) {
                                ForEach(viewModel.readArticlesList) { article in
                                    NavigationLink(destination: ArticleDetailViewSK(article: article).environmentObject(viewModel)) {
                                        ArticleCardSK(
                                            article: article,
                                            isRead: true,
                                            isFavorite: viewModel.isArticleFavorite(article.id),
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
                        if viewModel.completedTasksList.isEmpty {
                            VStack(spacing: 16) {
                                Image(systemName: "map")
                                    .font(.system(size: 60))
                                    .foregroundColor(viewModel.selectedTheme.textColor.opacity(0.3))
                                
                                Text("No quests completed yet")
                                    .font(.system(size: 18, weight: .semibold))
                                    .foregroundColor(viewModel.selectedTheme.textColor.opacity(0.6))
                                
                                Text("Complete your first quest to earn achievements")
                                    .font(.system(size: 14, weight: .regular))
                                    .foregroundColor(viewModel.selectedTheme.textColor.opacity(0.5))
                            }
                            .frame(maxWidth: .infinity)
                            .padding(.top, 100)
                        } else {
                            LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 16) {
                                ForEach(viewModel.completedTasksList) { task in
                                    NavigationLink(destination: TaskDetailViewSK(task: task).environmentObject(viewModel)) {
                                        TaskCardSK(
                                            task: task,
                                            progress: 6,
                                            isFavorite: viewModel.isTaskFavorite(task.id),
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
    JournalViewSK()
        .environmentObject(MainViewModelSK())
}
