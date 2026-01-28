import SwiftUI

struct PharaohTimelineViewSK: View {
    @EnvironmentObject var viewModel: MainViewModelSK
    @Environment(\.dismiss) var dismiss
    
    let pharaohs: [(name: String, dynasty: String, period: String, reign: String, achievement: String)] = [
        ("Narmer", "1st Dynasty", "Early Dynastic", "c. 3100 BCE", "United Upper and Lower Egypt"),
        ("Djoser", "3rd Dynasty", "Old Kingdom", "c. 2670-2650 BCE", "Built the Step Pyramid at Saqqara"),
        ("Khufu", "4th Dynasty", "Old Kingdom", "c. 2589-2566 BCE", "Commissioned the Great Pyramid of Giza"),
        ("Khafre", "4th Dynasty", "Old Kingdom", "c. 2558-2532 BCE", "Built the second pyramid at Giza and the Great Sphinx"),
        ("Menkaure", "4th Dynasty", "Old Kingdom", "c. 2532-2503 BCE", "Built the third pyramid at Giza"),
        ("Hatshepsut", "18th Dynasty", "New Kingdom", "c. 1479-1458 BCE", "One of the most successful female pharaohs"),
        ("Thutmose III", "18th Dynasty", "New Kingdom", "c. 1479-1425 BCE", "Expanded Egypt to its greatest extent"),
        ("Akhenaten", "18th Dynasty", "New Kingdom", "c. 1353-1336 BCE", "Introduced monotheistic worship of Aten"),
        ("Tutankhamun", "18th Dynasty", "New Kingdom", "c. 1332-1323 BCE", "Famous for his intact tomb discovery"),
        ("Ramesses II", "19th Dynasty", "New Kingdom", "c. 1279-1213 BCE", "Built numerous monuments and temples"),
        ("Cleopatra VII", "Ptolemaic", "Ptolemaic Period", "51-30 BCE", "Last active pharaoh of Egypt")
    ]
    
    var body: some View {
        ZStack {
            GradientBackgroundSK(colors: viewModel.selectedTheme.primaryGradient)
            
            VStack(spacing: 0) {
                CustomHeaderSK(
                    title: "Pharaoh Timeline",
                    subtitle: "Journey through Egyptian dynasties",
                    showBackButton: true,
                    onBack: { dismiss() },
                    theme: viewModel.selectedTheme
                )
                
                ScrollView {
                    VStack(alignment: .leading, spacing: 0) {
                        ForEach(Array(pharaohs.enumerated()), id: \.offset) { index, pharaoh in
                            HStack(alignment: .top, spacing: 16) {
                                VStack(spacing: 4) {
                                    ZStack {
                                        Circle()
                                            .fill(viewModel.selectedTheme.accentColor)
                                            .frame(width: 16, height: 16)
                                        
                                        Circle()
                                            .fill(viewModel.selectedTheme.cardBackground)
                                            .frame(width: 8, height: 8)
                                    }
                                    
                                    if index < pharaohs.count - 1 {
                                        Rectangle()
                                            .fill(viewModel.selectedTheme.accentColor.opacity(0.3))
                                            .frame(width: 2)
                                            .frame(minHeight: 120)
                                    }
                                }
                                .padding(.top, 8)
                                
                                VStack(alignment: .leading, spacing: 12) {
                                    VStack(alignment: .leading, spacing: 8) {
                                        HStack {
                                            Text(pharaoh.name)
                                                .font(.system(size: 20, weight: .bold))
                                                .foregroundColor(viewModel.selectedTheme.textColor)
                                            
                                            Spacer()
                                            
                                            Image(systemName: "crown.fill")
                                                .font(.system(size: 18))
                                                .foregroundColor(viewModel.selectedTheme.accentColor)
                                        }
                                        
                                        HStack(spacing: 12) {
                                            Text(pharaoh.dynasty)
                                                .font(.system(size: 13, weight: .semibold))
                                                .foregroundColor(viewModel.selectedTheme.accentColor)
                                                .padding(.horizontal, 10)
                                                .padding(.vertical, 4)
                                                .background(viewModel.selectedTheme.accentColor.opacity(0.15))
                                                .cornerRadius(6)
                                            
                                            Text(pharaoh.period)
                                                .font(.system(size: 12, weight: .medium))
                                                .foregroundColor(viewModel.selectedTheme.textColor.opacity(0.6))
                                        }
                                        
                                        Text(pharaoh.reign)
                                            .font(.system(size: 14, weight: .medium))
                                            .foregroundColor(viewModel.selectedTheme.textColor.opacity(0.7))
                                        
                                        Text(pharaoh.achievement)
                                            .font(.system(size: 15, weight: .regular))
                                            .foregroundColor(viewModel.selectedTheme.textColor.opacity(0.8))
                                            .lineSpacing(4)
                                    }
                                    .padding(16)
                                    .background(viewModel.selectedTheme.cardBackground)
                                    .cornerRadius(12)
                                }
                                .padding(.bottom, index < pharaohs.count - 1 ? 0 : 20)
                            }
                        }
                    }
                    .padding(.horizontal, 20)
                    .padding(.bottom, 40)
                }
            }
        }
        .navigationBarHidden(true)
    }
}

#Preview {
    PharaohTimelineViewSK()
        .environmentObject(MainViewModelSK())
}
