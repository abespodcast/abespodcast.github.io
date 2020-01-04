// swift-tools-version:5.1

import PackageDescription

let package = Package(
    name: "AbesPodcast",
    products: [
        .executable(name: "AbesPodcast", targets: ["AbesPodcast"])
    ],
    dependencies: [
        .package(url: "https://github.com/johnsundell/publish.git", from: "0.2.0")
    ],
    targets: [
        .target(
            name: "AbesPodcast",
            dependencies: ["Publish"]
        )
    ]
)
