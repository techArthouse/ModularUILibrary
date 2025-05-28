// swift-tools-version:5.3
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "ModularUILibrary",
    platforms: [
       .iOS(.v13), // Specify other platforms and versions as needed
       // .macOS(.v10_15), .watchOS(.v6), .tvOS(.v13)
    ],
    products: [
        .library(
            name: "ModularUILibrary",
            targets: ["ModularUILibrary"]),
    ],
    dependencies: [
        // Dependencies declaration
    ],
    targets: [
        .target(
            name: "ModularUILibrary",
            dependencies: [],
            resources: [
                .process("Assets/Colors.xcassets"),
                .process("Assets/Images.xcassets")
            ]),
        .testTarget(
            name: "ModularUILibraryTests",
            dependencies: ["ModularUILibrary"]),
    ]
)
