import SwiftUI

enum Theme {
    static let primaryColor = Color(red: 0.27, green: 0.27, blue: 0.27)
    static let accentColor = Color(red: 0.71, green: 0.61, blue: 0.35)
    static let backgroundColor = Color(red: 0.93, green: 0.89, blue: 0.85)
    static let textColor = Color(red: 0.27, green: 0.27, blue: 0.27)
    
    static let titleFont = Font.custom("Palatino", size: 28).weight(.bold)
    static let headingFont = Font.custom("Palatino", size: 24).weight(.bold)
    static let bodyFont = Font.custom("Palatino", size: 16)
    
    struct ButtonStyle: ViewModifier {
        func body(content: Content) -> some View {
            content
                .font(Theme.bodyFont)
                .foregroundColor(.white)
                .padding()
                .background(Theme.accentColor)
                .cornerRadius(10)
        }
    }
    
    struct CardStyle: ViewModifier {
        func body(content: Content) -> some View {
            content
                .padding()
                .background(Color.white)
                .cornerRadius(15)
                .shadow(radius: 5)
        }
    }
}

extension View {
    func royalButtonStyle() -> some View {
        modifier(Theme.ButtonStyle())
    }
    
    func royalCardStyle() -> some View {
        modifier(Theme.CardStyle())
    }
} 