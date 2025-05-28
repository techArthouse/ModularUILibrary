//
//  IconButtons.swift
//
//
//  Created by Arturo Aguilar on 2/26/24.
//

import SwiftUI

/// Protocol defining the requirements for a custom icon button.
/// Conforming views must be able to provide a binding to a disabled state.
public protocol IconButtonProtocol: View {
    var isDisabled: Binding<Bool> { get }
}

/// Provides default implementations for various icon button styles.
/// This extension allows any `IconButtonProtocol` conforming view to be easily styled
/// according to the design language specified in a theme.
public extension IconButtonProtocol {
    /// Applies the generic icon button style.
    public func asStandardIconButtonStyle() -> some View {
        self.modifier(IconButtonStyleModifier(style: .generic, isDisabled: isDisabled))
    }
    
    /// Applies the panel icon button style and attaches text to the button as part of the dsl definition for panel buttons.
    /// - Parameter text: The text to be displayed below the icon button.
    func asPanelIconButtonStyle(with text: String) -> some View {
        self.modifier(IconButtonStyleModifier(style: .panel, isDisabled: isDisabled))
            .modifier(PanelButtonText(text: text, isDisabled: isDisabled))
    }
    
    /// Applies the floating action button style, which includes a shadow for a raised effect.
    func asFloatingActionButtonStyle() -> some View {
        self.modifier(IconButtonStyleModifier(style: .generic, isDisabled: isDisabled)).modifier(FloatingButtonButton())
    }
}

/// A view modifier that applies a custom button style defined in the environment's `ThemeManager`.
public struct IconButtonStyleModifier: ViewModifier {
    @EnvironmentObject var themeManager: ThemeManager
    
    /// Styles that can be applied to icon buttons.
    public enum Style {
        case generic, panel
    }

    var style: Style
    @Binding var isDisabled: Bool

    /// Retrieves the appropriate `IconButtonStyle` from `ThemeManager` based on the `style` property.
    private var configuration: IconButtonStyle {
        switch style {
        case .generic:
            return themeManager.theme.iconButtonStyles.iconButtonStyle
        case .panel:
            return themeManager.theme.iconButtonStyles.panelButtonStyle
        }
    }

    /// Wraps the content in a `CustomButtonStyle` with styling based on the `configuration`.
    public func body(content: Content) -> some View {
        content.buttonStyle(CustomButtonStyle(style: configuration, isDisabled: $isDisabled))
    }
}

/// A view modifier that overlays text on the bottom of a button
struct PanelButtonText: ViewModifier {
    var text: String
    @EnvironmentObject var themeManager: ThemeManager
    @Binding var isDisabled: Bool
    
    /// Overlays the provided `text` on the button content, positioned at the bottom.
    /// The text styling is derived from the `ThemeManager`.
    func body(content: Content) -> some View {
        content.overlay(
            Text(text)
                .lineLimit(2) // Allow up to two lines
                .truncationMode(.tail) // Truncate at the end if more than two lines
                .font(themeManager.theme.iconButtonStyles.panelButtonStyle.font)
//                .padding([.top], 36)
                .multilineTextAlignment(.center)
                .frame(maxWidth: .infinity, alignment: .bottom)
            , alignment: .bottom
        )
    }
}


/// A view modifier that adds a shadow to the button, typically used for floating action buttons.
struct FloatingButtonButton: ViewModifier {
    /// Adds a shadow effect to the button for a floating appearance.
    func body(content: Content) -> some View {
        content.shadow(radius: 5)
    }
}
