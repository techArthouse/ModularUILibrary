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

live demo

This component showcases how to build high-quality, stateful, and visually adaptive SwiftUI views that support composition, style inheritance, and scalable interaction design.
