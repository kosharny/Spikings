import SwiftUI

struct SearchViewSK: View {
    @EnvironmentObject var viewModel: MainViewModelSK
    @State private var selectedSegment = 0
    @FocusState private var isSearchFocused: Bool
    
    var body: some View {
        ZStack {
            GradientBackgroundSK(colors: viewModel.selectedTheme.primaryGradient)
            
            VStack(spacing: 0) {
                CustomHeaderSK(
                    title: "Search",
                    subtitle: "Find articles and quests",
                    showSettingsButton: true,
                    theme: viewModel.selectedTheme
                )
                
                HStack(spacing: 12) {
                    HStack(spacing: 8) {
                        Image(systemName: "magnifyingglass")
                            .font(.system(size: 16, weight: .medium))
                            .foregroundColor(viewModel.selectedTheme.textColor.opacity(0.5))
                        
                        TextField("Search...", text: $viewModel.searchQuery)
                            .font(.system(size: 16, weight: .regular))
                            .foregroundColor(viewModel.selectedTheme.textColor)
                            .focused($isSearchFocused)
                    }
                    .padding(.horizontal, 16)
                    .padding(.vertical, 12)
                    .background(viewModel.selectedTheme.cardBackground)
                    .cornerRadius(12)
                    
                    if !viewModel.searchQuery.isEmpty {
                        Button(action: {
                            viewModel.searchQuery = ""
                        }) {
                            Image(systemName: "xmark.circle.fill")
                                .font(.system(size: 20))
                                .foregroundColor(viewModel.selectedTheme.textColor.opacity(0.5))
                        }
                    }
                }
                .padding(.horizontal, 20)
                .padding(.vertical, 12)
                
                Picker("", selection: $selectedSegment) {
                    Text("Articles").tag(0)
                    Text("Quests").tag(1)
                }
                .pickerStyle(.segmented)
                .padding(.horizontal, 20)
                .padding(.bottom, 12)
                
                ScrollView {
                    if selectedSegment == 0 {
                        if viewModel.filteredArticles.isEmpty {
                            VStack(spacing: 16) {
                                Image(systemName: viewModel.searchQuery.isEmpty ? "magnifyingglass" : "doc.text.magnifyingglass")
                                    .font(.system(size: 60))
                                    .foregroundColor(viewModel.selectedTheme.textColor.opacity(0.3))
                                
                                Text(viewModel.searchQuery.isEmpty ? "Start searching" : "No articles found")
                                    .font(.system(size: 18, weight: .semibold))
                                    .foregroundColor(viewModel.selectedTheme.textColor.opacity(0.6))
                                
                                Text(viewModel.searchQuery.isEmpty ? "Enter a search term to find articles" : "Try different keywords")
                                    .font(.system(size: 14, weight: .regular))
                                    .foregroundColor(viewModel.selectedTheme.textColor.opacity(0.5))
                            }
                            .frame(maxWidth: .infinity)
                            .padding(.top, 100)
                        } else {
                            LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 16) {
                                ForEach(viewModel.filteredArticles) { article in
                                    NavigationLink(destination: ArticleDetailViewSK(article: article).environmentObject(viewModel)) {
                                        ArticleCardSK(
                                            article: article,
                                            isRead: viewModel.readArticles.contains(article.id),
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
                        if viewModel.filteredTasks.isEmpty {
                            VStack(spacing: 16) {
                                Image(systemName: viewModel.searchQuery.isEmpty ? "magnifyingglass" : "map.fill")
                                    .font(.system(size: 60))
                                    .foregroundColor(viewModel.selectedTheme.textColor.opacity(0.3))
                                
                                Text(viewModel.searchQuery.isEmpty ? "Start searching" : "No quests found")
                                    .font(.system(size: 18, weight: .semibold))
                                    .foregroundColor(viewModel.selectedTheme.textColor.opacity(0.6))
                                
                                Text(viewModel.searchQuery.isEmpty ? "Enter a search term to find quests" : "Try different keywords")
                                    .font(.system(size: 14, weight: .regular))
                                    .foregroundColor(viewModel.selectedTheme.textColor.opacity(0.5))
                            }
                            .frame(maxWidth: .infinity)
                            .padding(.top, 100)
                        } else {
                            LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 16) {
                                ForEach(viewModel.filteredTasks) { task in
                                    NavigationLink(destination: TaskDetailViewSK(task: task).environmentObject(viewModel)) {
                                        TaskCardSK(
                                            task: task,
                                            progress: viewModel.taskProgress(taskId: task.id),
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
    SearchViewSK()
        .environmentObject(MainViewModelSK())
}
