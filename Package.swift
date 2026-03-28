// swift-tools-version:5.7
import PackageDescription

let package = Package(
    name: "AsyncDisplayKit",
    products: [
        .library(name: "AsyncDisplayKit", targets: ["AsyncDisplayKit"])
    ],
    targets: [
        .binaryTarget(
            name: "AsyncDisplayKit",
            url: "https://github.com/resoul/Texture/releases/download/3.2.0/AsyncDisplayKit.xcframework.zip",
            checksum: "4ceba493d467a611afbdd1ee00b6128be26dc5b8a9a0cebf480f582df676ec37"
        )
    ]
)
