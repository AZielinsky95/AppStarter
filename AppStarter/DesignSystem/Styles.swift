//
//  Styles.swift
//  AppStarter
//
//  Created by Alejandro Zielinsky on 2025-04-03.
//

import Foundation
import SwiftUICore

enum Styles {
    enum Card {
        static let cornerRadius: CGFloat = .spacing16xSmall
        static let padding: EdgeInsets = EdgeInsets(top: .spacing16xSmall, leading: .spacing16xSmall, bottom: .spacing16xSmall, trailing: .spacing16xSmall)
        static let shadowRadius: CGFloat = .spacing4xxxSmall
        static let enableShadow: Bool = true
        static let backgroundColor: Color = Color(.systemBackground)
    }
    enum Pill {
        static let cornerRadius: CGFloat = .spacing16xSmall
        static let padding: EdgeInsets = EdgeInsets(top: .spacing4xxxSmall, leading: .spacing12xSmall, bottom: .spacing4xxxSmall, trailing: .spacing12xSmall)
        static let backgroundColor: Color = Color(.systemBackground)
        static let foregroundColor: Color = .blue
        static let imageColor: Color = .blue
        static let imageSize: CGSize = CGSize(width: 11, height: 11)
    }
}
