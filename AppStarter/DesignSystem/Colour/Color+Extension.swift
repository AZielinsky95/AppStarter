import SwiftUI

extension Color {
    public static let primaryPurple = Color("PrimaryColor", bundle: .main)
    public static let themeColor = Color("ThemeColor", bundle: .main)
}

extension Color {
    func toHex() -> String {
        let uiColor = UIColor(self)
        
        let components = uiColor.cgColor.components ?? [0, 0, 0]
        let red = Int(components[0] * 255)
        let green = Int(components[1] * 255)
        let blue = Int(components[2] * 255)
        
        return String(format: "#%02X%02X%02X", red, green, blue)
    }
    
    static func fromHex(_ hex: String) -> Color {
        let hexSanitized = hex.trimmingCharacters(in: .whitespacesAndNewlines).replacingOccurrences(of: "#", with: "")
        
        var rgb: UInt64 = 0
        Scanner(string: hexSanitized).scanHexInt64(&rgb)
        
        let red = Double((rgb & 0xFF0000) >> 16) / 255
        let green = Double((rgb & 0x00FF00) >> 8) / 255
        let blue = Double(rgb & 0x0000FF) / 255
        
        return Color(red: red, green: green, blue: blue)
    }
}
