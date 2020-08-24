// swift-tools-version:5.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "TestSpy",
    products: [
        .library(
            name: "TestSpy",
            targets: ["TestSpy"]),
    ],
    dependencies: [
        .package(url: "https://github.com/Quick/Nimble", from: "8.1.1"),
        .package(url: "https://github.com/Quick/Quick", from: "3.0.0")
    ],
    targets: [
        .target(
            name: "TestSpy",
            dependencies: ["Nimble"]),
        .testTarget(
            name: "TestSpyTests",
            dependencies: ["TestSpy", "Quick"]),
    ],
    swiftLanguageVersions: [.v5]
)
