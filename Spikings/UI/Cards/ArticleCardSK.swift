import SwiftUI

struct ArticleCardSK: View {
    let article: ArticleModelSK
    let isRead: Bool
    let isFavorite: Bool
    var theme: ThemeModelSK = .desertSands
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            ZStack(alignment: .topTrailing) {
                if let uiImage = UIImage(named: article.coverImage) {
                    Image(uiImage: uiImage)
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(height: 160)
                        .clipped()
                } else {
                    Rectangle()
                        .fill(
                            LinearGradient(
                                gradient: Gradient(colors: [theme.accentColor.opacity(0.3), theme.accentColor.opacity(0.1)]),
                                startPoint: .topLeading,
                                endPoint: .bottomTrailing
                            )
                        )
                        .frame(height: 160)
                    
                    Image(systemName: "photo")
                        .font(.system(size: 48))
                        .foregroundColor(theme.accentColor.opacity(0.3))
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                }
                
                VStack(spacing: 8) {
                    
                    if isFavorite {
                        Image(systemName: "heart.fill")
                            .font(.system(size: 16, weight: .bold))
                            .foregroundColor(theme.accentColor)
                            .padding(8)
                            .background(Circle().fill(Color.white))
                            .shadow(radius: 4)
                    }
                }
                .padding(12)
            }
            
            VStack(alignment: .leading, spacing: 8) {
                Text(article.title)
                    .font(.system(size: 18, weight: .bold))
                    .foregroundColor(theme.textColor)
                    .lineLimit(2)
                
                Text(article.subtitle)
                    .font(.system(size: 14, weight: .regular))
                    .foregroundColor(theme.textColor.opacity(0.7))
                    .lineLimit(2)
                
                HStack {
                    HStack(spacing: 4) {
                        Image(systemName: "clock")
                            .font(.system(size: 12))
                        Text("\(article.estimatedReadTime) min")
                            .font(.system(size: 12, weight: .medium))
                    }
                    
                    Spacer()
                    
                    if isRead {
                        HStack(spacing: 4) {
                            Image(systemName: "checkmark.circle.fill")
                                .font(.system(size: 12))
                            Text("Read")
                                .font(.system(size: 12, weight: .medium))
                        }
                        .foregroundColor(.green)
                    }
                }
                .foregroundColor(theme.textColor.opacity(0.6))
                
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 6) {
                        ForEach(article.tags.prefix(3), id: \.self) { tag in
                            Text(tag)
                                .font(.system(size: 11, weight: .medium))
                                .foregroundColor(theme.accentColor)
                                .padding(.horizontal, 8)
                                .padding(.vertical, 4)
                                .background(theme.accentColor.opacity(0.15))
                                .cornerRadius(6)
                        }
                    }
                }
            }
            .padding(12)
        }
        .background(theme.cardBackground)
        .cornerRadius(16)
        .shadow(color: .black.opacity(0.1), radius: 8, x: 0, y: 4)
    }
}

#Preview {
    ArticleCardSK(
        article: ArticleModelSK(
            id: "1",
            title: "Secrets of the Great Pyramid",
            subtitle: "What we know and what we assume",
            coverImage: "pyramid",
            estimatedReadTime: 12,
            sections: [],
            tags: ["pyramids", "theories", "ancient"],
            isPremium: true
        ),
        isRead: false,
        isFavorite: true
    )
    .padding()
    .background(Color.egyptLightSand)
}
