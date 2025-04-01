//
//  WebView.swift
//  AppStarter
//
//  Created by Alejandro Zielinsky on 2025-03-31.
//


import SwiftUI
import WebKit

struct LocalWebView: UIViewRepresentable {
    let htmlFileName: String

    func makeUIView(context: Context) -> WKWebView {
        let webview = WKWebView()
        webview.backgroundColor = .white
        return webview
    }

    func updateUIView(_ uiView: WKWebView, context: Context) {
        if let url = Bundle.main.url(forResource: htmlFileName, withExtension: "html") {
            let request = URLRequest(url: url)
            uiView.load(request)
        }
    }
}
