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
            checksum: "835f32720577a1758b761494a50a9b7621508ae3e8bb2fb42b245d612a6f33df"
        )
    ]
)
