//
//  DeviceActuator.swift
//  ModularUILibrary
//
//  Created by Arturo Aguilar on 5/28/25.
//
import SwiftUI

@available(iOS 14.0, *)
enum CellSize: CaseIterable {
    case small, medium, large
    
    var nextSize: CellSize {
        switch self {
        case .small: return .medium
        case .medium: return .large
        case .large: return .small
        }
    }
    /// Cell frame dimensions
    var frameSize: CGSize {
        switch self {
        case .small: return CGSize(width: 170, height: 170)
        case .medium: return CGSize(width: 320, height: 170)
        case .large: return CGSize(width: 320, height: 320)
        }
    }

    /// Icon view size
    var iconSize: CGFloat {
        switch self {
        case .small: return 32
        case .medium: return 48
        case .large: return 64
        }
    }

    /// Title font
    var titleFont: Font {
        switch self {
        case .small: return .headline
        case .medium: return .title3
        case .large: return .title2
        }
    }

    /// Status text font
    var statusFont: Font {
        switch self {
        case .small: return .caption
        case .medium: return .subheadline
        case .large: return .body
        }
    }

    /// Vertical spacing between elements
    var verticalSpacing: CGFloat {
        switch self {
        case .small: return 8
        case .medium: return 12
        case .large: return 16
        }
    }

    /// Padding inside the card
    var contentPadding: CGFloat {
        switch self {
        case .small: return 8
        case .medium: return 12
        case .large: return 16
        }
    }

    /// Corner radius of the background card
    var cardCornerRadius: CGFloat {
        switch self {
        case .small: return 12
        case .medium: return 16
        case .large: return 20
        }
    }
}

@available(iOS 14.0, *)
struct DeviceActuatorView: View {
    @EnvironmentObject var themeManager: ThemeManager
    var size: CellSize
    @ObservedObject var device: DeviceGridCellData
    @GestureState private var isDetectingLongPress: Bool = false
    
    private var config: DeviceActuatorViewConfig {
        DeviceActuatorViewConfig(size: size)
    }
    
    private var stateColor: UniqueColor {
        withAnimation(.linear(duration: 2.0)) {
            if device.isOnline {
                return .MyQ3Emerald
            } else {
                return .MyQ3Chili
            }
        }
    }
    
    // TODO: SHIELD - 56 Device Control
    var longPress: some Gesture {
        LongPressGesture(minimumDuration: 3)
            .updating($isDetectingLongPress) { currentState, gestureState,
                transaction in
                gestureState = currentState
                transaction.animation = Animation.easeIn(duration: 2.0)
            }
            .onEnded { finished in
                print("Longpress dectect")
            }
    }
    
    @available(iOS 14.0, *)
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
        
        // The dimensions
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
        
        // padding to add around header according to design specs
        var headerPadding: EdgeInsets {
            switch size {
            case .small:
                EdgeInsets(top: 14, leading: 16, bottom: 6, trailing: 16)
            case .medium:
                // Pad Right side with enough space to not overlap icon/button when in medium size.
                EdgeInsets(top: 24, leading: 24, bottom: 24, trailing: 24 + iconContainerSize.width)
            case .large:
                EdgeInsets(top: 24, leading: 24, bottom: 24, trailing: 24)
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
        
        // dimensions of iconSize according to size.
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
                1.0
            case .medium, .large:
                0.0
            }
        }
        
