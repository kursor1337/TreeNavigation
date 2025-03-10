//
//  NavigationView.swift
//  TreeNavigation
//
//  Created by kursor on 06.03.2025.
//
import SwiftUI

struct NavigationView<T, Content: View>: View {
    var childStack: ChildStack<T>
    @ViewBuilder var childScreen: (T) -> Content

    var body: some View {
        NodeStackView(node: navigationTree.root) { child in
            switch childStack.active {
            case Screen.root:
                RootView(node: c)
            default:
                nil
            }
        }
    }
}
