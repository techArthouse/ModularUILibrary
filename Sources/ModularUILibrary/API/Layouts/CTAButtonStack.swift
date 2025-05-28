//
//  CTAButtonStack.swift
//
//
//  Created by Aguilar, Arturo on 1/8/24.
//

import SwiftUI

/// Use this stack to hold `CTAButton` Types. It serves as a layout engine
struct CTAButtonStack<Content: View>: View {
    let layout: CTALayout
    let content: () -> Content
    
    enum CTALayout {
        case horizontal
        case vertical
    }

    init(_ layout: CTALayout, @ViewBuilder content: @escaping () -> Content) {
        self.layout = layout
        self.content = content
    }

    var body: some View {
        Group {
            if layout == .horizontal {
                HStack(spacing: 16) {
                    content()
                }
            } else {
                VStack(spacing: 16) {
                    content()
                }
            }
        }
        .padding(EdgeInsets(top: 40, leading: 24, bottom: 40, trailing: 24))
    }
}

struct CTAButtonStack_Previews: PreviewProvider {
    struct PreviewWrapper: View {
        let themeManager: ThemeManager = ThemeManager()
        @State private var isDisabled: Bool = false
        var body: some View {
            VStack(spacing: 0) {
                Spacer()
                CTAButtonStack(.vertical) {
                    CTAButton(title: "hello") {
                        print("ohh")
                    }
                    .asPrimaryButton(padding: .stacked)
                    CTAButton(title: "hello") {
                        print("ohh")
                    }
                    .asSecondaryButton(padding: .stacked)
                }
                
                HStack(spacing: 0) {
                    CTAButtonStack(.vertical) {
                        CTAButton(title: "hello") {
                            print("ohh")
                        }
                        .asPrimaryAlertButton(padding: .stacked)
                        CTAButton(title: "hello") {
                            print("ohh")
                        }
                        .asBorderlessButton(padding: .stacked)
                        CTAButton(title: "hello") {
                            print("ohh")
                        }
                        .asDestructiveButton(padding: .stacked)
                    }
                    Spacer()
                    CTAButtonStack(.vertical) {
                        CTAButton(title: "hello") {
                            print("ohh")
                        }
                        .asDestructiveButton(padding: .stacked)
                        CTAButton(title: "hello") {
                            print("ohh")
                        }
                        .asBorderlessButton(padding: .stacked)
                        CTAButton(title: "hello") {
                            print("ohh")
                        }
                        .asPrimaryAlertButton(padding: .stacked)
                    }
                }
                
                CTAButtonStack(.vertical) {
                    CTAButton(title: "hello") {
                        print("ohh")
                    }
                    .asPrimaryButton(padding: .stacked)
                    CTAButton(title: "hello") {
                        print("ohh")
                    }
                    .asSecondaryButton(padding: .stacked)
                    CTAButton(title: "hello") {
                        print("ohh")
                    }
                    .asPrimaryAlertButton(padding: .stacked)
                }
                
                Spacer()
                
                CTAButtonStack(.horizontal) {
                    CTAButton(title: "hello") {
                        print("ohh")
                    }
                    .asDestructiveButton(padding: .stacked)
                    
                    CTAButton(title: "hello") {
                        print("ohh")
                    }
                    .asDestructiveButton(padding: .stacked)
                }
            }
            .environmentObject(themeManager)
        }
    }
    
    static var previews: some View {
        PreviewWrapper()
    }
}
