// swift-tools-version:5.1

import PackageDescription

let package = Package(
    name: "Abespodcast",
    products: [
        .executable(name: "Abespodcast", targets: ["Abespodcast"])
    ],
    dependencies: [
        .package(url: "https://github.com/johnsundell/publish.git", from: "0.1.0")
    ],
    targets: [
        .target(
            name: "Abespodcast",
            dependencies: ["Publish"]
        )
    ]
)