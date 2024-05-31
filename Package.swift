// swift-tools-version: 5.10

import PackageDescription

let package = Package(
    name: "Networking",
    products: [
        .library(
            name: "Networking",
            targets: ["Networking"]),
    ],
    targets: [
        .target(
            name: "Networking"),
        .testTarget(
            name: "NetworkingTests",
            dependencies: ["Networking"]),
    ]
)
