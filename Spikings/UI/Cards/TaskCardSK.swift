import SwiftUI

struct TaskCardSK: View {
    let task: TaskModelSK
    let progress: Int
    let isFavorite: Bool
    var theme: ThemeModelSK = .desertSands
    
    var progressPercentage: Double {
        Double(progress) / 6.0
    }
    
    var difficultyColor: Color {
        switch task.difficulty.lowercased() {
        case "easy": return .green
        case "medium": return .orange
        case "hard": return .red
        default: return .gray
        }
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            ZStack(alignment: .topTrailing) {
                if let uiImage = UIImage(named: task.coverImage) {
                    Image(uiImage: uiImage)
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(height: 160)
                        .clipped()
                } else {
                    Rectangle()
                        .fill(
                            LinearGradient(
                                gradient: Gradient(colors: [theme.accentColor.opacity(0.4), theme.accentColor.opacity(0.2)]),
                                startPoint: .topLeading,
                                endPoint: .bottomTrailing
                            )
                        )
                        .frame(height: 160)
                    
                    Image(systemName: "map")
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
                Text(task.title)
                    .font(.system(size: 18, weight: .bold))
                    .foregroundColor(theme.textColor)
                    .lineLimit(2)
                
                Text(task.subtitle)
                    .font(.system(size: 14, weight: .regular))
                    .foregroundColor(theme.textColor.opacity(0.7))
                    .lineLimit(2)
                
                HStack(spacing: 8) {
                    Text(task.difficulty.capitalized)
                        .font(.system(size: 12, weight: .semibold))
                        .foregroundColor(difficultyColor)
                        .padding(.horizontal, 8)
                        .padding(.vertical, 4)
                        .background(difficultyColor.opacity(0.15))
                        .cornerRadius(6)
                    
                    Spacer()
                    
                    Text("\(progress)/6 steps")
                        .font(.system(size: 12, weight: .medium))
                        .foregroundColor(theme.textColor.opacity(0.6))
                }
                
                GeometryReader { geometry in
                    ZStack(alignment: .leading) {
                        Rectangle()
                            .fill(theme.accentColor.opacity(0.2))
                            .frame(height: 6)
                            .cornerRadius(3)
                        
                        Rectangle()
                            .fill(
                                LinearGradient(
                                    gradient: Gradient(colors: [theme.accentColor, theme.accentColor.opacity(0.7)]),
                                    startPoint: .leading,
                                    endPoint: .trailing
                                )
                            )
                            .frame(width: geometry.size.width * progressPercentage, height: 6)
                            .cornerRadius(3)
                    }
                }
                .frame(height: 6)
            }
            .padding(12)
        }
        .background(theme.cardBackground)
        .cornerRadius(16)
        .shadow(color: .black.opacity(0.1), radius: 8, x: 0, y: 4)
        .navigationBarHidden(true)
    }
}

#Preview {
    TaskCardSK(
        task: TaskModelSK(
            id: "1",
            title: "Build the Pyramid",
            subtitle: "Ancient engineering techniques",
            coverImage: "pyramid",
            difficulty: "medium",
            isPremium: true,
            steps: []
        ),
        progress: 3,
        isFavorite: true
    )
    .padding()
    .background(Color.egyptLightSand)
}
