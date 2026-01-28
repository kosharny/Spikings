import SwiftUI

struct PyramidExplorerViewSK: View {
    @EnvironmentObject var viewModel: MainViewModelSK
    @Environment(\.dismiss) var dismiss
    
    let pyramids: [(name: String, location: String, pharaoh: String, height: String, built: String, blocks: String, theory: String)] = [
        ("Great Pyramid of Giza", "Giza Plateau", "Khufu", "146.5m (original)", "c. 2580-2560 BCE", "~2.3 million", "Ramp theories suggest internal or external ramps were used to transport limestone blocks"),
        ("Pyramid of Khafre", "Giza Plateau", "Khafre", "143.5m", "c. 2570 BCE", "~2.2 million", "Built with steeper angle and retains some of its original casing stones at the apex"),
        ("Pyramid of Menkaure", "Giza Plateau", "Menkaure", "65m", "c. 2510 BCE", "~252,000", "Smallest of the three main Giza pyramids, built with granite lower courses"),
        ("Step Pyramid", "Saqqara", "Djoser", "62m", "c. 2670-2650 BCE", "~330,000", "First monumental stone building, designed by architect Imhotep using mastaba layers"),
        ("Red Pyramid", "Dahshur", "Sneferu", "104m", "c. 2590 BCE", "~1.7 million", "First successful smooth-sided pyramid, named for reddish limestone"),
        ("Bent Pyramid", "Dahshur", "Sneferu", "101m", "c. 2600 BCE", "~1.2 million", "Unique bent shape due to angle change mid-construction, possibly to prevent collapse")
    ]
    
    @State private var selectedPyramid: Int = 0
    
    var body: some View {
        ZStack {
            GradientBackgroundSK(colors: viewModel.selectedTheme.primaryGradient)
            
            VStack(spacing: 0) {
                CustomHeaderSK(
                    title: "Pyramid Explorer",
                    subtitle: "Discover ancient construction marvels",
                    showBackButton: true,
                    onBack: { dismiss() },
                    theme: viewModel.selectedTheme
                )
                
                TabView(selection: $selectedPyramid) {
                    ForEach(Array(pyramids.enumerated()), id: \.offset) { index, pyramid in
                        ScrollView {
                            VStack(alignment: .leading, spacing: 24) {
                                ZStack {
                                    Rectangle()
                                        .fill(
                                            LinearGradient(
                                                gradient: Gradient(colors: [viewModel.selectedTheme.accentColor.opacity(0.4), viewModel.selectedTheme.accentColor.opacity(0.2)]),
                                                startPoint: .topLeading,
                                                endPoint: .bottomTrailing
                                            )
                                        )
                                        .frame(height: 220)
                                        .cornerRadius(20)
                                    
                                    Image(systemName: "triangle.fill")
                                        .font(.system(size: 80))
                                        .foregroundColor(viewModel.selectedTheme.accentColor.opacity(0.3))
                                        .rotationEffect(.degrees(0))
                                }
                                .padding(.horizontal, 20)
                                
                                VStack(alignment: .leading, spacing: 16) {
                                    Text(pyramid.name)
                                        .font(.system(size: 28, weight: .bold))
                                        .foregroundColor(viewModel.selectedTheme.textColor)
                                    
                                    VStack(spacing: 12) {
                                        InfoRowSK(
                                            icon: "mappin.circle.fill",
                                            label: "Location",
                                            value: pyramid.location,
                                            theme: viewModel.selectedTheme
                                        )
                                        
                                        InfoRowSK(
                                            icon: "crown.fill",
                                            label: "Pharaoh",
                                            value: pyramid.pharaoh,
                                            theme: viewModel.selectedTheme
                                        )
                                        
                                        InfoRowSK(
                                            icon: "arrow.up.circle.fill",
                                            label: "Height",
                                            value: pyramid.height,
                                            theme: viewModel.selectedTheme
                                        )
                                        
                                        InfoRowSK(
                                            icon: "calendar.circle.fill",
                                            label: "Built",
                                            value: pyramid.built,
                                            theme: viewModel.selectedTheme
                                        )
                                        
                                        InfoRowSK(
                                            icon: "cube.fill",
                                            label: "Stone Blocks",
                                            value: pyramid.blocks,
                                            theme: viewModel.selectedTheme
                                        )
                                    }
                                    
                                    VStack(alignment: .leading, spacing: 12) {
                                        HStack(spacing: 8) {
                                            Image(systemName: "lightbulb.fill")
                                                .font(.system(size: 18))
                                                .foregroundColor(viewModel.selectedTheme.accentColor)
                                            
                                            Text("Construction Theory")
                                                .font(.system(size: 18, weight: .bold))
                                                .foregroundColor(viewModel.selectedTheme.textColor)
                                        }
                                        
                                        Text(pyramid.theory)
                                            .font(.system(size: 15, weight: .regular))
                                            .foregroundColor(viewModel.selectedTheme.textColor.opacity(0.8))
                                            .lineSpacing(6)
                                    }
                                    .padding(16)
                                    .background(viewModel.selectedTheme.cardBackground.opacity(0.7))
                                    .cornerRadius(12)
                                }
                                .padding(.horizontal, 20)
                                
                                Spacer(minLength: 40)
                            }
                            .padding(.top, 16)
                        }
                        .tag(index)
                    }
                }
                .tabViewStyle(.page(indexDisplayMode: .always))
                .indexViewStyle(.page(backgroundDisplayMode: .always))
            }
        }
        .navigationBarHidden(true)
    }
}

struct InfoRowSK: View {
    let icon: String
    let label: String
    let value: String
    var theme: ThemeModelSK
    
    var body: some View {
        HStack(spacing: 12) {
            Image(systemName: icon)
                .font(.system(size: 18, weight: .semibold))
                .foregroundColor(theme.accentColor)
                .frame(width: 32)
            
            VStack(alignment: .leading, spacing: 2) {
                Text(label)
                    .font(.system(size: 12, weight: .medium))
                    .foregroundColor(theme.textColor.opacity(0.6))
                
                Text(value)
                    .font(.system(size: 15, weight: .semibold))
                    .foregroundColor(theme.textColor)
            }
            
            Spacer()
        }
        .padding(12)
        .background(theme.cardBackground)
        .cornerRadius(10)
    }
}

#Preview {
    PyramidExplorerViewSK()
        .environmentObject(MainViewModelSK())
}
