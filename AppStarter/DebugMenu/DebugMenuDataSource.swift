//
//  DebugMenuDataSource.swift
//  AppStarter
//
//  Created by Alejandro Zielinsky on 2025-04-03.
//

import DebugMenu

public class DebugMenuDataSource: BaseDebugDataSource {

    // Custom property wrapper for toggles
    @DebugToggle(title: "Show All Foos", key: "showFoosKey") var showAllFoos = false

    // Group actions in sections
    lazy var toggleSection: DebugSection = {
        DebugSection(title: "Toggles", actions: [$showAllFoos.action])
    }()

    lazy var buttonSection: DebugSection = {
        let testButton = DebugButtonAction(title: "Test Button", action: { print("Button Tapped") })

        return DebugSection(title: "Buttons", actions: [testButton])
    }()
    
    static let shared = DebugMenuDataSource()

    private init() {
        super.init()
        self.addSections([toggleSection, buttonSection])
    }
}
