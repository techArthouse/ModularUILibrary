## Overview of ModularUILibrary

**ModularUILibrary** is a SwiftUI-first component framework designed to support scalable UI development through a powerful theming engine and a versatile suite of reusable interface elements. It provides drop-in buttons, icon interactions, and layout primitives tailored for consistent and adaptive design systems.

This document outlines the core features and provides examples to help you get started quickly and confidently.

---

### 🎨 Theming Engine with `ThemeManager`

At the core of the library is the `ThemeManager`, a dynamic engine that facilitates real-time theme switching and asset resolution across your app. Supporting classes like `ImageAssetManager` and `ColorAssetManager` manage your branded images and color palettes, keeping styling consistent and modular.

**Quick Start:**

```swift
@main
struct MyApp: App {
    var themeManager = ThemeManager()

    var body: some Scene {
        WindowGroup {
            ContentView().environmentObject(themeManager)
        }
    }
}
```

### CTAButton Component

`CTAButton` offers flexibility and ease of use, with predefined styles for quick integration and options for customization.

**Key Features:**

- Modular design for reusability.
- Predefined and customizable styles via `ThemeManager`.
- Accessibility support.

**Usage Example:**

```swift
CTAButton(title: "Confirm") {
    // Action code
}.asPrimaryButton()
```
live demo (taken from preview available in CTAButtons.swift)




https://github.com/user-attachments/assets/c66b3de4-ba0d-435e-8fe3-8568e54381d1





### IconButton Suite

This suite includes `IconButton`, `ToggleIconButton`, and `PushIconButton`, each designed for specific user interactions and backed by `PanelButtonViewModel` for state management.

**Customization:**

Buttons can be customized with modifiers like `IconButtonStyleModifier`, allowing for theme-consistent styling.

### Practical Examples

**PanelButtonView Example:**

Use `PanelButtonView` with different button types.

```swift
PanelButtonView(viewModel: PanelButtonViewModel(panelButtons: [
    .toggle("First", .preset(.speakerIconOn), .preset(.speakerIconOff), { print("Toggle for First") })
    // Additional buttons...
]))
```

**IconButton Previews:**

Illustrates various `IconButton` types and their states.

```swift
IconButton(icon: .preset(.speakerIconOn)) {
    print("Standard IconButton tapped")
}.asStandardIconButtonStyle()
```

Some other applications using some variation of the icon and buttons include dynamic image switching


https://github.com/user-attachments/assets/3e49e5d3-3b96-49f0-8ddb-69515f909c59



**DeviceActuatorView**

DeviceActuatorView is a flexible, state-driven UI module that adapts its layout and visual density based on the CellSize configuration. It's ideal for dashboards, device control surfaces, or any scenario where responsiveness and modularity are key.

At its core, DeviceActuatorView uses:

A configurable CellSize enum to determine layout proportions.

A backing view model (DeviceActuatorViewModel) to synchronize state updates.

A nested Actuator component powered by IconButton for direct interaction.

A Header view that transitions between visual states smoothly.

The view dynamically resizes and rearranges itself according to the current CellSize, allowing seamless transitions between compact, medium, and full-detail modes. The DeviceActuatorViewConfig struct encapsulates spacing, font sizes, corner radii, icon dimensions, and header opacity logic for each size, ensuring alignment with the design system.

Example Preview:

```swift
DeviceActuatorView(size: .medium, device: myDevice)
    .environmentObject(ThemeManager())
    .frame(width: CellSize.medium.frameSize.width,
           height: CellSize.medium.frameSize.height)
```

live demo (taken from preview available in DeviceActuatorView.swift)


https://github.com/user-attachments/assets/6753ea06-e86b-4975-98b1-5a9fe4a571fa




This component showcases how to build high-quality, stateful, and visually adaptive SwiftUI views that support composition, style inheritance, and scalable interaction design.

For example, these are some other applications where the components like ctabuttons and iconimage variations modularly compose cells using DeviceActuator view for different purposes,
like adding a toggle to activate resizing or injecting a different color depending on state of the component.



https://github.com/user-attachments/assets/2d879f5c-157c-4a7a-bf67-dda4c44034a6

Here are other examples of using the base components and updating the imageicon to reflect lottie animations:



https://github.com/user-attachments/assets/cd07aaa5-e7d0-4438-ac16-fb81f439813d




https://github.com/user-attachments/assets/e3115480-b9cf-4c4c-ac1a-a27dd7fe2e55




