// swift-tools-version: 5.7

import PackageDescription

let package = Package(
    name: "NetInfo",
    products: [
        .library(
            name: "NetInfo",
            targets: ["NetInfo"]),
    ],
    dependencies: [
        .package(url: "https://github.com/apple/swift-nio.git", from: "2.0.0")
    ],
    targets: [
        .target(
            name: "NetInfo",
            dependencies: [.product(name: "NIO", package: "swift-nio")])
        ]
)
