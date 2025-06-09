// swift-tools-version: 6.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let storyboardDecoder = "StoryboardDecoder"

let package = Package(
    name: "story2code",
    dependencies: [
        .package(url: "https://github.com/Adobels/\(storyboardDecoder).git", branch: "develop")
    ],
    targets: [
        .executableTarget(
            name: "story2code",
            dependencies: [.product(name: storyboardDecoder, package: storyboardDecoder)],
            resources: [.process("Resources")],
            swiftSettings: [
                .unsafeFlags(["-suppress-warnings"], .when(configuration: .debug))
            ],
        ),
    ],
)
