//
//  AnimatableModifierWithCompletion.swift
//  CasinoRoulette
//
//  Created by  Paul on 21.11.2021.
//

import SwiftUI

struct AnimatableModifierWithCompletion<V: VectorArithmetic>: AnimatableModifier {

    var targetValue: V

    // SwiftUI gradually varies it from old value to the new value
    var animatableData: V {
        didSet {
            checkIfFinished()
        }
    }

    var completion: () -> ()

    // Re-created every time the control argument changes
    init(bindedValue: V, completion: @escaping () -> ()) {
        self.completion = completion

        // Set animatableData to the new value. But SwiftUI again directly
        // and gradually varies the value while the body
        // is being called to animate. Following line serves the purpose of
        // associating the extenal argument with the animatableData.
        self.animatableData = bindedValue
        targetValue = bindedValue
    }

    func checkIfFinished() -> () {
//        print("Current value: \(animatableData)")
        if (animatableData == targetValue) {
            DispatchQueue.main.async {
                self.completion()
            }
        }
    }

    // Called after each gradual change in animatableData to allow the
    // modifier to animate
    func body(content: Content) -> some View {
        // content is the view on which .modifier is applied
        content
        // We don't want the system also to
        // implicitly animate default system animatons it each time we set it. It will also cancel
        // out other implicit animations now present on the content.
            .animation(nil)
    }
}
