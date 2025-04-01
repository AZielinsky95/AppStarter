import SwiftUI

struct AlertItem {
    let type: AlertType

    enum AlertType {
        case popup(config: PopupAlertConfig)
        case toast(config: ToastAlertConfig)
    }
}

typealias Action = () -> Void

class AlertController: ObservableObject {

    public static let shared = AlertController()
    private var alertWindow: UIWindow?

    /// Note: if  dismissAfter is set to 0 it disables auto-dismiss
    func showToast(_ message: AttributedString, type: ToastAlertType, position: ToastPosition = .bottom, dismissAfter: Double = 2.0) {
        let config = ToastAlertConfig(message: message, type: type, position: position, dismissAfter: dismissAfter)
        let alert = AlertItem(type: .toast(config: config))
        onAlertReceived(alert)
    }

    func showToast(_ message: String, type: ToastAlertType, position: ToastPosition = .bottom, dismissAfter: Double = 2.0) {
        let attributed = AttributedString(stringLiteral: message)
        let config = ToastAlertConfig(message: attributed, type: type, position: position, dismissAfter: dismissAfter)
        let alert = AlertItem(type: .toast(config: config))
        onAlertReceived(alert)
    }

    func showPopup(title: String, message: String? = nil) {
        showPopup(title: title, message: message, primaryAction: {})
    }

    func showPopup(
        title: String,
        message: String? = nil,
        imageName: String? = nil,
        showLoadingIndicator: Bool = false,
        primaryAction: Action? = nil,
        secondaryAction: Action? = nil
    ) {
        let config = PopupAlertConfig(
            title: title,
            message: message,
            imageName: imageName,
            showLoadingIndicator: showLoadingIndicator,
            primaryAction: primaryAction,
            secondaryAction: secondaryAction
        )
        let alert = AlertItem(type: .popup(config: config))
        onAlertReceived(alert)
    }

    func showBlockingPopup(title: String) {
        let config = PopupAlertConfig(title: title)
        let alert = AlertItem(type: .popup(config: config))
        onAlertReceived(alert)
    }

    private func onAlertReceived(_ alert: AlertItem) {
        guard let windowScene = (UIApplication.shared.connectedScenes.first as? UIWindowScene)?.keyWindow?.windowScene else {
            print("❌ ERROR NO WINDOW?")
            return
        }

        if alertWindow != nil {
            print("❌ Attempting to display alert while an alert is already displaying")
            return
        }

        var window: UIWindow
        var controller: UIViewController

        switch alert.type {
        case .toast(let config):
            window = PassThroughWindow(windowScene: windowScene)
            controller = UIHostingController(rootView: ToastAlertView(config: config, onDismiss: {
                self.dismissWindow()
            }))
        case .popup(let config):
            window = UIWindow(windowScene: windowScene)
            controller = UIHostingController(rootView: PopupAlertView(config: config, onDismiss: {
                self.dismissWindow()
            }))
        }

        window.backgroundColor = .clear
        window.windowLevel = .alert
        controller.view.backgroundColor = .clear

        alertWindow = window
        alertWindow?.rootViewController = controller
        alertWindow?.isHidden = false
    }

    func dismissWindow(onComplete: (() -> Void)? = nil) {
        guard let window = alertWindow else {
            onComplete?()
            return
        }
        window.rootViewController?.dismiss(animated: true) {
            self.alertWindow?.windowScene = nil
            self.alertWindow = nil
            onComplete?()
        }
    }
}

private class PassThroughWindow: UIWindow {
  override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
    // Get view from superclass.
    guard let hitView = super.hitTest(point, with: event) else { return nil }
    // If the returned view is the `UIHostingController`'s view, ignore.
    return rootViewController?.view == hitView ? nil : hitView
  }
}
