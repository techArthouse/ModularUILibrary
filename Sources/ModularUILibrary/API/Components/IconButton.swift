//
//  IconButton.swift
//
//
//  Created by Arturo Aguilar on 2/17/24.
//

import SwiftUI

/// `IconButton` is a SwiftUI view component that represents a button with an icon.
/// The icon is fetched and managed by `ImageAssetManager` using an `ImageIdentifier`.
/// It is designed to be used as a building block for button components throughout the app.
///
/// Parameters:
///   - icon: The `ImageIdentifier` for the icon to be displayed on the button.
///   - isDisabled: A `Binding<Bool>` that determines if the button is interactive or disabled.
///   - action: The closure executed when the button is tapped.
///
/// The button is styled according to the app's design language and adjusts its appearance when disabled.
/// Accessibility is taken into account with an appropriate label for screen readers.
public struct IconButton: IconButtonProtocol {
    public var icon: ImageIdentifier
    public var isDisabled: Binding<Bool>
    public var action: () -> Void
    @EnvironmentObject var themeManager: ThemeManager

    public init(icon: ImageIdentifier, isDisabled: Binding<Bool>, action: @escaping () -> Void) {
        self.icon = icon
        self.isDisabled = isDisabled
        self.action = action
    }
    
    public var body: some View {
        Button(action: action) {
            themeManager.imageAssetManager.getImage(imageIdentifier: icon)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
//                    .frame(width: 24, height: 24)
                    .accessibility(label: Text("Button: \(icon.assetName)"))
                    .foregroundColor(Color.black)
        }
        .disabled(isDisabled.wrappedValue)
    }
}

/// `ToggleIconButton` is a specialized `IconButton` that toggles between two states: "on" and "off".
/// It swaps the icon based on the `isSelected` state to visually represent the toggle state.
///
/// Parameters:
///   - iconOn: The `ImageIdentifier` for the icon to be displayed when the button is in the "on" state.
///   - iconOff: The `ImageIdentifier` for the icon to be displayed when the button is in the "off" state.
///   - isDisabled: A `Binding<Bool>` that determines if the button is interactive or disabled.
///   - isSelected: A `Binding<Bool>` representing the current toggle state of the button.
///   - action: The closure executed when the toggle state changes.
///
/// This component is used for creating on/off switches in user interfaces, providing a visual cue for the toggle state.
public struct ToggleIconButton: IconButtonProtocol {
    public let iconOn: ImageIdentifier
    public let iconOff: ImageIdentifier
    public var isDisabled: Binding<Bool>
    public var isSelected: Binding<Bool> // Made public to allow external access
    public let action: () -> Void

    public init(iconOn: ImageIdentifier, iconOff: ImageIdentifier, isDisabled: Binding<Bool>, isSelected: Binding<Bool>, action: @escaping () -> Void) {
        self.iconOn = iconOn
        self.iconOff = iconOff
        self.isDisabled = isDisabled
        self.isSelected = isSelected // Correct assignment
        self.action = action
    }

    public var body: some View {
        IconButton(icon: isSelected.wrappedValue ? iconOff: iconOn, isDisabled: isDisabled, action: action)
    }
}


/// `PushIconButton` is another specialized `IconButton` that behaves like a push button.
/// It triggers an action on both press and release, allowing for different interactions depending on the gesture.
///
/// Parameters:
///   - iconOn: The `ImageIdentifier` for the icon to be displayed when the button is in the "on" state.
///   - iconOff: The `ImageIdentifier` for the icon to be displayed when the button is in the "off" state.
///   - isDisabled: A `Binding<Bool>` that determines if the button is interactive or disabled.
///   - isSelected: A `Binding<Bool>` representing the current toggle state of the button.
///   - action: The closure executed when the button is pressed and released.
///
/// The `PushIconButton` provides an interface for buttons that require a press-and-hold interaction,
/// commonly used for actions that require a confirmation or a delay before activation.
public struct PushIconButton: IconButtonProtocol {
    public let iconOn: ImageIdentifier
    public let iconOff: ImageIdentifier
    public var isDisabled: Binding<Bool>
    public var isSelected: Binding<Bool>
    public let action: () -> Void

    // Public initializer
    public init(iconOn: ImageIdentifier, iconOff: ImageIdentifier, isDisabled: Binding<Bool>, isSelected: Binding<Bool>, action: @escaping () -> Void) {
        self.iconOn = iconOn
        self.iconOff = iconOff
        self.isDisabled = isDisabled
        self.isSelected = isSelected
        self.action = action
    }

    public var body: some View {
        IconButton(icon: isSelected.wrappedValue ? iconOff: iconOn, isDisabled: isDisabled, action: action)
            .onLongPressGesture(minimumDuration: 0, pressing: { isPressing in
                if isPressing {
                    // Handle press down action
                    action()
                }
            }, perform: {
                // Handle release action if needed
            })
    }
}



