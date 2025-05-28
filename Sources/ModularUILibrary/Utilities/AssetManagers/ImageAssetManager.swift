//
//  ImageAssetManager.swift
//
//
//  Created by Arturo Aguilar on 2/17/24.
//

import SwiftUI
import Combine

/// Manages retrieval of image assets based on the current theme or customization requirements.
/// Utilizes a singleton pattern to ensure consistent access across the application.
class ImageAssetManager: ObservableObject {
    // Holds the current image group which provides images according to the current theme or customization.
    @Published private(set) var imageGroup: ImageGroupProtocol

    // Default bundle falls back to package
    init(imageBundle: Bundle = Bundle.module) {
        self.imageGroup = ImageGroup(imageBundle: imageBundle)
    }
    
    // Retrieves an image based on the specified identifier.
    func getImage(imageIdentifier: ImageIdentifier) -> Image {
        imageGroup.image(for: imageIdentifier)
    }
    
    

    // Sets the bundle to use for fetching images, allowing for dynamic theme changes.
    func setBundle(_ bundle: Bundle) {
        self.imageGroup = ImageGroup(imageBundle: bundle)
    }
}
