xcodebuild test -project Stanley.xcodeproj -scheme StanleyTests-iOS -sdk iphonesimulator -destination "platform=iOS Simulator,name=iPhone 7 Plus,OS=10.0" ONLY_ACTIVE_ARCH=NO GCC_INSTRUMENT_PROGRAM_FLOW_ARCS=YES GCC_GENERATE_TEST_COVERAGE_FILES=YES | xcpretty
xcodebuild test -project Stanley.xcodeproj -scheme StanleyTests-tvOS -sdk appletvsimulator -destination "platform=tvOS Simulator,name=Apple TV 1080p,OS=10.0" ONLY_ACTIVE_ARCH=NO GCC_INSTRUMENT_PROGRAM_FLOW_ARCS=YES GCC_GENERATE_TEST_COVERAGE_FILES=YES | xcpretty
xcodebuild test -project Stanley.xcodeproj -scheme StanleyTests-macOS -sdk macosx ONLY_ACTIVE_ARCH=NO GCC_INSTRUMENT_PROGRAM_FLOW_ARCS=YES GCC_GENERATE_TEST_COVERAGE_FILES=YES | xcpretty