//
//  FontStyle.swift
//  AppStarter
//
//  Created by Alejandro Zielinsky on 2025-03-30.
//


import SwiftUI

enum FontStyle: String {
    case medium
    case regular
}

struct VariableFontModifier: ViewModifier {
    var textStyle: Font.TextStyle
    var weight: Font.Weight = .regular
    
    func body(content: Content) -> some View {
        let size = UIFont.preferredFont(forTextStyle: textStyle.uiTextStyle).pointSize
        let fontName = "Urbanist"
        let font = Font.custom(
            fontName,
            size: size,
            relativeTo: textStyle
        ).weight(weight)
        
        return content.font(font)
    }
}

extension Font.TextStyle {
    var uiTextStyle: UIFont.TextStyle {
        switch self {
        case .largeTitle: return .largeTitle
        case .title: return .title1
        case .title2: return .title2
        case .title3: return .title3
        case .headline: return .headline
        case .subheadline: return .subheadline
        case .body: return .body
        case .callout: return .callout
        case .footnote: return .footnote
        case .caption: return .caption1
        case .caption2: return .caption2
        default: return .body
        }
    }
}

extension View {
    func appFont(_ textStyle: Font.TextStyle, weight: Font.Weight = .regular) -> some View {
        self.modifier(VariableFontModifier(textStyle: textStyle, weight: weight))
    }
}

private enum Weights: String, CaseIterable {
    case light = "light"
    case regular = "regular"
    case medium = "medium"
    case semibold = "semibold"
    case bold = "bold"
    
    var value: Font.Weight {
        switch self {
        case .light: .light
        case .regular: .regular
        case .medium: .medium
        case .semibold: .semibold
        case .bold: .bold
        }
    }
}

#Preview {
    VStack(alignment: .leading, spacing: 2) {
        Text("Urbanist").appFont(.largeTitle)
        ForEach(Font.TextStyle.allCases, id: \.self) { style in
            Text("\(style) - size: \(UIFont.preferredFont(forTextStyle: style.uiTextStyle).pointSize)").appFont(style, weight: .regular)
        }
        HStack {
            ForEach(Weights.allCases, id: \.self) { weight in
                Text("\(weight)").appFont(.body, weight: weight.value)
            }
        }
        .padding(.top, 32)
        Spacer()
    }
}
