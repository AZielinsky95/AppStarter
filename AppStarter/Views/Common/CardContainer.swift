//
//  CardContainer.swift
//  AppStarter
//
//  Created by Alejandro Zielinsky on 2025-04-02.
//


import SwiftUI

struct CardContainer<Content: View>: View {
    var cornerRadius: CGFloat = 16
    var padding: CGFloat = 16
    var shadowRadius: CGFloat = 4
    var backgroundColor: Color = Color(.systemBackground)
    let content: () -> Content

    var body: some View {
        content()
            .padding(padding)
            .background(backgroundColor)
            .cornerRadius(cornerRadius)
            .shadow(color: Color.black.opacity(0.1), radius: shadowRadius, x: 0, y: 2)
    }
}