//
//  CardContainer.swift
//  AppStarter
//
//  Created by Alejandro Zielinsky on 2025-04-02.
//


import SwiftUI

struct CardContainer<Content: View>: View {
    var cornerRadius: CGFloat = Styles.Card.cornerRadius
    var padding: EdgeInsets = Styles.Card.padding
    var shadowRadius: CGFloat = Styles.Card.shadowRadius
    var enableShadow: Bool = Styles.Card.enableShadow
    var backgroundColor: Color = Styles.Card.backgroundColor
    let content: () -> Content

    var body: some View {
        content()
            .padding(padding)
            .background(backgroundColor)
            .cornerRadius(cornerRadius)
            .shadow(color: enableShadow ? Color.black.opacity(0.1) : .clear, radius: shadowRadius, x: 0, y: 2)
    }
}

#Preview {
    CardContainer{
        Text("I am a card")
    }
    CardContainer(cornerRadius: 12, enableShadow: false, backgroundColor: .gray.opacity(0.1)) {
        Text("I am a flat card")
    }
}
