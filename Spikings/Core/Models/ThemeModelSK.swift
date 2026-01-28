import SwiftUI

struct ThemeModelSK: Identifiable {
    let id: String
    let name: String
    let isPremium: Bool
    let price: String
    let primaryGradient: [Color]
    let accentColor: Color
    let textColor: Color
    let cardBackground: Color
}

extension ThemeModelSK {
    static let desertSands = ThemeModelSK(
        id: "desert_sands",
        name: "Desert Sands",
        isPremium: false,
        price: "Free",
        primaryGradient: [Color(hex: "C2956A"), Color(hex: "4D382B")],
        accentColor: Color(hex: "D4AF37"),
        textColor: Color(hex: "2C2416"),
        cardBackground: Color(hex: "F5E6D3")
    )
    
    static let goldenPharaoh = ThemeModelSK(
        id: "premium_theme_golden_pharaoh",
        name: "Golden Pharaoh",
        isPremium: true,
        price: "$1.99",
        primaryGradient: [Color(hex: "FFD700"), Color(hex: "B8860B"), Color(hex: "8B4513")],
        accentColor: Color(hex: "FFD700"),
        textColor: Color(hex: "1A1410"),
        cardBackground: Color(hex: "FFF8DC")
    )
    
    static let nightNile = ThemeModelSK(
        id: "premium_theme_night_nile",
        name: "Night Nile",
        isPremium: true,
        price: "$1.99",
        primaryGradient: [Color(hex: "1B2845"), Color(hex: "274060"), Color(hex: "5C4B99")],
        accentColor: Color(hex: "D4AF37"),
        textColor: Color(hex: "F5E6D3"),
        cardBackground: Color(hex: "2C3E5A")
    )
    
    static let allThemes = [desertSands, goldenPharaoh, nightNile]
}
