// swift-tools-version:4.0
import PackageDescription

let package = Package(
    name: "Themeable",
    
    products: [
        .library(name: "Themeable", targets: ["Themeable"]),
    ],
    
    targets: [
        .target(name: "Themeable", dependencies: []),
        .testTarget(name: "ThemeableTests", dependencies: ["Themeable"]),
    ],

    swiftLanguageVersions: [4]
)