        var nonSmallHeaderOpacity: CGFloat {
            switch size {
            case .small:
                0.0
            case .medium, .large:
                1.0
            }
        }
    }
    
    var body: some View {
        ZStack {
            // MARK: - Header
            Header(config: config,
                   title: device.name,
                   subtitle: device.description,
                   stateColor: .MyQ3Charcoal)
            .background(
                // MARK: - Blue Notch on Left Side
                Notch(config: config, stateColor: stateColor)
            )
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
            
            ZStack {
                // MARK: - Icon Button
                Actuator(config: config, stateColor: stateColor)
                    .gesture(longPress)
            }
        }
        .background(
            // MARK: - Shaddow Behind Tile
            RoundedRectangle(cornerRadius: 16)
                .fill(.white.opacity(1))
                .shadow(color: .black.opacity(0.05), radius: 16, x: 0, y: 16))
    }
    
    // MARK: - SubComponents
    
    /// NOTE: - The body of Header cycles visibily between two VStacks. Each VStack has similar Text views and string
    /// values, but their font attributes differ. Since we can't interpolate between font weights or font styles, animations
    /// don't work smoothly between transitions. By keeping both header configurations on a ZStack we can interpolate
    /// between opacity values and use a cross-disolve effect to achieve a smoother transition between size states.
    @available(iOS 14.0, *)
    private struct Header: View {
        var config: DeviceActuatorViewConfig
        var title: String
        var subtitle: String
        var stateColor: UniqueColor
        
        // State vars `smallHeaderOpacity` and `nonSmallHeaderOpacity` manage which part of the
        // header in the ZStack is visible for some size. The smallHeader refers to the header
        // config when size is .small, and nonSmallHeader refers to the header config for .medium
        // and .large. The header config refers to the font attributes and header padding/alignment.
        @State private var smallHeaderOpacity: CGFloat = 0.0
        @State private var nonSmallHeaderOpacity: CGFloat = 0.0
        
        @available(iOS 14.0, *)
        var body: some View {
            VStack(alignment: .leading, spacing: 2) {
                if #available(iOS 17.0, *) {
                    ZStack(alignment: .leading) {
                        VStack(spacing: 0) {
                            Group {
                                Text(title)
                                Text(subtitle)
                            }
                            .lineLimit(1)
                        }
                        .opacity(smallHeaderOpacity)
                        
                        VStack(spacing: 0) {
                            Group {
                                Text(title)
                                Text(subtitle)
                            }
                            .lineLimit(1)
                        }
                        .opacity(nonSmallHeaderOpacity)
                    }
                    .onChange(of: config.size, initial: true) {
                        withAnimation(.linear(duration: 0.45)) {
                            smallHeaderOpacity = config.smallHeaderOpacity
                            nonSmallHeaderOpacity = config.nonSmallHeaderOpacity
                        }
                    }
                } else {
                }
            }
            .padding(config.headerPadding)
            .frame(maxWidth: .infinity, alignment: .leading)
        }
    }
    
    @available(iOS 14.0, *)
    private struct Notch: View {
        @EnvironmentObject var themeManager: ThemeManager
        var config: DeviceActuatorViewConfig
        var stateColor: UniqueColor
        
        var body: some View {
            VStack {
                CurvedEdgeShape()
                    .fill(themeManager.colorAssetManager.getColor(stateColor))
            }
            .frame(height: config.notchHeight)
            .padding(config.notchAlignment, config.notchPadding)
        }
        
        // MARK: - For the notch specfic to ActuatorViews
        struct CurvedEdgeShape: Shape {
            func path(in rect: CGRect) -> Path {
                var path = Path()
                let width: CGFloat = 4
                
                path.addArc(center: .zero,
                            radius: width,
                            startAngle: Angle(degrees: 0),
                            endAngle: Angle(degrees: 270),
                            clockwise: true)
                
                path.addArc(center: CGPoint(x: 0, y: rect.height - 8),
                            radius: width,
                            startAngle: Angle(degrees: 90),
                            endAngle: Angle(degrees: 0),
                            clockwise: true)
                
                path.closeSubpath()

                return path
            }
        }
    }
    
    @available(iOS 14.0, *)
    private struct Actuator: View {
        @EnvironmentObject var themeManager: ThemeManager
        @EnvironmentObject var vm: DeviceActuatorViewModel
        var config: DeviceActuatorViewConfig
        var stateColor: UniqueColor
        var stateImage: ImageIdentifier { .preset(.notPlayableIcon) }
        
        var body: some View {
            VStack {
                IconButton(icon: .preset(.speakerIconOn), isDisabled: .constant(false), action: {})
                    .asStandardIconButtonStyle()
                    .frame(width: config.iconSize.width, height: config.iconSize.height)
            }
            .frame(width: config.iconContainerSize.width, height: config.iconContainerSize.height)
            .background(
                ActuatorBackground(stateColor: stateColor)
            )
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: config.size == .medium ? .trailing: .bottom)
            .padding(config.iconContainerAnchorPadding)
            .onTapGesture {
                print("tapped")
                vm.updateDevice(id: "id1")
            }
        }
    }

    private struct ActuatorBackground: View {
        @EnvironmentObject var themeManager: ThemeManager
        var stateColor: UniqueColor
        
        var body: some View {
            VStack {
                Circle()
                    .fill(themeManager.colorAssetManager.getColor(.MyQ3PureWhite))
                    .overlay(
                            Circle()
                                .stroke(themeManager.colorAssetManager
                                    .getColor(stateColor)
                                    .opacity(0.5), lineWidth: 10)
                    )
            }
        }
    }
}

// MARK: - Preview

// MARK: - Interactive Preview

@available(iOS 14.0, *)
struct DeviceActuatorInteractivePreview: View {
    @State private var size: CellSize = .small
    @StateObject private var device = DeviceGridCellData(
        id: "preview",
        name: "Preview Device",
        description: "Tap “Next Size”",
        isOnline: true,
        deviceType: "Light",
        status: "On"
    )
    
    var body: some View {
        ZStack {
            Color.gray.opacity(0.2)
            VStack(spacing: 16) {
                DeviceActuatorView(size: size, device: device)
                    .environmentObject(ThemeManager())
                    .frame(width: size.frameSize.width,
                           height: size.frameSize.height)
                    .animation(.easeInOut(duration: 0.5), value: size)
                
                if #available(iOS 15.0, *) {
                    Button("Next Size: \(size)") {
                        // cycle through sizes
                        size = size.nextSize
                    }
                    .buttonStyle(.borderedProminent)
                } else {
                }
            }
            .padding()
        }
    }
}

@available(iOS 14.0, *)
struct DeviceActuatorView_Previews: PreviewProvider {
    static var previews: some View {
        DeviceActuatorInteractivePreview()
          .background(Color.gray.opacity(0.2))
          .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}
