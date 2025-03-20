// swift-tools-version: 6.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "story2code",
    dependencies: [
        .package(url: "https://github.com/IBDecodable/IBDecodable.git", branch: "master")
    ],
    targets: [
        .executableTarget(
            name: "story2code",
            dependencies: ["IBDecodable"]
        ),
    ]
)
