//  swiftlint:disable:this file_name
//  CTAButtons.swift
//  
//
//  Created by Aguilar, Arturo on 1/10/24.
//

import SwiftUI

/* Each of these button modifiers encapsulates the styling and behavior specific to a `CTAButton` Type, leveraging the benefits of
 * SwiftUI's component-based architecture. This keeps our code DRY (Don't Repeat Yourself) and focused.
 * A `CTAButton`, while generic, can be stylized using one of these modifiers. All instances must have access to an `EnvironmentObject`
 * of type `ThemeManager`. The `ThemeManager` should be injected at the root of the SwiftUI view hierarchy to ensure availability.
 * Failure to provide a `ThemeManager` will result in a runtime error.
 * See: CTAButtonModifier for details on how the styling is applied.
 */
extension CTAButton {
    /// Stylize `CTAButton` to look like CTAPrimaryButton according to Environement `ThemeManager`
    func asPrimaryButton(padding: CTAButtonModifier.PaddingType = .single) -> some View {
        self.modifier(CTAButtonModifier(style: .primary, padding: padding, isDisabled: $isDisabled))
    }
    
    /// Stylize `CTAButton` to look like CTASecondaryButton according to Environement `ThemeManager`
    func asSecondaryButton(padding: CTAButtonModifier.PaddingType = .single) -> some View {
        self.modifier(CTAButtonModifier(style: .secondary, padding: padding, isDisabled: $isDisabled))
    }
    
    /// Stylize `CTAButton` to look like CTABorderlessButton according to Environement `ThemeManager`
    func asBorderlessButton(padding: CTAButtonModifier.PaddingType = .single) -> some View {
        self.modifier(CTAButtonModifier(style: .borderless, padding: padding, isDisabled: $isDisabled))
    }
    
    /// Stylize `CTAButton` to look like CTAPrimaryAlertButton according to Environement `ThemeManager`
    func asPrimaryAlertButton(padding: CTAButtonModifier.PaddingType = .single) -> some View {
        self.modifier(CTAButtonModifier(style: .primaryAlert, padding: padding, isDisabled: $isDisabled))
    }
    
    /// Stylize `CTAButton` to look like CTADestructiveButton according to Environement `ThemeManager`
    func asDestructiveButton(padding: CTAButtonModifier.PaddingType = .single) -> some View {
        self.modifier(CTAButtonModifier(style: .destructive, padding: padding, isDisabled: $isDisabled))
    }
    
    /// `CTAButtonModifier` is a core component of `CTAButton` styling. As an internal struct ViewModiefier, It should not be used independently or with
    /// other views. It is designed to work in conjunction with `CTAButton` to apply consistent styling across all buttons
    /// The `CTAButtonModifier` applies a `CTAButtonStyle` onto a` CTAButton` base according to the Style selected.
    /// It configures the padding according to the spacing requirements  for `CTAButton` Types.
    ///     - PaddingType.single configures the layout according to the spacing requirements of a `CTAButton` used individually.
    ///     - PaddingType.stacked configures the layout so a `CTAButtonStack` can handle spacing requirements for `CTAButtons` used together.
    ///     - PaddingType.manualPadding configures the layout with zero padding on the element allowing for a manualPadding application of padding on the elemnt.
    /// Using anything other than PaddingType.stacked in a `CTAButtonStack` can lead to unexptected behavior not defined by the `CTAButtonStack` documentation.
    internal struct CTAButtonModifier: ViewModifier {
        @EnvironmentObject var themeManager: ThemeManager
        
        // reflects theme CTAButtonConfiguration types
        enum Style {
            case primary
            case secondary
            case borderless
            case primaryAlert
            case destructive
        }
        
        // PaddingTypes define specific padding for single buttons or adjust the padding for buttons when they are stacked.
        // This lets us efficiently handle layout variations without proliferating multiple views or components.
        enum PaddingType {
            case single
            case stacked
            case manualPadding // Use `manualPadding` for explicit, non-standard padding needs. This option removes default padding, giving the developer control. Should be used with caution and understanding of layout implications.
            
            func padding(style: CTAButtonStyle) -> EdgeInsets {
                switch self {
                case .single:
                    return style.padding
                case .stacked:
                    return EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0)
                case .manualPadding:
                    return EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0)
                }
            }
        }

        var style: Style
        var padding: PaddingType
        @Binding var isDisabled: Bool

        // gets CTAButtonStyle for 'style' type passed in.
        private var configuration: CTAButtonStyle {
            switch style {
            case .primary:
                return themeManager.theme.cTAButtonStyles.primaryButtonStyle
            case .secondary:
                return themeManager.theme.cTAButtonStyles.secondaryButtonStyle
            case .borderless:
                return themeManager.theme.cTAButtonStyles.borderlessButtonStyle
            case .primaryAlert:
                return themeManager.theme.cTAButtonStyles.alert
            case .destructive:
                return themeManager.theme.cTAButtonStyles.destructiveButtonStyle
            }
        }

        func body(content: Content) -> some View {
            #if DEBUG
            if padding == .manualPadding {
                debugPrint("Warning: `manualPadding` used for \(style). This should be done with caution.")
            }
            #endif
            
            return content
                .buttonStyle(CustomCTAButtonStyle(style: configuration, isDisabled: $isDisabled))
                .padding(padding.padding(style: configuration))
        }
    }
}
