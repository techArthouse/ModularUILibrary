//
//  ThemeManager.swift
//
//
//  Created by Arturo Aguilar on 3/4/24.
//

import Combine
import SwiftUI

/// The `ThemeManager` serves as the environment object that dynamically handles the current theme governing all styles.
/// It facilitates changing themes and managing asset bundles for both images and colors.
public class ThemeManager: ObservableObject {
    @Published var theme: ThemeProtocol // Holds the current theme
    @Published var imageAssetManager: ImageAssetManager
    @Published var colorAssetManager: ColorAssetManager
    
    /// Allows injecting a specific image asset bundle, and color assets or falls back to package assets
    /// - Parameter imageAssetBundle: Bundle containing the image assets for the theme.
    public init(imageAssetBundle: Bundle? = nil, colorAssetBundle: Bundle? = nil) {
        self.imageAssetManager = ImageAssetManager(imageBundle: imageAssetBundle ?? Bundle.module)
        self.colorAssetManager = ColorAssetManager(colorBundle: colorAssetBundle ?? Bundle.module)
        self.theme = ModularUITheme3()
    }
    
    /// Example function demonstrating how to change the image asset bundle.
    private func changeImageAssetBundle(to bundle: Bundle) {
        self.imageAssetManager = ImageAssetManager(imageBundle:bundle)
    }

    public func toggleTheme(_ imageBundle: Bundle? = nil) {
        changeImageAssetBundle(to: imageBundle ?? Bundle.module)
    }
}

