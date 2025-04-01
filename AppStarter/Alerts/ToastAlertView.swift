import SwiftUI

enum ToastAlertType {
    case success
    case failure
    case custom(iconName: String, iconTint: Color)
    case symbol(systemName: String, iconTint: Color)
}

enum ToastPosition {
    case top
    case bottom

    var edge: Edge {
        self == .top ? Edge.top : Edge.bottom
    }
}

struct ToastAlertConfig {
    let message: AttributedString
    let type: ToastAlertType
    let dismissAfter: Double
    let position: ToastPosition

    /// Note: if  dismissAfter is set to 0 it disables auto-dismiss
    init(message: AttributedString, type: ToastAlertType, position: ToastPosition = .bottom, dismissAfter: Double = 2.0) {
        self.message = message
        self.type = type
        self.position = position
        self.dismissAfter = dismissAfter
    }
}

struct ToastAlertView: View {
    @Environment(\.safeAreaInsets) var safeAreaInsets
    @State private var showToast: Bool = false
    @State private var opacity = 1.0
    let config: ToastAlertConfig
    let onDismiss: () -> Void
    private let animDuration = 0.25
    private let minHeight = 54.0

    var body: some View {
        VStack {
            if config.position == .bottom {
                Spacer()
            }
            if showToast {
                ZStack {
                    
                    RoundedRectangle(cornerRadius: 12.0)
                        .foregroundColor(.black.opacity(0.1))
                        .background(Blur(effect: UIBlurEffect(style: .dark)))
                     
                    RoundedRectangle(cornerRadius: 8.0)
                        .stroke(lineWidth: 2.0)
                        .foregroundColor(iconDetails.color)
                    
                    HStack(spacing: 0) {
                        if iconDetails.isImage {
                            Image(iconDetails.name)
                                .resizable()
                                .renderingMode(.template)
                                .aspectRatio(contentMode: .fit)
                                .foregroundColor(.black)
                                .frame(height: 9)
                                .background(
                                    Circle()
                                        .fill(iconDetails.color)
                                        .frame(width: 24, height: 24)
                                )
                        } else {
                            Image(systemName: iconDetails.name)
                                .renderingMode(.template)
                                .resizable()
                                .foregroundColor(iconDetails.color)
                                .frame(width: 24, height: 24)
                        }
                        Text(config.message)
                            .appFont(.title)
                            .foregroundColor(.white)
                            .multilineTextAlignment(.leading)
                            .padding(.leading, 18)
                        Spacer()
                    }
                    .padding(.horizontal, 20)
                }
                .padding(.horizontal, 20)
                .frame(minHeight: minHeight)
                .fixedSize(horizontal: false, vertical: true)
                .transition(.move(edge: config.position.edge))
            }
            if config.position == .top {
                Spacer()
            }
        }
        .opacity(opacity)
        .padding(.bottom, 54 + safeAreaInsets.bottom)
        .edgesIgnoringSafeArea(.bottom)
        .onAppear {
            toggleToast()
            if config.dismissAfter > 0.0 {
                DispatchQueue.main.asyncAfter(deadline: .now() + config.dismissAfter) {
                    dismiss()
                }
            }
        }
    }

    var iconDetails: (isImage: Bool, name: String, color: Color) {
        switch config.type {
        case .success:
            return (true, "checkmark", Color.green)
        case .failure:
            return (false, "xmark.circle.fill", .red)
        case .custom(let iconName, let tint):
            return (true, iconName, tint)
        case .symbol(let systemName, let tint):
            return (false, systemName, tint)
        }
    }

    func toggleToast() {
        withAnimation(.interpolatingSpring(stiffness: 316, damping: 20)) {
            showToast = !showToast
            opacity = showToast ? 1.0 : 0.0
        }
    }

    func dismiss() {
        toggleToast()
        DispatchQueue.main.asyncAfter(deadline: .now() + animDuration) {
            onDismiss()
        }
    }
}

#Preview("Success") {
    Group {
        ToastAlertView(
            config: .init(message: "Purchase", type: .success, dismissAfter: 0),
            onDismiss: {}
        )
    }
}

#Preview("Error") {
    ToastAlertView(
        config: .init(message: "Error", type: .failure, dismissAfter: 0),
        onDismiss: {}
    )
}
    
public extension EnvironmentValues {
    
    var safeAreaInsets: EdgeInsets {
        self[SafeAreaInsetsKey.self]
    }
}

private struct SafeAreaInsetsKey: EnvironmentKey {
    
    static var defaultValue: EdgeInsets {
        #if os(iOS) || os(tvOS)
        let keyWindow = UIApplication.shared.keyWindow
        return keyWindow?.safeAreaInsets.edgeInsets ?? EdgeInsets()
        #else
        EdgeInsets()
        #endif
    }
}

#if canImport(UIKit)
private extension UIEdgeInsets {
    
    var edgeInsets: EdgeInsets {
        EdgeInsets(top: top, leading: left, bottom: bottom, trailing: right)
    }
}
#endif
