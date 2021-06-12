//
//  KSTNSBundleExtensionsTestCase.m
//  Stanley
//
//  Created by William Towe on 3/7/17.
//  Copyright © 2021 Kosoku Interactive, LLC. All rights reserved.
//
//  Licensed under the Apache License, Version 2.0 (the "License");
//  you may not use this file except in compliance with the License.
//  You may obtain a copy of the License at
//
//  http://www.apache.org/licenses/LICENSE-2.0
//
//  Unless required by applicable law or agreed to in writing, software
//  distributed under the License is distributed on an "AS IS" BASIS,
//  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
//  See the License for the specific language governing permissions and
//  limitations under the License.

#import <XCTest/XCTest.h>

#import <Stanley/NSBundle+KSTExtensions.h>

@interface KSTNSBundleExtensionsTestCase : XCTestCase

@end

@implementation KSTNSBundleExtensionsTestCase

- (void)testCurrentBundle {
    XCTAssertEqualObjects(NSBundle.KST_currentBundle.KST_bundleIdentifier, [NSBundle bundleForClass:self.class].KST_bundleIdentifier);
}

- (void)testBundleIdentifier {
    XCTAssertNotNil([[NSBundle bundleForClass:[self class]] KST_bundleIdentifier]);
}
- (void)testBundleDisplayName {
    XCTAssertNil([[NSBundle bundleForClass:[self class]] KST_bundleDisplayName]);
}
- (void)testBundleExecutable {
    XCTAssertNotNil([[NSBundle bundleForClass:[self class]] KST_bundleExecutable]);
}
- (void)testBundleShortVersionString {
    XCTAssertNotNil([[NSBundle bundleForClass:[self class]] KST_bundleShortVersionString]);
}
- (void)testBundleVersion {
    XCTAssertNotNil([[NSBundle bundleForClass:[self class]] KST_bundleVersion]);
}

@end
