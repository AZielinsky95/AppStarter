//
//  PrimaryButtonStyle.swift
//  AppStarter
//
//  Created by Alejandro Zielinsky on 2025-03-30.
//


import SwiftUI

public struct PrimaryButtonStyle: ButtonStyle {
    public func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .padding(.vertical, .spacing8xxSmall)
            .padding(.horizontal, .spacing12xSmall)
            .background(Color.primaryPurple)
            .foregroundColor(Color.white)
            .clipShape(Capsule())
    }
}

extension ButtonStyle where Self == PrimaryButtonStyle {
    public static var primary: PrimaryButtonStyle { PrimaryButtonStyle() }
}

#Preview {
    VStack {
        Button("Button 1") {
            // Action for Button 1
        }
        .buttonStyle(PrimaryButtonStyle())
        
        Button("Button 2") {
            // Action for Button 2
        }
        .buttonStyle(PrimaryButtonStyle())
    }
}
