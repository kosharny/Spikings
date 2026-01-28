import SwiftUI

struct ArticlesViewSK: View {
    @EnvironmentObject var viewModel: MainViewModelSK
    @Environment(\.dismiss) var dismiss
    @State private var selectedTag: String?
    
    var allTags: [String] {
        var tags = Set<String>()
        viewModel.articles.forEach { article in
            article.tags.forEach { tags.insert($0) }
        }
        return Array(tags).sorted()
    }
    
    var filteredArticles: [ArticleModelSK] {
        if let tag = selectedTag {
            return viewModel.articles.filter { $0.tags.contains(tag) }
        }
        return viewModel.articles
    }
    
    var body: some View {
        ZStack {
            GradientBackgroundSK(colors: viewModel.selectedTheme.primaryGradient)
            
            VStack(spacing: 0) {
                CustomHeaderSK(
                    title: "Articles",
                    subtitle: "\(viewModel.articles.count) articles available",
                    showBackButton: true,
                    onBack: { dismiss() },
                    theme: viewModel.selectedTheme
                )
                
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 12) {
                        Button(action: {
                            selectedTag = nil
                        }) {
                            Text("All")
                                .font(.system(size: 14, weight: .semibold))
                                .foregroundColor(selectedTag == nil ? .white : viewModel.selectedTheme.accentColor)
                                .padding(.horizontal, 16)
                                .padding(.vertical, 8)
                                .background(selectedTag == nil ? viewModel.selectedTheme.accentColor : viewModel.selectedTheme.cardBackground)
                                .cornerRadius(20)
                        }
                        
                        ForEach(allTags.prefix(10), id: \.self) { tag in
                            Button(action: {
                                selectedTag = tag
                            }) {
                                Text(tag.capitalized)
                                    .font(.system(size: 14, weight: .semibold))
                                    .foregroundColor(selectedTag == tag ? .white : viewModel.selectedTheme.accentColor)
                                    .padding(.horizontal, 16)
                                    .padding(.vertical, 8)
                                    .background(selectedTag == tag ? viewModel.selectedTheme.accentColor : viewModel.selectedTheme.cardBackground)
                                    .cornerRadius(20)
                            }
                        }
                    }
                    .padding(.horizontal, 20)
                }
                .padding(.vertical, 12)
                
                ScrollView {
                    LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 16) {
                        ForEach(filteredArticles) { article in
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
            }
        }
        .navigationBarHidden(true)
    }
}

#Preview {
    ArticlesViewSK()
        .environmentObject(MainViewModelSK())
}
