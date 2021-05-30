// swift-tools-version:5.4

import PackageDescription

let package = Package(
  name: "AbesPodcast",
  platforms: [
    .macOS(.v10_12),
  ],
  products: [
    .executable(name: "AbesPodcast", targets: ["AbesPodcast"]),
  ],
  dependencies: [
    .package(url: "https://github.com/nicklockwood/SwiftFormat", from: "0.41.2"),
    .package(name: "Publish", url: "https://github.com/johnsundell/publish.git", from: "0.7.0"),
    .package(url: "https://github.com/nmdias/FeedKit.git", from: "9.0.0")
  ],
  targets: [
    .target(
      name: "AbesPodcast",
      dependencies: ["Publish", "FeedKit"]
    ),
  ]
)
