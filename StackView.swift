//
//  NodeStackView.swift
//  TreeNavigation
//
//  Created by kursor on 06.03.2025.
//
import SwiftUI

struct StackView<T : Hashable, Content: View> : View {
    let childStack: ChildStack<T>
    @ViewBuilder let childView: (T) -> Content
    
    var body: some View {
        NavigationStack(
            path: Binding(
                get: { childStack.items.dropFirst() },
                set: { _ in }
            )
        ) {
            childView(childStack.active)
                .navigationDestination(for: T.self) { child in
                    childView(child)
                }
        }
    }
}
