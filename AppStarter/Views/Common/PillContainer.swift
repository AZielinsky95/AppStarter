//
//  PillContainer.swift
//  AppStarter
//
//  Created by Alejandro Zielinsky on 2025-04-02.
//


import SwiftUI

struct PillContainer: View {
    var text: String
    var image: Image? = nil
    var imagePlacement: ImagePlacement = .leading
    var backgroundColor: Color = Color.blue.opacity(0.1)
    var foregroundColor: Color = .blue
    var padding: EdgeInsets = EdgeInsets(top: 6, leading: 12, bottom: 6, trailing: 12)

    enum ImagePlacement {
        case leading
        case trailing
    }

    var body: some View {
        HStack(spacing: 6) {
            if imagePlacement == .leading, let image = image {
                image
            }

            Text(text)
                .foregroundColor(foregroundColor)
                .font(.caption)

            if imagePlacement == .trailing, let image = image {
                image
            }
        }
        .padding(padding)
        .background(backgroundColor)
        .clipShape(Capsule())
    }
}