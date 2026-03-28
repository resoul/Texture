#!/bin/bash
set -e

VERSION=${1:-"3.2.0"}
REPO=${2:-"resoul/Texture"}
FRAMEWORK_NAME="AsyncDisplayKit"
OUTPUT_ZIP="${FRAMEWORK_NAME}.xcframework.zip"
PACKAGE_FILE="Package.swift"

echo "🔨 create xcframework..."
rm -rf "${FRAMEWORK_NAME}.xcframework"

xcodebuild -create-xcframework \
    -framework ios/${FRAMEWORK_NAME}.xcframework/ios-arm64/${FRAMEWORK_NAME}.framework \
    -framework ios/${FRAMEWORK_NAME}.xcframework/ios-arm64_x86_64-simulator/${FRAMEWORK_NAME}.framework \
    -framework tvos/${FRAMEWORK_NAME}.xcframework/tvos-arm64/${FRAMEWORK_NAME}.framework \
    -framework tvos/${FRAMEWORK_NAME}.xcframework/tvos-arm64_x86_64-simulator/${FRAMEWORK_NAME}.framework \
    -output ${FRAMEWORK_NAME}.xcframework

echo "📦 zip..."
rm -f "${OUTPUT_ZIP}"
zip -r "${OUTPUT_ZIP}" "${FRAMEWORK_NAME}.xcframework"

echo "🔑 get checksum..."
CHECKSUM=$(swift package compute-checksum "${OUTPUT_ZIP}")
echo "Checksum: ${CHECKSUM}"

echo "📝 generate Package.swift..."
cat > "${PACKAGE_FILE}" << EOF
// swift-tools-version:5.7
import PackageDescription

let package = Package(
    name: "${FRAMEWORK_NAME}",
    products: [
        .library(name: "${FRAMEWORK_NAME}", targets: ["${FRAMEWORK_NAME}"])
    ],
    targets: [
        .binaryTarget(
            name: "${FRAMEWORK_NAME}",
            url: "https://github.com/${REPO}/releases/download/${VERSION}/${OUTPUT_ZIP}",
            checksum: "${CHECKSUM}"
        )
    ]
)
EOF

echo "✅ Done!"
echo "   Version:   ${VERSION}"
echo "   Zip:    ${OUTPUT_ZIP}"
echo "   Checksum: ${CHECKSUM}"
echo ""
echo "Next steps:"
echo "  1. git add Package.swift"
echo "  2. git commit -m 'Release ${VERSION}'"
echo "  3. git tag ${VERSION}"
echo "  4. git push origin ${VERSION}"
echo "  5. upload ${OUTPUT_ZIP} to GitHub Release ${VERSION}"
