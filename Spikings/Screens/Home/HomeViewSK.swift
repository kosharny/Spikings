import SwiftUI

struct HomeViewSK: View {
    @EnvironmentObject var viewModel: MainViewModelSK

    
    var featuredArticles: [ArticleModelSK] {
        Array(viewModel.articles.prefix(3))
    }
    
    var featuredTasks: [TaskModelSK] {
        Array(viewModel.tasks.prefix(3))
    }
    
    var body: some View {
        ZStack {
            GradientBackgroundSK(colors: viewModel.selectedTheme.primaryGradient)
            
            ScrollView {
                VStack(alignment: .leading, spacing: 24) {
                    VStack(alignment: .leading, spacing: 8) {
                        HStack {
                            VStack(alignment: .leading, spacing: 8) {
                                Text("SPIKINGS")
                                    .font(.system(size: 40, weight: .black))
                                    .foregroundColor(viewModel.selectedTheme.textColor)
                                
                                Text("Explore Ancient Egypt")
                                    .font(.system(size: 18, weight: .medium))
                                    .foregroundColor(viewModel.selectedTheme.textColor.opacity(0.7))
                            }
                            
                            Spacer()
                            
                            NavigationLink(destination: SettingsViewSK().environmentObject(viewModel)) {
                                Image(systemName: "gearshape.fill")
                                    .font(.system(size: 24, weight: .semibold))
                                    .foregroundColor(viewModel.selectedTheme.accentColor)
                                    .padding(12)
                                    .background(viewModel.selectedTheme.cardBackground)
                                    .clipShape(Circle())
                            }
                        }
                    }
                    .padding(.horizontal, 20)
                    .padding(.top, 20)
                    
                    VStack(alignment: .leading, spacing: 12) {
                        HStack {
                            Text("Featured Articles")
                                .font(.system(size: 24, weight: .bold))
                                .foregroundColor(viewModel.selectedTheme.textColor)
                            
                            Spacer()
                            
                            NavigationLink(destination: ArticlesViewSK().environmentObject(viewModel)) {
                                Text("See All")
                                    .font(.system(size: 14, weight: .semibold))
                                    .foregroundColor(viewModel.selectedTheme.textColor)
                            }
                        }
                        .padding(.horizontal, 20)
                        
                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack(spacing: 16) {
                                ForEach(featuredArticles) { article in
                                    NavigationLink(destination: ArticleDetailViewSK(article: article).environmentObject(viewModel)) {
                                        ArticleCardSK(
                                            article: article,
                                            isRead: viewModel.readArticles.contains(article.id),
                                            isFavorite: viewModel.isArticleFavorite(article.id),
                                            theme: viewModel.selectedTheme
                                        )
                                        .frame(width: 280)
                                    }
                                }
                            }
                            .padding(.horizontal, 20)
                        }
                    }
                    
                    VStack(alignment: .leading, spacing: 12) {
                        HStack {
                            Text("Available Quests")
                                .font(.system(size: 24, weight: .bold))
                                .foregroundColor(viewModel.selectedTheme.textColor)
                            
                            Spacer()
                            
                            NavigationLink(destination: TasksViewSK().environmentObject(viewModel)) {
                                Text("See All")
                                    .font(.system(size: 14, weight: .semibold))
                                    .foregroundColor(viewModel.selectedTheme.textColor)
                            }
                        }
                        .padding(.horizontal, 20)
                        
                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack(spacing: 16) {
                                ForEach(featuredTasks) { task in
                                    NavigationLink(destination: TaskDetailViewSK(task: task).environmentObject(viewModel)) {
                                        TaskCardSK(
                                            task: task,
                                            progress: viewModel.taskProgress(taskId: task.id),
                                            isFavorite: viewModel.isTaskFavorite(task.id),
                                            theme: viewModel.selectedTheme
                                        )
                                        .frame(width: 280)
                                    }
                                }
                            }
                            .padding(.horizontal, 20)
                        }
                    }
                    
                    VStack(alignment: .leading, spacing: 12) {
                        Text("Explore More")
                            .font(.system(size: 24, weight: .bold))
                            .foregroundColor(viewModel.selectedTheme.textColor)
                            .padding(.horizontal, 20)
                        
                        HStack(spacing: 12) {
                            NavigationLink(destination: PharaohTimelineViewSK().environmentObject(viewModel)) {
                                VStack(spacing: 8) {
                                    Image(systemName: "crown.fill")
                                        .font(.system(size: 32))
                                        .foregroundColor(viewModel.selectedTheme.accentColor)
                                    Text("Pharaoh Timeline")
                                        .font(.system(size: 13, weight: .semibold))
                                        .foregroundColor(viewModel.selectedTheme.textColor)
                                        .multilineTextAlignment(.center)
                                }
                                .frame(maxWidth: .infinity)
                                .padding(.vertical, 20)
                                .background(viewModel.selectedTheme.cardBackground)
                                .cornerRadius(12)
                            }
                            
                            NavigationLink(destination: PyramidExplorerViewSK().environmentObject(viewModel)) {
                                VStack(spacing: 8) {
                                    Image(systemName: "triangle.fill")
                                        .font(.system(size: 32))
                                        .foregroundColor(viewModel.selectedTheme.accentColor)
                                    Text("Pyramid Explorer")
                                        .font(.system(size: 13, weight: .semibold))
                                        .foregroundColor(viewModel.selectedTheme.textColor)
                                        .multilineTextAlignment(.center)
                                }
                                .frame(maxWidth: .infinity)
                                .padding(.vertical, 20)
                                .background(viewModel.selectedTheme.cardBackground)
                                .cornerRadius(12)
                            }
                        }
                        .padding(.horizontal, 20)
                    }
                    
                    VStack(alignment: .leading, spacing: 16) {
                        Text("Your Progress")
                            .font(.system(size: 24, weight: .bold))
                            .foregroundColor(viewModel.selectedTheme.textColor)
                            .padding(.horizontal, 20)
                        
                        HStack(spacing: 16) {
                            VStack(spacing: 8) {
                                Text("\(viewModel.totalArticlesRead)")
                                    .font(.system(size: 32, weight: .bold))
                                    .foregroundColor(viewModel.selectedTheme.accentColor)
                                Text("Articles Read")
                                    .font(.system(size: 12, weight: .medium))
                                    .foregroundColor(viewModel.selectedTheme.textColor.opacity(0.7))
                            }
                            .frame(maxWidth: .infinity)
                            .padding(.vertical, 20)
                            .background(viewModel.selectedTheme.cardBackground)
                            .cornerRadius(12)
                            
                            VStack(spacing: 8) {
                                Text("\(viewModel.totalTasksCompleted)")
                                    .font(.system(size: 32, weight: .bold))
                                    .foregroundColor(viewModel.selectedTheme.accentColor)
                                Text("Quests Done")
                                    .font(.system(size: 12, weight: .medium))
                                    .foregroundColor(viewModel.selectedTheme.textColor.opacity(0.7))
                            }
                            .frame(maxWidth: .infinity)
                            .padding(.vertical, 20)
                            .background(viewModel.selectedTheme.cardBackground)
                            .cornerRadius(12)
                        }
                        .padding(.horizontal, 20)
                    }
                    
                    Spacer(minLength: 100)
                }
            }
        }
        .navigationBarHidden(true)
    }
}

#Preview {
    HomeViewSK()
        .environmentObject(MainViewModelSK())
}
