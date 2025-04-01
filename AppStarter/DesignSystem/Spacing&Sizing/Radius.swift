//
//  Radius.swift
//  AppStarter
//
//  Created by Alejandro Zielinsky on 2025-03-30.
//


import Foundation
import SwiftUI

extension CGFloat {
    // MARK: Radius

    /// Small radius 10px.
    public static let radius10Small = CGFloat(10)
    /// Small radius 12px.
    public static let radius12Small = CGFloat(12)
    /// Medium radius 16px.
    public static let radius16Medium = CGFloat(16)
    /// Medium radius 20px.
    public static let radius20Medium = CGFloat(20)
    /// Large radius 22px.
    public static let radius22Large = CGFloat(22)
    /// Extra large radius 24px.
    public static let radius24xLarge = CGFloat(24)
    /// Full radius 100%.
    public static let radiusFull = CGFloat.infinity

    // MARK: Spacing

    /// 3x small spacing 4px.
    public static let spacing4xxxSmall = CGFloat(4)
    /// 2x small spacing 8px.
    public static let spacing8xxSmall = CGFloat(8)
    /// 1.5x small spacing 12px.
    public static let spacing12xSmall = CGFloat(12)
    /// 1x small spacing 16px.
    public static let spacing16xSmall = CGFloat(16)
    /// Small spacing 20px.
    public static let spacing20Small = CGFloat(20)
    /// Medium spacing 24px.
    public static let spacing24Medium = CGFloat(24)
    /// Large spacing 32px.
    public static let spacing32Large = CGFloat(32)
    /// 1x large spacing 40px.
    public static let spacing40xLarge = CGFloat(40)
    /// 2x large spacing 54px.
    public static let spacing54xxLarge = CGFloat(54)
}

struct Radius_Previews: PreviewProvider {
    static var previews: some View {
        let radii: [CGFloat] = [
            .radius10Small,
            .radius12Small,
            .radius16Medium,
            .radius20Medium,
            .radius22Large,
            .radius24xLarge,
            .radiusFull,
        ]

        VStack {
            ForEach(radii, id: \.self) { radius in
                HStack {
                    Text(String(describing: radius))
                    Spacer()
                    Color.primary
                        .frame(width: 100, height: 100)
                        .cornerRadius(radius)
                }
            }
        }
        .padding()
    }
}

struct Spacing_Previews: PreviewProvider {
    static var previews: some View {
        let spacings: [CGFloat] = [
            .spacing4xxxSmall,
            .spacing8xxSmall,
            .spacing16xSmall,
            .spacing20Small,
            .spacing24Medium,
            .spacing32Large,
            .spacing40xLarge,
            .spacing54xxLarge,
        ]

        VStack {
            ForEach(spacings, id: \.self) { spacing in
                Group {
                    Text(String(describing: spacing))
                    HStack(spacing: spacing) {
                        Color.primary
                        Color.primary
                    }
                }
            }
        }
        .padding()
    }
}
