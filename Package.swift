// swift-tools-version:5.0
import PackageDescription

let package = Package(
  name: "DynamicColor",
  platforms: [
	.iOS(SupportedPlatform.IOSVersion.v11)
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