/// `CustomButtonStyle` is a modifier for Button views that applies a custom style defined by the `IconButtonStyle` struct.
/// This style encapsulates various visual properties such as padding, background color, foreground color, and corner radius.
/// The style adapts to the button's state—default, disabled, and pressed—providing a consistent visual feedback across the app.
///
/// Parameters:
///   - style: An `IconButtonStyle` struct that defines the visual properties of the button.
///   - isDisabled: A `Binding<Bool>` that indicates whether the button is disabled. A disabled button has a different appearance and does not trigger actions.
///
/// The `makeBody` method applies the style properties to the button's label, adapting the appearance based on the button's state.
/// It uses a combination of SwiftUI's `background`, `foregroundColor`, `cornerRadius`, and `scaleEffect` modifiers to achieve the desired style.
///
/// The `isPressed` state is used to slightly scale down the button when pressed to provide tactile feedback to the user.
///
/// Example Usage:
/// ```
/// Button("Tap me!") {
///     print("Button tapped!")
/// }
/// .buttonStyle(CustomButtonStyle(style: IconButtonStyle(...), isDisabled: $isDisabled))
/// ```
///
/// Note: Ensure that the `IconButtonStyle` provided to this style has been initialized with the correct properties to reflect the desired appearance for all button states.
struct CustomButtonStyle: ButtonStyle {
    var style: IconButtonStyle
    @Binding var isDisabled: Bool
    @EnvironmentObject var themeManager: ThemeManager

    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .padding(style.padding)
            .background(themeManager.colorAssetManager.getColor(isDisabled ? style.disabledBackgroundColor : (configuration.isPressed ? style.highlightedBackgroundColor : style.backgroundColor)))
            .foregroundColor(themeManager.colorAssetManager.getColor(isDisabled ? style.disabledForegroundColor : (configuration.isPressed ? style.highlightedForegroundColor : style.foregroundColor)))
            .cornerRadius(style.isRound ? style.cornerRadius : 0)
            .scaleEffect(configuration.isPressed ? 0.97 : 1.0)
    }
}



struct IconButton_Previews: PreviewProvider {
    struct PreviewWrapper: View {
        @ObservedObject var themeManager: ThemeManager = ThemeManager()
        @State private var isDisabled: Bool = false
        @State private var isToggleSelected: Bool = false
        @State private var isToggleSelected2: Bool = false
        @State private var isSelected: Bool = false

        var body: some View {
            ScrollView {
                VStack(spacing: 20) {
                    
                    // Standard Icon Button
                    Section(header: Text("Standard Icon Button (with background)").font(.headline)) {
                        IconButton(icon: .preset(.speakerIconOn), isDisabled: $isDisabled) {
                            print("You pressed a STANDARD icon button")
                        }
                        .asStandardIconButtonStyle()
                        .background(Color.red.opacity(0.2))
                    }
                    
                    // Toggle Icon Button - Standard Style
                    Section(header: Text("Toggle Icon Button - Standard Style").font(.headline)) {
                        ToggleIconButton(iconOn: .preset(.speakerIconOn), iconOff: .preset(.speakerIconOff), isDisabled: $isDisabled, isSelected: $isToggleSelected) {
                            isToggleSelected.toggle()
                            print("You pressed a TOGGLE icon button")
                        }
                        .asStandardIconButtonStyle()
                    }
                    
                    // Toggle Icon Button - Panel Style with Text
                    Section(header: Text("Toggle Icon Button - Panel Style with Text").font(.headline)) {
                        ToggleIconButton(iconOn: .preset(.speakerIconOn), iconOff: .preset(.speakerIconOff), isDisabled: $isDisabled, isSelected: $isToggleSelected2) {
                            isToggleSelected2.toggle()
                            print("You pressed a TOGGLE icon button with text")
                        }
                        .asPanelIconButtonStyle(with: "Toggle")
                    }
                    
                    // Push Icon Button - Floating Action Style
                    Section(header: Text("Push Icon Button - Floating Action Style").font(.headline)) {
                        PushIconButton(iconOn: .preset(.speakerIconOn), iconOff: .preset(.speakerIconOff), isDisabled: $isDisabled, isSelected: $isSelected) {
                            isSelected.toggle()
                            print("You pressed a PUSH icon button")
                        }
                        .asFloatingActionButtonStyle()
                    }
                    
                    // Disabled State Example
                    Section(header: Text("Icon Button in Disabled State").font(.headline)) {
                        IconButton(icon: .preset(.speakerIconOn), isDisabled: .constant(true)) {
                            print("This button is disabled")
                        }
                        .asStandardIconButtonStyle()
                    }
                    
                }
                .padding()
            }
            .environmentObject(themeManager)
        }
    }
    
    static var previews: some View {
        PreviewWrapper()
    }
}
