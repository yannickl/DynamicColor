// swift-tools-version:5.9
import PackageDescription

let package = Package(
  name: "DynamicColor",
  platforms: [
    .iOS(.v11), .visionOS(.v1)
  ],
  products: [
    .library(name: "DynamicColor", targets: ["DynamicColor"]),
  ],
  targets: [
    .target(
      name: "DynamicColor",
      dependencies: [],
      path: "Sources"
    ),
    .testTarget(
      name: "DynamicColorTests",
      dependencies: ["DynamicColor"],
      path: "Tests"
    ),
  ]
)

