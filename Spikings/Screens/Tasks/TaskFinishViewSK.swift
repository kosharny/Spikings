import SwiftUI

struct TaskFinishViewSK: View {
    @EnvironmentObject var viewModel: MainViewModelSK
    @Environment(\.dismiss) var dismiss
    let task: TaskModelSK
    @State private var scale: CGFloat = 0.5
    @State private var opacity: Double = 0
    
    var body: some View {
        ZStack {
            GradientBackgroundSK(colors: viewModel.selectedTheme.primaryGradient)
            
            VStack(spacing: 32) {
                Spacer()
                
                Image(systemName: "checkmark.seal.fill")
                    .font(.system(size: 100, weight: .bold))
                    .foregroundColor(.green)
                    .scaleEffect(scale)
                    .opacity(opacity)
                
                VStack(spacing: 16) {
                    Text("Quest Completed!")
                        .font(.system(size: 36, weight: .bold))
                        .foregroundColor(viewModel.selectedTheme.textColor)
                        .opacity(opacity)
                    
                    Text(task.title)
                        .font(.system(size: 20, weight: .semibold))
                        .foregroundColor(viewModel.selectedTheme.textColor.opacity(0.8))
                        .opacity(opacity)
                    
                    Text("You've successfully completed all 6 steps and mastered this ancient knowledge.")
                        .font(.system(size: 16, weight: .regular))
                        .foregroundColor(viewModel.selectedTheme.textColor.opacity(0.7))
                        .multilineTextAlignment(.center)
                        .padding(.horizontal, 40)
                        .opacity(opacity)
                }
                
                VStack(spacing: 16) {
                    HStack(spacing: 20) {
                        VStack(spacing: 8) {
                            Image(systemName: "star.fill")
                                .font(.system(size: 32))
                                .foregroundColor(viewModel.selectedTheme.accentColor)
                            Text("6/6 Steps")
                                .font(.system(size: 14, weight: .semibold))
                                .foregroundColor(viewModel.selectedTheme.textColor)
                        }
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 20)
                        .background(viewModel.selectedTheme.cardBackground.opacity(0.7))
                        .cornerRadius(12)
                        
                        VStack(spacing: 8) {
                            Image(systemName: "trophy.fill")
                                .font(.system(size: 32))
                                .foregroundColor(viewModel.selectedTheme.accentColor)
                            Text("Achievement")
                                .font(.system(size: 14, weight: .semibold))
                                .foregroundColor(viewModel.selectedTheme.textColor)
                        }
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 20)
                        .background(viewModel.selectedTheme.cardBackground.opacity(0.7))
                        .cornerRadius(12)
                    }
                    .padding(.horizontal, 40)
                }
                .opacity(opacity)
                
                Spacer()
                
                CustomButtonSK(
                    title: "Continue Exploring",
                    icon: "arrow.right",
                    action: {
                        viewModel.selectedTab = 0
                        dismiss()
                    },
                    theme: viewModel.selectedTheme
                )
                .padding(.horizontal, 40)
                .opacity(opacity)
                
                Spacer()
            }
        }
        .onAppear {
            withAnimation(.spring(response: 0.6, dampingFraction: 0.6)) {
                scale = 1.0
            }
            withAnimation(.easeOut(duration: 0.5)) {
                opacity = 1.0
            }
        }
        .navigationBarHidden(true)
    }
}

#Preview {
    TaskFinishViewSK(
        task: TaskModelSK(
            id: "1",
            title: "Build the Pyramid",
            subtitle: "Ancient engineering",
            coverImage: "pyramid",
            difficulty: "medium",
            isPremium: false,
            steps: []
        )
    )
    .environmentObject(MainViewModelSK())
}
