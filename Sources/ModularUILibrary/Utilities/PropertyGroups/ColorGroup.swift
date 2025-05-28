//
//  File.swift
//  
//
//  Created by Arturo Aguilar on 2/18/24.
//

import SwiftUI

public struct ColorGroupIdentifier {
    public static var containerPrimaryPressedColor: UniqueColor { .MyQ3Platinum }
    public static var containerSecondaryPressedColor: UniqueColor { .MyQ3Sky }
    public static var primaryColor: UniqueColor { .MyQ3Azure }
    public static var alertPrimaryColor: UniqueColor { .MyQ3Ochre }
    public static var secondaryColor: UniqueColor { .MyQ3Prussian }
    public static var tertiaryColor: UniqueColor { .MyQ3Charcoal }
    public static var destructiveColor: UniqueColor { .MyQ3Chili }
    public static var feedbackSuccessColor: UniqueColor { .MyQ3Azure }
    public static var feedbackFailureColor: UniqueColor { .MyQ3Chili }
    public static var feedbackWarningColor: UniqueColor { .MyQ3Ochre }
    public static var disabledPrimaryColor: UniqueColor { .MyQ3Slate }
    public static var disabledSecondaryColor: UniqueColor { .MyQ3Sky }
    public static var supportColor: UniqueColor { .MyQ3Ochre }
    public static var iconPrimaryColor: UniqueColor { .MyQ3Charcoal }
    public static var iconSecondaryColor: UniqueColor { .MyQ3Azure }
    public static var iconPrimaryInverseColor: UniqueColor { .MyQ3PureWhite }
    public static var pagePrimaryColor: UniqueColor { .MyQ3PureWhite }
    public static var pageSecondaryColor: UniqueColor { .MyQ3Eggshell }
    public static var iconBackgroundPrimaryColor: UniqueColor { .MyQ3Slate }
    public static var iconBackgroundSecondaryColor: UniqueColor { .MyQ3Azure }
    public static var containerPrimaryColor: UniqueColor { .MyQ3PureWhite }
    public static var containerSecondaryColor: UniqueColor { .MyQ3Eggshell }
    public static var containerTertiaryColor: UniqueColor { .MyQ3Sky }
    public static var statusWarningColor: UniqueColor { .MyQ3Ochre }
    public static var statusHealthyColor: UniqueColor { .MyQ3Emerald }
    public static var statusErrorColor: UniqueColor { .MyQ3Chili }
    public static var brandPrimaryColor: UniqueColor { .MyQ3Azure }
    public static var brandSecondaryColor: UniqueColor { .MyQ3Prussian }
    public static var buttonPrimaryColor: UniqueColor { .MyQ3Azure }
    public static var buttonPrimaryInverseColor: UniqueColor { .MyQ3PureWhite }
    public static var buttonSecondaryColor: UniqueColor { .MyQ3Sky }
    public static var buttonPressedColor: UniqueColor { .MyQ3Prussian }
    public static var linkColor: UniqueColor { .MyQ3Azure }
    public static var textPrimaryColor: UniqueColor { .MyQ3Charcoal }
    public static var textPrimaryInverseColor: UniqueColor { .MyQ3PureWhite }
    public static var textSecondaryColor: UniqueColor { .MyQ3Azure }
    public static var pageDividerColor: UniqueColor { .MyQ3Thunder }
    public static var containerDividerColor: UniqueColor { .MyQ3Thunder }
    public static var navigationButtonColor: UniqueColor { .MyQ3Azure }
    public static var navigationLabelColor: UniqueColor { .MyQ3Charcoal }
    public static var containerShadowColor: UniqueColor { .MyQ3PureBlack }
    public static var partnerAmazonColor: UniqueColor { .MyQ3amazonDelivery }
    public static var partnerWalmartColor: UniqueColor { .MyQ3walmart }
    public static var alertColor: UniqueColor { .MyQ3Chili }
    public static var subtextColor: UniqueColor { .MyQ3Smoke }
    public static var pureBlackColor: UniqueColor { .MyQ3PureBlack }
    public static var pureWhiteColor: UniqueColor { .MyQ3PureWhite }
    public static var toastAlertIconColor: UniqueColor { .MyQ3Ochre }
    public static var toastErrorIconColor: UniqueColor { .MyQ3Chili }
    public static var toastInfoIconColor: UniqueColor { .MyQ3Azure }
    public static var toastAcknowledgmentIconColor: UniqueColor { .MyQ3Azure }
    public static var inputFieldBoderColor: UniqueColor { .MyQ3Charcoal }
    public static var inputFieldActiveBorderColor: UniqueColor { .MyQ3Azure }
    public static var inputFieldErrorBorderColor: UniqueColor { .MyQ3Chili }
    public static var brandCompatibilityPrimaryColor: UniqueColor { .MyQ3Pineapple }
    public static var brandCompatibilitySecondaryColor: UniqueColor { .MyQ3walmart }
    public static var clear: UniqueColor { .clear }
    
}

public enum UniqueColor: String {
    case MyQ3Platinum
    case MyQ3Sky
    case MyQ3Azure
    case MyQ3Ochre
    case MyQ3Prussian
    case MyQ3Charcoal
    case MyQ3Chili
    case MyQ3Slate
    case MyQ3Emerald
    case MyQ3PureWhite
    case MyQ3Eggshell
    case MyQ3Thunder
    case MyQ3PureBlack
    case MyQ3amazonDelivery
    case MyQ3walmart
    case MyQ3Smoke
    case MyQ3Pineapple
    case clear // this might pose an issue. Investigate if clear as a string yields same clear from Color.clear
}


///// brand compatibility primary color.
//public var brandCompatibilitySecondaryColor: Color {
//    Color.white.opacity(0.7)
//}
