import SwiftUI

struct PopupAlertConfig {
    let title: String
    let message: String?
    let imageName: String?
    let showLoadingIndicator: Bool
    let primaryAction: (() -> Void)?
    let secondaryAction: (() -> Void)?

    init(
        title: String,
        message: String? = nil,
        imageName: String? = nil,
        showLoadingIndicator: Bool = false,
        primaryAction: (() -> Void)? = nil,
        secondaryAction: (() -> Void)? = nil
    ) {
        self.title = title
        self.message = message
        self.imageName = imageName
        self.showLoadingIndicator = showLoadingIndicator
        self.primaryAction = primaryAction
        self.secondaryAction = secondaryAction
    }

    init(title: String) {
        self.title = title
        self.showLoadingIndicator = true
        self.message = nil
        self.imageName = nil
        self.primaryAction = nil
        self.secondaryAction = nil
    }
}

struct PopupAlertView: View {

    let config: PopupAlertConfig
    @State private var opacity = 0.0
    let onDismiss: () -> Void
    @State private var shouldShow = false
    private let animDuration = 0.15
    private let dimmedOpacity = 0.4

    var body: some View {
        ZStack {
            Color.black.opacity(opacity)
                .animation(.linear(duration: animDuration), value: opacity)
                .edgesIgnoringSafeArea(.all)

            if shouldShow {
                ZStack {
                    
                    RoundedRectangle(cornerRadius: 12.0)
                        .foregroundColor(.black.opacity(0.1))
                        .background(Blur(effect: UIBlurEffect(style: .dark)))
                        .cornerRadius(12.0)
       
                    RoundedRectangle(cornerRadius: 12.0)
                        .stroke(lineWidth: 2.0)
                        .foregroundColor(.white.opacity(0.1))
                    
                    VStack(spacing: 8) {

                        if config.showLoadingIndicator {
                            ProgressView()
                                .controlSize(.large)
                                .padding(.bottom, 20)
                        }

                        if let image = config.imageName {
                            Image(image)
                                .padding(.bottom, 20)
                        }

                        Text(config.title)
                            .multilineTextAlignment(.center)

                        if let message = config.message {
                            Text(message)
                                .multilineTextAlignment(.center)
                                .fixedSize(horizontal: false, vertical: true)
                                .padding(.bottom, 16)
                        }

                        Spacer()

                        HStack(spacing: 48) {
                            Spacer()
                            if let action = config.primaryAction {
                                Button(action: { dismiss { action() } }, label: {
                                    Image(systemName: "checkmark.circle.fill")
                                        .resizable()
                                        .symbolRenderingMode(.palette)
                                        .foregroundStyle(Color.black, Color.green)
                                        .frame(width: 44, height: 44)
                                })
                            }
                            
                            if let action = config.secondaryAction {
                                Button(action: { dismiss { action() } }, label: {
                                    Image(systemName: "xmark.circle.fill")
                                        .resizable()
                                        .symbolRenderingMode(.palette)
                                        .foregroundStyle(Color.black, Color.red)
                                        .frame(width: 44, height: 44)
                                })
                            }
                            Spacer()
                        }
                    }
                    .padding(EdgeInsets(top: 32, leading: 24, bottom: 16, trailing: 24))
                }
                .transition(.push(from: .top))
                .frame(maxWidth: 600)
                .fixedSize(horizontal: false, vertical: true)
                .padding(.horizontal, 20)
            }
        }
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + animDuration) {
                opacity = dimmedOpacity
                withAnimation(.spring(response: 0.35, dampingFraction: 0.65, blendDuration: 0)) {
                    shouldShow = true
                }
            }
        }
    }

    private func dismiss(onComplete: @escaping () -> Void) {
        shouldShow = false
        opacity = 0.0
        DispatchQueue.main.asyncAfter(deadline: .now() + animDuration) {
            onDismiss()
            onComplete()
        }
    }
}

struct Blur: UIViewRepresentable {
    var effect: UIVisualEffect?
    func makeUIView(context: UIViewRepresentableContext<Self>) -> UIVisualEffectView { UIVisualEffectView() }
    func updateUIView(_ uiView: UIVisualEffectView, context: UIViewRepresentableContext<Self>) {
        uiView.backgroundColor = .clear
        uiView.effect = effect
    }
}


#Preview {
    let alertConfig = PopupAlertConfig(
        title: "Exit Game",
        message: "Are you sure you want to exit? This will end the game, and you will lose your progress.",
        primaryAction: {},
        secondaryAction: {}
    )
    
    return PopupAlertView(
        config: alertConfig, onDismiss: {})
}
