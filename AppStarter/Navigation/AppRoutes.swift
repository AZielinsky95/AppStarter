//
//  AppRoute.swift
//  AppStarter
//
//  Created by Alejandro Zielinsky on 2025-03-30.
//

enum AppRoute: Hashable {
    case home
    case detail(id: Int)
    case settings
}

enum DetailRoute: Hashable {
    case subpage1(id: Int)
    case subpage2(id: Int)
}
