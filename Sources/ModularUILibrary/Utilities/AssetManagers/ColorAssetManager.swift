//
//  ColorAssetManager.swift
//
//
//  Created by Arturo Aguilar on 2/17/24.
//

import SwiftUI
import Combine

/// Manages retrieval of color assets based on the current theme or customization requirements.
class ColorAssetManager: ObservableObject {
    @Published public var colorBundle: Bundle

    // Default bundle falls back to package
    init(colorBundle: Bundle = Bundle.main) {
        self.colorBundle = colorBundle
    }

    // Provides access to the current color group for fetching colors.
    func getColor(_ color: UniqueColor) -> Color {
        Color(color.rawValue, bundle: colorBundle)
    }

    // Sets the bundle to use for fetching colors, allowing for dynamic theme changes.
    func setBundle(_ bundle: Bundle) {
        self.colorBundle = bundle
    }
}
