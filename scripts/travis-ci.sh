#!/bin/sh

# iOS tests
xcodebuild test -project Stanley.xcodeproj -scheme StanleyTests-iOS -sdk iphonesimulator -destination "platform=iOS Simulator,name=iPhone 8 Plus,OS=latest" ONLY_ACTIVE_ARCH=NO GCC_INSTRUMENT_PROGRAM_FLOW_ARCS=YES GCC_GENERATE_TEST_COVERAGE_FILES=YES | xcpretty

# tvOS tests
xcodebuild test -project Stanley.xcodeproj -scheme StanleyTests-tvOS -sdk appletvsimulator -destination "platform=tvOS Simulator,name=Apple TV,OS=10.0" ONLY_ACTIVE_ARCH=NO GCC_INSTRUMENT_PROGRAM_FLOW_ARCS=YES GCC_GENERATE_TEST_COVERAGE_FILES=YES | xcpretty

# macOS tests
xcodebuild test -project Stanley.xcodeproj -scheme StanleyTests-macOS -sdk macosx ONLY_ACTIVE_ARCH=NO GCC_INSTRUMENT_PROGRAM_FLOW_ARCS=YES GCC_GENERATE_TEST_COVERAGE_FILES=YES | xcpretty