//
//  View+Modifiers.swift
//  
//
//  Created by Aguilar, Arturo on 1/12/24.
//

import SwiftUI

extension View {
    /// DisabledTapGesture will fire an alternative action when the view is disabled. The 'isDisabled' must match the binding variable also
    /// passed to the view being modified to apply consistent functionality across the entire view.
    func onDisabledTapGesture(isDisabled: Binding<Bool>, perform action: @escaping () -> Void) -> some View {
        self.modifier(DisabledTapGesture(action: action, isDisabled: isDisabled))
    }
    
}


/// DisabledTapGesture sets up an action when 'isDisabled' is true.
/// It's meant to be used in tandem to the governing variable that decides the disabled state for the modifed view.
struct DisabledTapGesture: ViewModifier {
    var action: () -> Void
    @Binding var isDisabled: Bool

    func body(content: Content) -> some View {
        content
            .disabled(isDisabled)
            .onTapGesture {
                if isDisabled {
                    action()
                }
            }
    }
}
