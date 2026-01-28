import Foundation

struct TaskModelSK: Codable, Identifiable {
    let id: String
    let title: String
    let subtitle: String
    let coverImage: String
    let difficulty: String
    let isPremium: Bool
    let steps: [TaskStepModelSK]
}

struct TaskStepModelSK: Codable, Identifiable {
    let id: String
    let step: Int
    let title: String
    let description: String
}
