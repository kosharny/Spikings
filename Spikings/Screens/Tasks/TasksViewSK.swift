import SwiftUI

struct TasksViewSK: View {
    @EnvironmentObject var viewModel: MainViewModelSK
    @Environment(\.dismiss) var dismiss
    @State private var selectedDifficulty: String?
    
    let difficulties = ["easy", "medium", "hard"]
    
    var filteredTasks: [TaskModelSK] {
        if let difficulty = selectedDifficulty {
            return viewModel.tasks.filter { $0.difficulty.lowercased() == difficulty }
        }
        return viewModel.tasks
    }
    
    var body: some View {
        ZStack {
            GradientBackgroundSK(colors: viewModel.selectedTheme.primaryGradient)
            
            VStack(spacing: 0) {
                CustomHeaderSK(
                    title: "Quests",
                    subtitle: "\(viewModel.tasks.count) quests available",
                    showBackButton: true,
                    onBack: { dismiss() },
                    theme: viewModel.selectedTheme
                )
                
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 12) {
                        Button(action: {
                            selectedDifficulty = nil
                        }) {
                            Text("All")
                                .font(.system(size: 14, weight: .semibold))
                                .foregroundColor(selectedDifficulty == nil ? .white : viewModel.selectedTheme.accentColor)
                                .padding(.horizontal, 16)
                                .padding(.vertical, 8)
                                .background(selectedDifficulty == nil ? viewModel.selectedTheme.accentColor : viewModel.selectedTheme.cardBackground)
                                .cornerRadius(20)
                        }
                        
                        ForEach(difficulties, id: \.self) { difficulty in
                            Button(action: {
                                selectedDifficulty = difficulty
                            }) {
                                Text(difficulty.capitalized)
                                    .font(.system(size: 14, weight: .semibold))
                                    .foregroundColor(selectedDifficulty == difficulty ? .white : viewModel.selectedTheme.accentColor)
                                    .padding(.horizontal, 16)
                                    .padding(.vertical, 8)
                                    .background(selectedDifficulty == difficulty ? viewModel.selectedTheme.accentColor : viewModel.selectedTheme.cardBackground)
                                    .cornerRadius(20)
                            }
                        }
                    }
                    .padding(.horizontal, 20)
                }
                .padding(.vertical, 12)
                
                ScrollView {
                    LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 16) {
                        ForEach(filteredTasks) { task in
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
        .navigationBarHidden(true)
    }
}

#Preview {
    TasksViewSK()
        .environmentObject(MainViewModelSK())
}
