import SwiftUI

struct TaskDetailViewSK: View {
    @EnvironmentObject var viewModel: MainViewModelSK
    @Environment(\.dismiss) var dismiss
    let task: TaskModelSK
    @State private var isFavorite = false
    @State private var showSteps = false
    
    var progress: Int {
        viewModel.taskProgress(taskId: task.id)
    }
    
    var isCompleted: Bool {
        progress == 6
    }
    
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
                        viewModel.toggleTaskFavorite(task.id)
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
                        if let uiImage = UIImage(named: task.coverImage) {
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
                                            gradient: Gradient(colors: [viewModel.selectedTheme.accentColor.opacity(0.4), viewModel.selectedTheme.accentColor.opacity(0.2)]),
                                            startPoint: .topLeading,
                                            endPoint: .bottomTrailing
                                        )
                                    )
                                    .frame(height: 200)
                                    .cornerRadius(20)
                                
                                Image(systemName: "map")
                                    .font(.system(size: 60))
                                    .foregroundColor(viewModel.selectedTheme.accentColor.opacity(0.3))
                            }
                            .padding(.horizontal, 20)
                        }
                        
                        VStack(alignment: .leading, spacing: 12) {
                            HStack {
                                
                                
                                if isCompleted {
                                    HStack(spacing: 4) {
                                        Image(systemName: "checkmark.seal.fill")
                                            .font(.system(size: 16))
                                        Text("Completed")
                                            .font(.system(size: 14, weight: .bold))
                                    }
                                    .foregroundColor(.green)
                                    .padding(.horizontal, 12)
                                    .padding(.vertical, 6)
                                    .background(Color.green.opacity(0.15))
                                    .cornerRadius(8)
                                }
                            }
                            
                            Text(task.title)
                                .font(.system(size: 28, weight: .bold))
                                .foregroundColor(viewModel.selectedTheme.textColor)
                            
                            Text(task.subtitle)
                                .font(.system(size: 16, weight: .regular))
                                .foregroundColor(viewModel.selectedTheme.textColor.opacity(0.7))
                            
                            HStack(spacing: 16) {
                                Text(task.difficulty.capitalized)
                                    .font(.system(size: 14, weight: .semibold))
                                    .foregroundColor(difficultyColor)
                                    .padding(.horizontal, 12)
                                    .padding(.vertical, 6)
                                    .background(difficultyColor.opacity(0.15))
                                    .cornerRadius(8)
                                
                                HStack(spacing: 4) {
                                    Image(systemName: "list.number")
                                        .font(.system(size: 14))
                                    Text("6 steps")
                                        .font(.system(size: 14, weight: .medium))
                                }
                                .foregroundColor(viewModel.selectedTheme.textColor.opacity(0.6))
                            }
                            
                            VStack(alignment: .leading, spacing: 8) {
                                HStack {
                                    Text("Progress")
                                        .font(.system(size: 16, weight: .semibold))
                                        .foregroundColor(viewModel.selectedTheme.textColor)
                                    
                                    Spacer()
                                    
                                    Text("\(progress)/6")
                                        .font(.system(size: 14, weight: .medium))
                                        .foregroundColor(viewModel.selectedTheme.textColor.opacity(0.6))
                                }
                                
                                GeometryReader { geometry in
                                    ZStack(alignment: .leading) {
                                        Rectangle()
                                            .fill(viewModel.selectedTheme.accentColor.opacity(0.2))
                                            .frame(height: 8)
                                            .cornerRadius(4)
                                        
                                        Rectangle()
                                            .fill(
                                                LinearGradient(
                                                    gradient: Gradient(colors: [viewModel.selectedTheme.accentColor, viewModel.selectedTheme.accentColor.opacity(0.7)]),
                                                    startPoint: .leading,
                                                    endPoint: .trailing
                                                )
                                            )
                                            .frame(width: geometry.size.width * (Double(progress) / 6.0), height: 8)
                                            .cornerRadius(4)
                                    }
                                }
                                .frame(height: 8)
                            }
                        }
                        .padding(.horizontal, 20)
                        
                        VStack(alignment: .leading, spacing: 12) {
                            Text("Quest Steps")
                                .font(.system(size: 22, weight: .bold))
                                .foregroundColor(viewModel.selectedTheme.textColor)
                                .padding(.horizontal, 20)
                            
                            ForEach(task.steps) { step in
                                HStack(alignment: .top, spacing: 12) {
                                    ZStack {
                                        Circle()
                                            .fill(viewModel.isTaskStepCompleted(taskId: task.id, step: step.step) ? viewModel.selectedTheme.accentColor : viewModel.selectedTheme.cardBackground)
                                            .frame(width: 32, height: 32)
                                        
                                        if viewModel.isTaskStepCompleted(taskId: task.id, step: step.step) {
                                            Image(systemName: "checkmark")
                                                .font(.system(size: 14, weight: .bold))
                                                .foregroundColor(.white)
                                        } else {
                                            Text("\(step.step)")
                                                .font(.system(size: 14, weight: .bold))
                                                .foregroundColor(viewModel.selectedTheme.textColor)
                                        }
                                    }
                                    
                                    VStack(alignment: .leading, spacing: 4) {
                                        Text(step.title)
                                            .font(.system(size: 16, weight: .semibold))
                                            .foregroundColor(viewModel.selectedTheme.textColor)
                                        
                                        Text(step.description)
                                            .font(.system(size: 14, weight: .regular))
                                            .foregroundColor(viewModel.selectedTheme.textColor.opacity(0.7))
                                            .lineLimit(2)
                                    }
                                }
                                .padding(16)
                                .background(viewModel.selectedTheme.cardBackground.opacity(0.7))
                                .cornerRadius(12)
                                .padding(.horizontal, 20)
                            }
                        }
                        
                        if !isCompleted {
                            CustomButtonSK(
                                title: progress > 0 ? "Continue Quest" : "Start Quest",
                                icon: "play.fill",
                                action: {
                                    showSteps = true
                                },
                                theme: viewModel.selectedTheme
                            )
                            .padding(.horizontal, 20)
                            .padding(.top, 8)
                        }
                        
                        Spacer(minLength: 40)
                    }
                }
            }
        }
        .onAppear {
            isFavorite = viewModel.isTaskFavorite(task.id)
        }
        .fullScreenCover(isPresented: $showSteps) {
            TaskStepViewSK(task: task, currentStep: progress > 0 ? progress : 0)
                .environmentObject(viewModel)
        }
        .onChange(of: showSteps) { newValue in
            if !newValue && isCompleted {
                dismiss()
            }
        }
        .navigationBarHidden(true)
    }
    
    var difficultyColor: Color {
        switch task.difficulty.lowercased() {
        case "easy": return .green
        case "medium": return .orange
        case "hard": return .red
        default: return .gray
        }
    }
}

#Preview {
    TaskDetailViewSK(
        task: TaskModelSK(
            id: "1",
            title: "Build the Pyramid",
            subtitle: "Ancient engineering techniques",
            coverImage: "pyramid",
            difficulty: "medium",
            isPremium: false,
            steps: [
                TaskStepModelSK(id: "1", step: 1, title: "Choose Location", description: "Select the perfect site for your pyramid"),
                TaskStepModelSK(id: "2", step: 2, title: "Gather Materials", description: "Collect limestone blocks from quarries")
            ]
        )
    )
    .environmentObject(MainViewModelSK())
}
