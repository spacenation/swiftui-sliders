// swift-tools-version:5.1
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Sliders",
    platforms: [
        .iOS(.v13), .macOS(.v10_15)
    ],
    products: [
        .library(name: "Sliders", targets: ["Sliders"])
    ],
    targets: [
        .target(name: "Sliders", exclude: ["Examples", "Resources"]),
        .testTarget(name: "SlidersTests", dependencies: ["Sliders"])
    ]
)
