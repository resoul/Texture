#!/bin/bash
set -e

LIB_NAME="AsyncDisplayKit"
OUTPUT_DIR="build_output"
BUILD_DIR="build"

DEVICE_ARCHIVE_TVOS="$BUILD_DIR/tvos_devices.xcarchive"
SIM_ARCHIVE_TVOS="$BUILD_DIR/tvos_sim.xcarchive"

rm -rf $BUILD_DIR $OUTPUT_DIR
mkdir -p $OUTPUT_DIR

echo "📺 Building $LIB_NAME for tvOS devices..."
xcodebuild archive \
  -workspace AsyncDisplayKit.xcworkspace \
  -scheme $LIB_NAME \
  -configuration Release \
  -destination "generic/platform=tvOS" \
  -archivePath $DEVICE_ARCHIVE_TVOS \
  SKIP_INSTALL=NO \
  BUILD_LIBRARY_FOR_DISTRIBUTION=YES

echo "📺 Building $LIB_NAME for tvOS simulator..."
xcodebuild archive \
  -workspace AsyncDisplayKit.xcworkspace \
  -scheme $LIB_NAME \
  -configuration Release \
  -destination "generic/platform=tvOS Simulator" \
  -archivePath $SIM_ARCHIVE_TVOS \
  SKIP_INSTALL=NO \
  BUILD_LIBRARY_FOR_DISTRIBUTION=YES

echo "📦 Creating $LIB_NAME.xcframework..."
xcodebuild -create-xcframework \
  -framework $DEVICE_ARCHIVE_TVOS/Products/Library/Frameworks/$LIB_NAME.framework \
  -framework $SIM_ARCHIVE_TVOS/Products/Library/Frameworks/$LIB_NAME.framework \
  -output $OUTPUT_DIR/$LIB_NAME.xcframework

echo "✅ Done: $OUTPUT_DIR/$LIB_NAME.xcframework"
