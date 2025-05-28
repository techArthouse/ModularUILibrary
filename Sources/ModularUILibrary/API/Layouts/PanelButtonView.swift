//
//  PanelButtonView.swift
//
//
//  Created by Arturo Aguilar on 3/1/24.
//

import SwiftUI
import Combine

/// `PanelButtonViewModel` serves as the view model for `PanelButtonView`, managing the state 
/// and behavior of a collection of panel buttons.
class PanelButtonViewModel: ObservableObject {
    
    /// Defines the types of panel buttons and their associated behavior.
    enum PanelButtonType {
        case standard(String, ImageIdentifier, () -> Void)
        case toggle(String, ImageIdentifier, ImageIdentifier, () -> Void)
        case push(String, ImageIdentifier, ImageIdentifier, () -> Void)
        
        /// Enum to represent the behavior of a button, used to configure the button's view in the UI.
        enum Behavior {
            case standard, toggle, push
        }
        
        /// Computes the behavior of the panel button based on its type.
        var behavior: Behavior {
            switch self {
            case .standard:
                return .standard
            case .toggle:
                return .toggle
            case .push:
                return .push
            }
        }
    }
    
    /// Configuration for an individual panel button, encapsulating its state and behavior.
    struct PanelButtonConfiguration {
        let id: UUID = UUID()
        let behavior: PanelButtonType.Behavior
        let text: String
        let iconOn: ImageIdentifier
        let iconOff: ImageIdentifier
        var isDisabled: Bool = false
        var isSelected: Bool = false
        let action: (() -> Void)
    }

    /// Array to hold the configurations for all panel buttons managed by this view model.
    @Published var panelButtonConfigurations: [PanelButtonConfiguration] = []

    /// Initializes the view model with a set of panel buttons, configuring each based on its type.
    /// - Parameter panelButtons: An array of `PanelButtonType` representing the buttons to manage.
    init(panelButtons: [PanelButtonType]) {
        panelButtons.forEach({ type in
            switch type {
            case .standard(let text, let iconOn, let action):
                panelButtonConfigurations.append(
                    PanelButtonConfiguration(behavior: .standard, text: text, iconOn: iconOn, iconOff: iconOn, action: action))
            case .toggle(let text, let iconOn, let iconOff, let action):
                panelButtonConfigurations.append(
                    PanelButtonConfiguration(behavior: .toggle, text: text, iconOn: iconOn, iconOff: iconOff, action: action))
            case .push(let text, let iconOn, let iconOff, let action):
                panelButtonConfigurations.append(
                    PanelButtonConfiguration(behavior: .push, text: text, iconOn: iconOn, iconOff: iconOff, action: action))
            }
        })
    }
    
    /// Toggles the `isSelected` state of the button with the given ID.
    /// This method directly modifies the `isSelected` property of the `PanelButtonConfiguration` instance,
    /// triggering UI updates as required.
    /// - Parameter id: The UUID of the button to toggle.
    func toggleButton(id: UUID) {
        guard let index = panelButtonConfigurations.firstIndex(where: { $0.id == id }) else { return }
        panelButtonConfigurations[index].isSelected.toggle()
    }
}


/// A `PanelButtonView` dynamically displays a collection of toggle buttons based on the provided `PanelButtonViewModel`.
/// It supports both horizontal and vertical layouts, allowing for flexible UI design within the constraints
///
/// The view utilizes `@ObservedObject` to listen for changes in the `PanelButtonViewModel`, ensuring the UI updates in response to state changes.
/// This reactive design pattern facilitates a clear separation of concerns between the view's presentation logic and its state management, which is handled by the `PanelButtonViewModel`.
///
/// Each toggle button within the `PanelButtonView` is generated using the `ForEach` construct, iterating over the `panelButtonConfigurations` array within the provided view model.
/// This array defines the configuration for each button, including its icons for the "on" and "off" states, disabled state, and selection state.
/// Actions associated with each button, such as toggling the selected state, are handled by the view model to maintain a single source of truth for the UI state.
///
/// Usage:
/// This view should be instantiated with a `PanelButtonViewModel`. The view model should be configured with the necessary button configurations prior to usage.
/// Failure to provide a configured view model will result in an empty view.
///
/// Note:
/// - This view is designed to be flexible and reusable within the constraints
/// - Each icon based component in the `PanelButtonView` is future-proofed to allow for potential internal state management of the `isSelected` property by the buttons themselves.
///   This is achieved through custom `Binding` logic provided to each icon button type.
///
/// Example:
///     PanelButtonView(viewModel: PanelButtonViewModel( panelButtons: [
///     .toggle(.preset(.speakerIconOn), .preset(.speakerIconOff), { print{"some action") }),
///     .toggle(.preset(.speakerIconOn), .preset(.speakerIconOff), { print{"some other action") }))
///     ]))
struct PanelButtonView: View {
    @ObservedObject var viewModel: PanelButtonViewModel
    
