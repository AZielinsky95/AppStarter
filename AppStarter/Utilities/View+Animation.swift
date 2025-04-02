//
//  View+Animation.swift
//  AppStarter
//
//  Created by Alejandro Zielinsky on 2025-04-02.
//

import SwiftUI

extension View {
    func onAnimationCompleted<Value: VectorArithmetic>(
        for animatingValue: Value,
        completion: @escaping () -> Void
    ) -> some View {
        self.modifier(AnimationCompletionObserverModifier(observedValue: animatingValue, completion: completion))
    }
}

struct AnimationCompletionObserverModifier<Value>: AnimatableModifier where Value: VectorArithmetic {
    var targetValue: Value
    var completion: () -> Void

    init(observedValue: Value, completion: @escaping () -> Void) {
        self.completion = completion
        self.targetValue = observedValue
        animatableData = observedValue
    }

    var animatableData: Value {
        didSet {
            notifyCompletionIfFinished()
        }
    }

    private func notifyCompletionIfFinished() {
        if animatableData == targetValue {
            DispatchQueue.main.async {
                completion()
            }
        }
    }

    func body(content: Content) -> some View {
        content
    }
}
