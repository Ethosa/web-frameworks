// swift-tools-version:5.10
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "server",
    platforms: [.macOS(.v14)], // This is for development on macOS
    dependencies: [
        .package(url: "https://github.com/hummingbird-project/hummingbird.git", .upToNextMinor(from: "2.0.0")),
    ],
    targets: [
        .executableTarget(
            name: "server",
            dependencies: [
                .product(name: "Hummingbird", package: "hummingbird"),
            ],
            swiftSettings: [
                // Enable better optimizations when building in Release configuration. Despite the use of
                // the `.unsafeFlags` construct required by SwiftPM, this flag is recommended for Release
                // builds. See <https://github.com/swift-server/guides#building-for-production> for details.
                .unsafeFlags(["-cross-module-optimization"], .when(configuration: .release))
            ]
        ),
    ]
)