    private var computedEdgeInsets: EdgeInsets {
        let count = viewModel.panelButtonConfigurations.count
        let horizontalPadding: CGFloat = count == 5 ? 24 : (count == 4 ? 32 : 40)

        return EdgeInsets(top: 8, leading: horizontalPadding, bottom: 24, trailing: horizontalPadding)
    }

    var body: some View {
        HStack(spacing: 0) {
            ForEach(Array(viewModel.panelButtonConfigurations.enumerated()), id: \.element.id) { index, config in
                switch config.behavior {
                case .standard:
                    IconButton(
                        icon: config.iconOn,
                        isDisabled: Binding(
                            get: { config.isDisabled },
                            set: { _ in viewModel.toggleButton(id: config.id) } // Future-proofed to allow for potential internal state management
                        )
                    ) {
                        config.action()
                    }.asPanelIconButtonStyle(with: config.text)
                case .toggle:
                    ToggleIconButton(
                        iconOn: config.iconOn,
                        iconOff: config.iconOff,
                        isDisabled: Binding(
                            get: { config.isDisabled },
                            set: { _ in viewModel.toggleButton(id: config.id) } // Future-proofed to allow for potential internal state management
                        ),
                        isSelected: Binding(
                            get: { config.isSelected },
                            set: { _ in viewModel.toggleButton(id: config.id) } // Future-proofed to allow for potential internal state management
                        )
                    ) {
                        viewModel.toggleButton(id: config.id)
                        config.action()
                    }.asPanelIconButtonStyle(with: config.text)
                case .push:
                    PushIconButton(
                        iconOn: config.iconOn,
                        iconOff: config.iconOff,
                        isDisabled: Binding(
                            get: { config.isDisabled },
                            set: { _ in
                                viewModel.toggleButton(id: config.id)
                                print("push icon in panel view is writing isDisabled")
                            }  // Future-proofed to allow for potential internal state management
                        ),
                        isSelected: Binding(
                            get: { config.isSelected },
                            set: { _ in
                                viewModel.toggleButton(id: config.id)
                                print("push icon in panel view is writing isSelected")
                            } // Future-proofed to allow for potential internal state management
                        )
                    ) {
                        viewModel.toggleButton(id: config.id)
                        config.action()
                    }.asPanelIconButtonStyle(with: config.text)
                }
                
                // Adds a spacer between buttons, but not after the last button, to reflect "auto".
                // defines the space between buttons in a panel as "auto".
                if index < viewModel.panelButtonConfigurations.count - 1 {
                    Spacer()
                                }
            }
        }.padding(computedEdgeInsets)
    }
}

struct PanelButtonView_Previews: PreviewProvider {
    struct PreviewWrapper: View {
        @ObservedObject var themeManager: ThemeManager = ThemeManager()
        
        var body: some View {
            ScrollView {
                VStack(spacing: 20) {
                    // Standard Icon Buttons
                    Text("Standard Icon Buttons")
                        .font(.headline)
                        .padding(.top)
                    
                    PanelButtonView(viewModel: PanelButtonViewModel(panelButtons: [
                        .standard("First", .preset(.collapseArrowIcon), { print("Standard in First panel button action fired") }),
                        .standard("Second", .preset(.speakerIconOn), { print("Standard in Second panel button action fired") }),
                        .standard("Third", .preset(.speakerIconOn), { print("Standard in Third panel button action fired") }),
                        .standard("Fourth", .preset(.speakerIconOn), { print("Standard in Fourth panel button action fired") }),
                        .standard("Fifth", .preset(.collapseArrowIcon), { print("Standard in Fifth panel button action fired") })
                    ]))
                    
                    // Toggle Icon Buttons
                    Text("Toggle Icon Buttons")
                        .font(.headline)
                    
                    PanelButtonView(viewModel: PanelButtonViewModel(panelButtons: [
                        .toggle("First", .preset(.speakerIconOn), .preset(.speakerIconOff), { print("Toggle in First panel button action fired") }),
                        .push("Second", .preset(.speakerIconOn), .preset(.speakerIconOff), { print("Toggle in Second panel button action fired") }),
                        .toggle("Third", .preset(.speakerIconOn), .preset(.speakerIconOff), { print("Toggle in Third panel button action fired") }),
                        .toggle("Fourth", .preset(.speakerIconOn), .preset(.speakerIconOff), { print("Toggle in Fourth panel button action fired") })
                    ]))
                    
                    // Push Icon Buttons
                    Text("Push Icon Buttons")
                        .font(.headline)
                    
                    PanelButtonView(viewModel: PanelButtonViewModel(panelButtons: [
                        .push("First", .preset(.speakerIconOn), .preset(.speakerIconOff), { print("Push in First panel button action fired") }),
                        .push("Second", .preset(.speakerIconOn), .preset(.speakerIconOff), { print("Push in Second panel button action fired") }),
                        .push("Third", .preset(.speakerIconOn), .preset(.speakerIconOff), { print("Push in Third panel button action fired") })
                    ]))
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
