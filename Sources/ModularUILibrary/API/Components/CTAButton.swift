//
//  CTAButton.swift
//
//
//  Created by Aguilar, Arturo on 1/7/24.
//

import SwiftUI

/// A base component view for a `CTAButton` Type. It describes the basic functionality that all CTAButton Types
/// share. A CTAButton, while generic, can be stylized using one of the modifiers found in CTAButtons.swift. It can
/// optionally be defined to use an icon provided that an ImageIdentifer exists for it.
/// Example:
///     CTAButton(title: "Primary Button With Icon",  icon: .preset(.navigateRightIcon)) {
///                 // Some action
///     }.asPrimaryButton()
struct CTAButton: View {
    let title: String
    let icon: ImageIdentifier?
    let action: () -> Void
    @Binding var isDisabled: Bool
    @EnvironmentObject var themeManager: ThemeManager

    init(title: String, isDisabled: Binding<Bool> = .constant(false), icon: ImageIdentifier? = nil, action: @escaping () -> Void) {
        self.title = title
        self.action = action
        self._isDisabled = isDisabled
        self.icon = icon
    }

    var body: some View {
        Button(action: action) {
            HStack {
                Text(title)
                    .accessibility(label: Text("Button: \(title)"))
                    .frame(minWidth: 0, maxWidth: .infinity, minHeight: 40)
                if let icon = self.icon {
                    themeManager.imageAssetManager.getImage(imageIdentifier: icon)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 24, height: 24)
                        .padding([.leading], 8)
                        .padding([.trailing], 16)
                }
            }
        }
        .disabled(isDisabled)
    }
    
    /// `CustomCTAButtonStyle` takes care of all the styling for a `CTAButton` Type. The stying is injected
    /// with a CTAButtonStyle. A CTAButtonStyle describes a CTAButton Type and
    /// a style is managed by a theme EnvironmentObject. (See: `ThemeManager`)
    /// Note it's internal nature as it only applies to CTAButton Types.
    internal struct CustomCTAButtonStyle: ButtonStyle {
        var style: CTAButtonStyle
        @Binding var isDisabled: Bool
        @EnvironmentObject var themeManager: ThemeManager

        /// This method is responsible for creating the view that represents the body of a button.
        /// It uses the configuration parameter to determine the current state of the button,
        /// and applies appropriate styling defined in the `style` property.
        func makeBody(configuration: Configuration) -> some View {
            configuration.label
                .font(style.font) // Apply the font style.
                .scaleEffect(configuration.isPressed ? 0.97 : 1.0) // Slightly reduce the size when pressed for a tactile feel.
                .animation(nil, value: configuration.isPressed) // Disable animation for the press state change.
                .foregroundColor(
                    themeManager.colorAssetManager.getColor(isDisabled ? style.disabledForegroundColor : (configuration.isPressed ? style.highlightedForegroundColor : style.foregroundColor))
                ) // Choose the color based on the button's state.
                .background(themeManager.colorAssetManager.getColor(isDisabled ? style.disabledBackgroundColor : (configuration.isPressed ? style.highlightedBackgroundColor : style.backgroundColor))) // Background color also depends on the button's state.
                .cornerRadius(style.cornerRadius) // Apply corner radius from the style.
                .overlay(
                    RoundedRectangle(cornerRadius: style.cornerRadius)
                        .stroke(themeManager.colorAssetManager.getColor(isDisabled ? (style.disabledBorderColor ?? style.borderColor) : style.borderColor), lineWidth: style.borderWidth) // Apply border based on the style and state.
                )
        }
    }
}

struct StyledButton_Previews: PreviewProvider {
    struct PreviewWrapper: View {
        let themeManager: ThemeManager = ThemeManager()
        @State private var isDisabled: Bool = false
        var body: some View {
            VStack(spacing: 0) {
                CTAButton(title: "Primary Button With Icon", isDisabled: $isDisabled, icon: .preset(.navigateRightIcon)) {
                    print("Primary  Button tapped")
                    themeManager.toggleTheme()
                }
                .asPrimaryButton()
                .onDisabledTapGesture(isDisabled: $isDisabled) {
                    print("Primary Button is now enabled")
                    isDisabled.toggle()
                }
                
                CTAButton(title: "Primary Alert Button") {
                    print("Primary Alert Button tapped")
                }
                .asPrimaryAlertButton()
                
                CTAButton(title: "Secondary Button") {
                    print("Secondary Button tapped")
                }
                .asSecondaryButton()
                
                CTAButton(title: "Borderless Button") {
                    print("Borderless Button tapped")
                }
                .asBorderlessButton()
                
                CTAButton(title: "Destructive Button") {
                    print("Destructive Button tapped and Primary Button Disabled")
                    isDisabled.toggle()
                }
                .asDestructiveButton()
            }
            .environmentObject(themeManager)
        }
    }
    
    static var previews: some View {
        PreviewWrapper()
    }
}
