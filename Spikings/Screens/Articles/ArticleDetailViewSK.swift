import SwiftUI

struct ArticleDetailViewSK: View {
    @EnvironmentObject var viewModel: MainViewModelSK
    @Environment(\.dismiss) var dismiss
    let article: ArticleModelSK
    @State private var isFavorite = false
    
    var body: some View {
        ZStack {
            GradientBackgroundSK(colors: viewModel.selectedTheme.primaryGradient)
            
            VStack(spacing: 0) {
                HStack {
                    Button(action: { dismiss() }) {
                        Image(systemName: "chevron.left")
                            .font(.system(size: 18, weight: .semibold))
                            .foregroundColor(viewModel.selectedTheme.textColor)
                            .padding(12)
                            .background(viewModel.selectedTheme.cardBackground)
                            .clipShape(Circle())
                    }
                    
                    Spacer()
                    
                    Button(action: {
                        viewModel.toggleArticleFavorite(article.id)
                        isFavorite.toggle()
                    }) {
                        Image(systemName: isFavorite ? "heart.fill" : "heart")
                            .font(.system(size: 18, weight: .semibold))
                            .foregroundColor(isFavorite ? viewModel.selectedTheme.accentColor : viewModel.selectedTheme.textColor)
                            .padding(12)
                            .background(viewModel.selectedTheme.cardBackground)
                            .clipShape(Circle())
                    }
                }
                .padding(.horizontal, 20)
                .padding(.top, 20)
                
                ScrollView {
                    VStack(alignment: .leading, spacing: 20) {
                        if let uiImage = UIImage(named: article.coverImage) {
                            Image(uiImage: uiImage)
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(height: 200)
                                .cornerRadius(20)
                                .clipped()
                                .padding(.horizontal, 20)
                        } else {
                            ZStack {
                                Rectangle()
                                    .fill(
                                        LinearGradient(
                                            gradient: Gradient(colors: [viewModel.selectedTheme.accentColor.opacity(0.3), viewModel.selectedTheme.accentColor.opacity(0.1)]),
                                            startPoint: .topLeading,
                                            endPoint: .bottomTrailing
                                        )
                                    )
                                    .frame(height: 200)
                                    .cornerRadius(20)
                                
                                Image(systemName: "photo")
                                    .font(.system(size: 60))
                                    .foregroundColor(viewModel.selectedTheme.accentColor.opacity(0.3))
                            }
                            .padding(.horizontal, 20)
                        }
                        
                        VStack(alignment: .leading, spacing: 12) {
                            
                            Text(article.title)
                                .font(.system(size: 28, weight: .bold))
                                .foregroundColor(viewModel.selectedTheme.textColor)
                            
                            Text(article.subtitle)
                                .font(.system(size: 16, weight: .regular))
                                .foregroundColor(viewModel.selectedTheme.textColor.opacity(0.7))
                            
                            HStack(spacing: 16) {
                                HStack(spacing: 4) {
                                    Image(systemName: "clock")
                                        .font(.system(size: 14))
                                    Text("\(article.estimatedReadTime) min read")
                                        .font(.system(size: 14, weight: .medium))
                                }
                                
                                HStack(spacing: 4) {
                                    Image(systemName: "doc.text")
                                        .font(.system(size: 14))
                                    Text("\(article.sections.count) sections")
                                        .font(.system(size: 14, weight: .medium))
                                }
                            }
                            .foregroundColor(viewModel.selectedTheme.textColor.opacity(0.6))
                            
                            ScrollView(.horizontal, showsIndicators: false) {
                                HStack(spacing: 8) {
                                    ForEach(article.tags, id: \.self) { tag in
                                        Text(tag)
                                            .font(.system(size: 12, weight: .medium))
                                            .foregroundColor(viewModel.selectedTheme.textColor)
                                            .padding(.horizontal, 12)
                                            .padding(.vertical, 6)
                                            .background(viewModel.selectedTheme.accentColor)
                                            .cornerRadius(8)
                                    }
                                }
                            }
                        }
                        .padding(20)
                        .background(viewModel.selectedTheme.cardBackground.opacity(0.7))
                        .cornerRadius(16)
                        .padding(.horizontal, 20)
                        
                        VStack(alignment: .leading, spacing: 24) {
                            ForEach(article.sections) { section in
                                VStack(alignment: .leading, spacing: 12) {
                                    Text(section.title)
                                        .font(.system(size: 22, weight: .bold))
                                        .foregroundColor(viewModel.selectedTheme.textColor)
                                    
                                    Text(section.content)
                                        .font(.system(size: 16, weight: .regular))
                                        .foregroundColor(viewModel.selectedTheme.textColor.opacity(0.8))
                                        .lineSpacing(6)
                                }
                                .padding(20)
                                .background(viewModel.selectedTheme.cardBackground.opacity(0.7))
                                .cornerRadius(16)
                            }
                        }
                        .padding(.horizontal, 20)
                        .padding(.bottom, 40)
                    }
                }
            }
        }
        .navigationBarHidden(true)
        .onAppear {
            isFavorite = viewModel.isArticleFavorite(article.id)
            viewModel.markArticleAsRead(article.id)
        }
    }
}

#Preview {
    ArticleDetailViewSK(
        article: ArticleModelSK(
            id: "1",
            title: "Secrets of the Great Pyramid",
            subtitle: "What we know and what we assume",
            coverImage: "pyramid",
            estimatedReadTime: 12,
            sections: [
                ArticleSectionSK(id: "1", title: "Introduction", content: "The Great Pyramid of Giza stands as one of humanity's most remarkable achievements..."),
                ArticleSectionSK(id: "2", title: "Construction Theories", content: "Various theories have been proposed about how the ancient Egyptians built this massive structure...")
            ],
            tags: ["pyramids", "theories"],
            isPremium: true
        )
    )
    .environmentObject(MainViewModelSK())
}
