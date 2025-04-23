// swift-tools-version:6.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Sliders",
    platforms: [
        .iOS(.v14), .macOS(.v11)
    ],
    products: [
        .library(name: "Sliders", targets: ["Sliders"])
    ],
    targets: [
        .target(name: "Sliders"),
        .testTarget(name: "SlidersTests", dependencies: ["Sliders"])
    ],
    swiftLanguageModes: [.version("6")]
)
