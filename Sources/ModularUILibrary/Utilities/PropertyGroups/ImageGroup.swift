//
//  ImageGroup.swift
//
//
//  Created by Arturo Aguilar on 3/4/24.
//

import SwiftUI


public struct ImageGroup: ImageGroupProtocol {
    public var imageBundle: Bundle
    
    // Initialize with a default bundle
    public init(imageBundle: Bundle = Bundle.main) {
        self.imageBundle = imageBundle
    }
}

public enum ImageIdentifier {
    case preset(DefaultImageAssetIdentifier)
    case custom(CustomImageIdentifierProtocol)
    
    
    var assetName: String {
        switch self {
        case .preset(let identifier):
            return identifier.rawValue
        case .custom(let name):
            return name.imageName
        }
    }
}

public enum DefaultImageAssetIdentifier: String {
    // MARK: - MyQ3StatefulButtonImages
    case battery0IconInverse = "battery0IconInverse"
    case battery0IconNormal = "battery0IconNormal"
    case battery1IconInverse = "battery1IconInverse"
    case battery1IconNormal = "battery1IconNormal"
    case battery2IconInverse = "battery2IconInverse"
    case battery2IconNormal = "battery2IconNormal"
    case battery3IconInverse = "battery3IconInverse"
    case battery3IconNormal = "battery3IconNormal"
    case battery4IconInverse = "battery4IconInverse"
    case battery4IconNormal = "battery4IconNormal"
    case battery5IconInverse = "battery5IconInverse"
    case battery5IconNormal = "battery5IconNormal"
    case microphoneIconMuted = "microphoneIconMuted"
    case microphoneIconUnmuted = "microphoneIconUnmuted"
    case speakerIconOff = "speakerIconOff"
    case speakerIconOn = "speakerIconOn"
    case wifi0IconInverse = "wifi0IconInverse"
    case wifi0IconNormal = "wifi0IconNormal"
    case wifi1IconInverse = "wifi1IconInverse"
    case wifi1IconNormal = "wifi1IconNormal"
    case wifi2IconInverse = "wifi2IconInverse"
    case wifi2IconNormal = "wifi2IconNormal"
    case wifi3IconInverse = "wifi3IconInverse"
    case wifi3IconNormal = "wifi3IconNormal"
    case linkIconBroken = "linkIconBroken"
    case linkIconUnconnected = "linkIconUnconnected"
    case linkIconConnected = "linkIconConnected"
    case wifiIconWeak = "wifiIconWeak"
    case wifiIconFair = "wifiIconFair"
    case wifiIconStrong = "wifiIconStrong"
    case checkmarkIconSelected = "checkmarkIconSelected"
    case checkmarkIconUnselected = "checkmarkIconUnselected"

    // MARK: - MyQ3StatelessButtonImages
    case collapseIcon = "collapseIcon"
    case dismissIcon = "dismissIcon"
    case exitIcon = "exitIcon"
    case backIcon = "backIcon"
    case expandIcon = "expandIcon"
    case firmwareUpdateIcon = "firmwareUpdateIcon"
    case leftIcon = "leftIcon"
    case maximizeIcon = "maximizeIcon"
    case minimizeIcon = "minimizeIcon"
    case minusIcon = "minusIcon"
    case notPlayableIcon = "notPlayableIcon"
    case pauseIcon = "pauseIcon"
    case playIcon = "playIcon"
    case plusIcon = "plusIcon"
    case resetIcon = "resetIcon"
    case reloadIcon = "reloadIcon"
    case rightIcon = "rightIcon"
    case scrubBackwardIcon = "scrubBackwardIcon"
    case scrubForwardIcon = "scrubForwardIcon"
    case settingsIcon = "settingsIcon"
    case skipNextIcon = "skipNextIcon"
    case skipPreviousIcon = "skipPreviousIcon"
    case snapshotIcon = "snapshotIcon"
    case expandArrowIcon = "expandArrowIcon"
    case collapseArrowIcon = "collapseArrowIcon"
    case batterySaverIcon = "batterySaverIcon"
    case callIcon = "callIcon"
    case powerIcon = "powerIcon"
    case arrowRightIcon = "arrowRightIcon"
    case arrowDownIcon = "arrowDownIcon"
    case arrowUpIcon = "arrowUpIcon"
    case navigateRightIcon = "navigateRightIcon"

    // MARK: - MyQ3Images
    case infoFillIcon = "infoFillIcon"
    case errorFillIcon = "errorFillIcon"
    case checkFillIcon = "checkFillIcon"
    case wifiRouterIcon = "wifiRouterIcon"
    case alertFillIcon = "alertFillIcon"
    case alertIconIcon = "alertIconIcon"
    case bluetoothIcon = "bluetoothIcon"
    case coldIcon = "coldIcon"
    case magnetIcon = "magnetIcon"
    case nightVisionIcon = "nightVisionIcon"
    case twoWayIcon = "twoWayIcon"
    case wideAngle140Icon = "wideAngle140Icon"
    case replayIcon = "replayIcon"
    case faceProfileIcon = "faceProfileIcon"
    case faceRecognitionIcon = "faceRecognitionIcon"
    case faceRecognitionNegativeIcon = "faceRecognitionNegativeIcon"
    case errorFaceIcon = "errorFaceIcon"
    case guestIcon = "guestIcon"
    case profileIcon = "profileIcon"
    case newScanIcon = "newScanIcon"
    case deleteScanIcon = "deleteScanIcon"
    case downloadIcon = "downloadIcon"
    case snoozeIcon = "snoozeIcon"
    case bellCircledIcon = "bellCircledIcon"
    case peopleCircledIcon = "peopleCircledIcon"
    case upArrowCircledIcon = "upArrowCircledIcon"
    case legalDocIcon = "legalDocIcon"
    case lightIcon = "lightIcon"
    case carIcon = "carIcon"
    case securityIcon = "securityIcon"
    case videoRecordingCircledIcon = "videoRecordingCircledIcon"
    case batterySaverCircledIcon = "batterySaverCircledIcon"
    case remoteIcon = "remoteIcon"
    case detectionZoneIcon = "detectionZoneIcon"
    case hotIcon = "hotIcon"
    case counterIcon = "counterIcon"
    case deleteIcon = "deleteIcon"
    case editIcon = "editIcon"
    case distanceIcon = "distanceIcon"
    case glassesIcon = "glassesIcon"
    case maskIcon = "maskIcon"
    case overlappingFacesIcon = "overlappingFacesIcon"
    case emailIcon = "emailIcon"
    
    case placeHolder = "placeHolder"
}

/// this protocol should be exposed to the client, so they can construct an enum that defines their images, and inject it into our ImageManager
public protocol CustomImageIdentifierProtocol {
    var rawValue: String { get }
}

/// This Protocol extension provides a default implementation of the name function which we use to reference the image in the asset bundle
extension CustomImageIdentifierProtocol {
    var imageName: String {
        print(self.rawValue)
        return self.rawValue
    }
}
