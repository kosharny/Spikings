import Foundation

struct ArticleModelSK: Codable, Identifiable {
    let id: String
    let title: String
    let subtitle: String
    let coverImage: String
    let estimatedReadTime: Int
    let sections: [ArticleSectionSK]
    let tags: [String]
    let isPremium: Bool
}

struct ArticleSectionSK: Codable, Identifiable {
    let id: String
    let title: String
    let content: String
}
