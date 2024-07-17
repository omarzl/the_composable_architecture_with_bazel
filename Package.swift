// swift-tools-version:5.7

import PackageDescription

let package = Package(
    name: "Demo",
    dependencies: [
        .package(
            url: "https://github.com/pointfreeco/swift-composable-architecture.git",
            branch: "master"
        ),
    ]
)

