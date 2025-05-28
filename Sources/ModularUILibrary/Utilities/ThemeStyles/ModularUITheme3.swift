//
//  ModularUITheme3.swift
//
//
//  Created by Aguilar, Arturo on 1/12/24.
//

import SwiftUI

/// `MyQTheme3` defines the theme
struct ModularUITheme3: ThemeProtocol {
    
    var cTAButtonStyles: CTAButtonStyleGroupProtocol
    var iconButtonStyles: IconButtonStyleProtocol
    
    init() {
        self.cTAButtonStyles = CTAButtonStyleGroup()
        self.iconButtonStyles = IconButtonStyleGroup()
    }
}


struct CTAButtonStyleGroup: CTAButtonStyleGroupProtocol {
    var primaryButtonStyle: CTAButtonStyle {
        // Define the primary button style using colors from the theme
        CTAButtonStyle(
            backgroundColor: ColorGroupIdentifier.primaryColor,
            foregroundColor: ColorGroupIdentifier.textPrimaryInverseColor,
            highlightedBackgroundColor: ColorGroupIdentifier.secondaryColor,
            highlightedForegroundColor: ColorGroupIdentifier.textPrimaryInverseColor,
            disabledBackgroundColor: ColorGroupIdentifier.disabledPrimaryColor,
            disabledForegroundColor: ColorGroupIdentifier.textPrimaryInverseColor,
            font: Font.system(size: 16, weight: .semibold)
        )
    }
    var alert: CTAButtonStyle {
        CTAButtonStyle(
            backgroundColor: ColorGroupIdentifier.alertPrimaryColor,
            foregroundColor: ColorGroupIdentifier.textPrimaryInverseColor,
            highlightedBackgroundColor: ColorGroupIdentifier.textPrimaryColor,
            highlightedForegroundColor: ColorGroupIdentifier.textPrimaryInverseColor,
            disabledBackgroundColor: ColorGroupIdentifier.disabledPrimaryColor,
            disabledForegroundColor: ColorGroupIdentifier.textPrimaryInverseColor,
            font: Font.system(size: 16, weight: .semibold)
        )
    }
    var secondaryButtonStyle: CTAButtonStyle {
        CTAButtonStyle(
            backgroundColor: ColorGroupIdentifier.buttonPrimaryInverseColor,
            foregroundColor: ColorGroupIdentifier.textPrimaryColor,
            highlightedBackgroundColor: ColorGroupIdentifier.textPrimaryColor,
            highlightedForegroundColor: ColorGroupIdentifier.textPrimaryInverseColor,
            disabledBackgroundColor: ColorGroupIdentifier.buttonPrimaryInverseColor,
            disabledForegroundColor: ColorGroupIdentifier.disabledPrimaryColor,
            font: Font.system(size: 16, weight: .semibold),
            borderColor: ColorGroupIdentifier.textPrimaryColor,
            disabledBorderColor: ColorGroupIdentifier.disabledPrimaryColor,
            borderWidth: 1.5
        )
    }
    
    var borderlessButtonStyle: CTAButtonStyle {
        CTAButtonStyle(
            backgroundColor: ColorGroupIdentifier.clear,
            foregroundColor: ColorGroupIdentifier.textPrimaryColor,
            highlightedBackgroundColor: ColorGroupIdentifier.clear,
            highlightedForegroundColor: ColorGroupIdentifier.secondaryColor,
            disabledBackgroundColor: ColorGroupIdentifier.clear,
            disabledForegroundColor: ColorGroupIdentifier.disabledPrimaryColor,
            font: Font.system(size: 16, weight: .semibold)
        )
    }
    
    var destructiveButtonStyle: CTAButtonStyle {
        CTAButtonStyle(
            backgroundColor: ColorGroupIdentifier.buttonPrimaryInverseColor,
            foregroundColor: ColorGroupIdentifier.destructiveColor,
            highlightedBackgroundColor: ColorGroupIdentifier.destructiveColor,
            highlightedForegroundColor: ColorGroupIdentifier.textPrimaryInverseColor,
            disabledBackgroundColor: ColorGroupIdentifier.buttonPrimaryInverseColor,
            disabledForegroundColor: ColorGroupIdentifier.disabledPrimaryColor,
            font: Font.system(size: 16, weight: .semibold),
            borderColor: ColorGroupIdentifier.destructiveColor,
            disabledBorderColor: ColorGroupIdentifier.disabledPrimaryColor,
            borderWidth: 1.5
        )
    }
}

struct IconButtonStyleGroup: IconButtonStyleProtocol {
    var iconButtonStyle: IconButtonStyle {
        IconButtonStyle(
            isRound: true,
            backgroundColor: ColorGroupIdentifier.containerPrimaryColor,
            foregroundColor: ColorGroupIdentifier.iconPrimaryColor,
            highlightedBackgroundColor: ColorGroupIdentifier.containerPrimaryColor,
            highlightedForegroundColor: ColorGroupIdentifier.buttonPressedColor,
            disabledBackgroundColor: ColorGroupIdentifier.containerPrimaryColor,
            disabledForegroundColor: ColorGroupIdentifier.disabledPrimaryColor,
            font: Font.system(size: 16, weight: .semibold)
        )
    }
    
    var panelButtonStyle: IconButtonStyle {
        IconButtonStyle(
            isRound: false,
            backgroundColor: ColorGroupIdentifier.containerPrimaryColor,
            foregroundColor: ColorGroupIdentifier.iconPrimaryColor,
            highlightedBackgroundColor: ColorGroupIdentifier.containerPrimaryColor,
            highlightedForegroundColor: ColorGroupIdentifier.buttonPressedColor,
            disabledBackgroundColor: ColorGroupIdentifier.containerPrimaryColor,
            disabledForegroundColor: ColorGroupIdentifier.disabledPrimaryColor,
            font: Font.system(size: 10, weight: .semibold),
            padding: EdgeInsets(top: 8, leading: 16, bottom: 24, trailing: 16)
        )
    }
}
