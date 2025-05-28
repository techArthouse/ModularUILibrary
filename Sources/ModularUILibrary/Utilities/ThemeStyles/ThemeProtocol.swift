//
//  ThemeProtocol.swift
//  
//
//  Created by Aguilar, Arturo on 1/7/24.
//

import SwiftUI

/// `ThemeProtocol` closely follows the theme structure and standardization implemented by Theme.swift which is itself a UIKit centric implementation.
/// As such ThemeProtocol provides a collection of unique styles, colors and assets that are designed to describe the appearance of
/// composable ui elements defined by the design team. Each set of similar UI components such as `CTAButton` types, labels, etc are grouped together,
/// and each instance of a component style is a variation of the element that is standardized across the app.
/// Example:
///     - `CTAButton` styles are defined in a `CTAButtonStyleGroup`
///     - A `CTAButtonStyleGroup` contains the 5 base `CTAButton` styles
///         - "Primary CTA", "Primary Alert CTA", "Secondary CTA", "Borderless CTA", "Destructive CTA"
protocol ThemeProtocol {
    var cTAButtonStyles: CTAButtonStyleGroupProtocol { get }
    var iconButtonStyles: IconButtonStyleProtocol { get }
    
    // more added incrementally... sooon
}

struct CTAButtonStyle {
    // Note: as we add more styles, we might need to convert to protocl so each theme can define own defaults
    static let defaultCornerRadius: CGFloat = 20
    static let defaultPadding: EdgeInsets = EdgeInsets(top: 40, leading: 24, bottom: 40, trailing: 24)
    static let defaultBorderWidth: CGFloat = 0
    static let defaultBorderColor: UniqueColor = .clear
    
    var backgroundColor: UniqueColor
    var foregroundColor: UniqueColor
    var highlightedBackgroundColor: UniqueColor
    var highlightedForegroundColor: UniqueColor
    var disabledBackgroundColor: UniqueColor
    var disabledForegroundColor: UniqueColor
    var font: Font
    var borderColor: UniqueColor = defaultBorderColor
    var disabledBorderColor: UniqueColor?
    var borderWidth: CGFloat = defaultBorderWidth
    var cornerRadius: CGFloat = defaultCornerRadius
    var padding: EdgeInsets = defaultPadding
}

protocol CTAButtonStyleGroupProtocol {
    var primaryButtonStyle: CTAButtonStyle { get }
    var alert: CTAButtonStyle { get }
    var secondaryButtonStyle: CTAButtonStyle { get }
    var borderlessButtonStyle: CTAButtonStyle { get }
    var destructiveButtonStyle: CTAButtonStyle { get }
}

public struct IconButtonStyle {
    // Note: as we add more styles, we might need to convert to protocl so each theme can define own defaults
    static let defaultCornerRadius: CGFloat = 20
    static let defaultPadding: EdgeInsets = EdgeInsets(top: 8, leading: 8, bottom: 8, trailing: 8)
    static let defaultBorderWidth: CGFloat = 0
    static let defaultBorderColor: UniqueColor = .clear
    
    var isRound: Bool = true
    var backgroundColor: UniqueColor
    var foregroundColor: UniqueColor
    var highlightedBackgroundColor: UniqueColor
    var highlightedForegroundColor: UniqueColor
    var disabledBackgroundColor: UniqueColor
    var disabledForegroundColor: UniqueColor
    var font: Font
    var borderColor: UniqueColor = defaultBorderColor
    var disabledBorderColor: UniqueColor?
    var borderWidth: CGFloat = defaultBorderWidth
    var cornerRadius: CGFloat = defaultCornerRadius
    var padding: EdgeInsets = defaultPadding
}

protocol IconButtonStyleProtocol {
    var iconButtonStyle: IconButtonStyle { get }
    var panelButtonStyle: IconButtonStyle { get }
}

struct ThemeKey: EnvironmentKey {
    static let defaultValue: ThemeProtocol = ModularUITheme3()
}

extension EnvironmentValues {
    var theme: ThemeProtocol {
        get { self[ThemeKey.self] }
        set { self[ThemeKey.self] = newValue }
    }
}

// Debug flag

struct DebugColorsKey: EnvironmentKey {
    static let defaultValue: Bool = false
}

extension EnvironmentValues {
    var debugColors: Bool {
        get { self[DebugColorsKey.self] }
        set { self[DebugColorsKey.self] = newValue }
    }
}
