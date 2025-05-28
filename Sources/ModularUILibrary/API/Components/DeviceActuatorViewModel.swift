//
//  DeviceActuatorViewModel.swift
//  ModularUILibrary
//
//  Created by Arturo Aguilar on 5/28/25.
//

import Foundation
import SwiftUI

@available(iOS 14.0, *)
class DeviceActuatorViewModel: ObservableObject {
    @Published var device: DeviceGridCellData
    @Published var config: DeviceActuatorViewConfig

    init(device: DeviceGridCellData, size: CellSize) {
        self.device = device
        self.config = DeviceActuatorViewConfig(size: size)
    }

    func handleLongPress() {
        print("Long press detected")
    }

    func updateDevice(id: String) {
        print("Device updated with id: \(id)")
    }

    var stateColor: UniqueColor {
        withAnimation(.linear(duration: 2.0)) {
            if device.isOnline {
                return .MyQ3Azure
            } else {
                return .MyQ3Chili
            }
        }
    }

    // Configuration struct is kept here for easier management and updates
    struct DeviceActuatorViewConfig {
        let size: CellSize
        
        var iconContainerAnchorPadding: CGFloat {
            switch size {
            case .small:
                return 12
            case .medium:
                return 24
            case .large:
                return 40
            }
        }
        
        var iconContainerSize: CGSize {
            switch size {
            case .small:
                return CGSize(width: 80, height: 80)
            case .medium:
                return CGSize(width: 115, height: 115)
            case .large:
                return CGSize(width: 176, height: 176)
            }
        }
        
        var headerPadding: EdgeInsets {
            switch size {
            case .small:
                return EdgeInsets(top: 14, leading: 16, bottom: 6, trailing: 16)
            case .medium:
                return EdgeInsets(top: 24, leading: 24, bottom: 24, trailing: 24 + iconContainerSize.width)
            case .large:
                return EdgeInsets(top: 24, leading: 24, bottom: 24, trailing: 24)
            }
        }
        
        var notchHeight: CGFloat {
            switch size {
            case .small:
                return 20
            case .medium, .large:
                return 24
            }
        }
        
        var notchPadding: CGFloat {
            switch size {
            case .small:
                return 2
            case .medium, .large:
                return 6
            }
        }
        
        var notchAlignment: Edge.Set {
            switch size {
            case .small:
                return .top
            case .medium, .large:
                return .bottom
            }
        }
        
        var iconSize: CGSize {
            switch size {
            case .small:
                return CGSize(width: 48, height: 48)
            case .medium:
                return CGSize(width: 62, height: 62)
            case .large:
                return CGSize(width: 96, height: 96)
            }
        }

        var smallHeaderOpacity: CGFloat {
            switch size {
            case .small:
                return 1.0
            case .medium, .large:
                return 0.0
            }
        }
        
        var nonSmallHeaderOpacity: CGFloat {
            switch size {
            case .small:
                return 0.0
            case .medium, .large:
                return 1.0
            }
        }
    }
}

@available(iOS 14.0, *)
class DeviceGridCellData: ObservableObject {
    @Published var id: String
    @Published var name: String
    @Published var description: String
    @Published var isOnline: Bool
    @Published var deviceType: String
    @Published var status: String

    init(id: String = "", name: String = "", description: String = "", isOnline: Bool = false, deviceType: String = "", status: String = "") {
        self.id = id
        self.name = name
        self.description = description
        self.isOnline = isOnline
        self.deviceType = deviceType
        self.status = status
    }
}
