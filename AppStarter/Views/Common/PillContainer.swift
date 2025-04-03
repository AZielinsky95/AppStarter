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
    var backgroundColor: Color = Styles.Pill.backgroundColor
    var foregroundColor: Color = Styles.Pill.foregroundColor
    var imageColor: Color = Styles.Pill.imageColor
    var imageSize: CGSize = Styles.Pill.imageSize
    var padding: EdgeInsets = Styles.Pill.padding

    enum ImagePlacement {
        case leading
        case trailing
    }
    
    func imageView(for image: Image) -> some View {
        image
            .resizable()
            .scaledToFit()
            .frame(width: imageSize.width, height: imageSize.height)
            .foregroundColor(imageColor)
    }

    var body: some View {
        HStack(spacing: .spacing4xxxSmall) {
            if imagePlacement == .leading, let image = image {
                imageView(for: image)
            }

            Text(text)
                .foregroundColor(foregroundColor)
                .font(.caption)

            if imagePlacement == .trailing, let image = image {
                imageView(for: image)
            }
        }
        .padding(padding)
        .background(backgroundColor)
        .clipShape(Capsule())
    }
}

#Preview {
    PillContainer(text: "Test")
    PillContainer(text: "Test", image: Image(systemName: "pencil"))
}
