//
//  SwiftUIView.swift
//  
//
//  Created by Arturo Aguilar on 3/4/24.
//

import SwiftUI

protocol ImageGroupProtocol {
    var imageBundle: Bundle { get }
    init(imageBundle: Bundle)
    func image(for identifier: ImageIdentifier) -> Image
}

extension ImageGroupProtocol {
    func image(for identifier: ImageIdentifier) -> Image {
        switch identifier {
        case .preset(_):
            return Image(identifier.assetName, bundle: imageBundle)
        case .custom(_):
            return Image(identifier.assetName, bundle: Bundle.main)
        }
    }
}

