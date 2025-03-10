//
//  BottomsheetView.swift
//  TreeNavigation
//
//  Created by kursor on 09.03.2025.
//
import SwiftUI

extension View {
    func childSlotSheet<T : AnyObject, Content: View>(
        childSlot: ChildSlot<T>,
        @ViewBuilder childView: @escaping (T) -> Content
    ) -> some View {
        self.sheet(
            item: Binding(get: { childSlot.item }, set: { _ in })
        ) { item in
            childView(item)
        }
    }
}
