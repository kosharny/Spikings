import SwiftUI

struct TaskStepViewSK: View {
    @EnvironmentObject var viewModel: MainViewModelSK
    @Environment(\.dismiss) var dismiss
    let task: TaskModelSK
    @State var currentStep: Int
    @State private var showFinish = false
    
    var currentStepData: TaskStepModelSK? {
        task.steps.first { $0.step == currentStep + 1 }
    }
    
    var isLastStep: Bool {
        currentStep == 5
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
                    
                    Text("Step \(currentStep + 1) of 6")
                        .font(.system(size: 16, weight: .semibold))
                        .foregroundColor(viewModel.selectedTheme.textColor)
                    
                    Spacer()
                    
                    Circle()
                        .fill(Color.clear)
                        .frame(width: 42, height: 42)
                }
                .padding(.horizontal, 20)
                .padding(.top, 20)
                
                GeometryReader { geometry in
                    ZStack(alignment: .leading) {
                        Rectangle()
                            .fill(viewModel.selectedTheme.accentColor.opacity(0.2))
                            .frame(height: 6)
                        
                        Rectangle()
                            .fill(
                                LinearGradient(
                                    gradient: Gradient(colors: [viewModel.selectedTheme.accentColor, viewModel.selectedTheme.accentColor.opacity(0.7)]),
                                    startPoint: .leading,
                                    endPoint: .trailing
                                )
                            )
                            .frame(width: geometry.size.width * (Double(currentStep + 1) / 6.0), height: 6)
                    }
                }
                .frame(height: 6)
                .padding(.horizontal, 20)
                .padding(.top, 16)
                
                if let stepData = currentStepData {
                    ScrollView {
                        VStack(alignment: .leading, spacing: 24) {
                            VStack(alignment: .leading, spacing: 12) {
                                ZStack {
                                    Circle()
                                        .fill(viewModel.selectedTheme.accentColor.opacity(0.2))
                                        .frame(width: 80, height: 80)
                                    
                                    Text("\(stepData.step)")
                                        .font(.system(size: 40, weight: .bold))
                                        .foregroundColor(viewModel.selectedTheme.accentColor)
                                }
                                
                                Text(stepData.title)
                                    .font(.system(size: 28, weight: .bold))
                                    .foregroundColor(viewModel.selectedTheme.textColor)
                                
                                Text(task.title)
                                    .font(.system(size: 16, weight: .medium))
                                    .foregroundColor(viewModel.selectedTheme.textColor.opacity(0.6))
                            }
                            .padding(.top, 32)
                            
                            VStack(alignment: .leading, spacing: 16) {
                                Text("Description")
                                    .font(.system(size: 20, weight: .bold))
                                    .foregroundColor(viewModel.selectedTheme.textColor)
                                
                                Text(stepData.description)
                                    .font(.system(size: 16, weight: .regular))
                                    .foregroundColor(viewModel.selectedTheme.textColor.opacity(0.8))
                                    .lineSpacing(6)
                            }
                            .padding(20)
                            .background(viewModel.selectedTheme.cardBackground.opacity(0.7))
                            .cornerRadius(16)
                            
                            HStack(spacing: 12) {
                                if currentStep > 0 {
                                    CustomButtonSK(
                                        title: "Previous Step",
                                        icon: "arrow.left",
                                        action: {
                                            withAnimation {
                                                currentStep -= 1
                                            }
                                        },
                                        isPrimary: false,
                                        theme: viewModel.selectedTheme
                                    )
                                }
                                
                                if !isLastStep {
                                    CustomButtonSK(
                                        title: "Complete & Continue",
                                        icon: "arrow.right",
                                        action: {
                                            viewModel.markTaskStepCompleted(taskId: task.id, step: currentStep + 1)
                                            withAnimation {
                                                currentStep += 1
                                            }
                                        },
                                        theme: viewModel.selectedTheme
                                    )
                                } else {
                                    CustomButtonSK(
                                        title: "Complete Quest",
                                        icon: "checkmark",
                                        action: {
                                            viewModel.markTaskStepCompleted(taskId: task.id, step: currentStep + 1)
                                            showFinish = true
                                        },
                                        theme: viewModel.selectedTheme
                                    )
                                }
                            }
                            .padding(.top, 16)
                            
                            Spacer(minLength: 40)
                        }
                        .padding(.horizontal, 20)
                    }
                }
            }
        }
        .fullScreenCover(isPresented: $showFinish, onDismiss: { dismiss() }) {
            TaskFinishViewSK(task: task)
                .environmentObject(viewModel)
        }
        .navigationBarHidden(true)
    }
}

#Preview {
    TaskStepViewSK(
        task: TaskModelSK(
            id: "1",
            title: "Build the Pyramid",
            subtitle: "Ancient engineering",
            coverImage: "pyramid",
            difficulty: "medium",
            isPremium: false,
            steps: [
                TaskStepModelSK(id: "1", step: 1, title: "Choose Location", description: "The first and most crucial step in building a pyramid was selecting the perfect location. Ancient Egyptian architects carefully considered several factors: proximity to the Nile for transportation of materials, solid bedrock foundation to support the massive weight, and alignment with celestial bodies for religious significance."),
                TaskStepModelSK(id: "2", step: 2, title: "Gather Materials", description: "Collect limestone blocks from quarries"),
                TaskStepModelSK(id: "3", step: 3, title: "Build Foundation", description: "Create a solid base"),
                TaskStepModelSK(id: "4", step: 4, title: "Construct Layers", description: "Stack blocks carefully"),
                TaskStepModelSK(id: "5", step: 5, title: "Add Casing", description: "Apply smooth outer layer"),
                TaskStepModelSK(id: "6", step: 6, title: "Final Touches", description: "Complete the capstone")
            ]
        ),
        currentStep: 0
    )
    .environmentObject(MainViewModelSK())
}
