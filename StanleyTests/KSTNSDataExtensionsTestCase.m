//
//  KSTNSDataExtensionsTestCase.m
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

#import <Stanley/NSData+KSTExtensions.h>

@interface KSTNSDataExtensionsTestCase : XCTestCase

@end

@implementation KSTNSDataExtensionsTestCase

- (void)testNilReturnValue {
    XCTAssertNil([[@"" dataUsingEncoding:NSUTF8StringEncoding] KST_MD5String]);
    XCTAssertNil([[@"" dataUsingEncoding:NSUTF8StringEncoding] KST_SHA1String]);
    XCTAssertNil([[@"" dataUsingEncoding:NSUTF8StringEncoding] KST_SHA256String]);
    XCTAssertNil([[@"" dataUsingEncoding:NSUTF8StringEncoding] KST_SHA512String]);
}
- (void)testNonNilReturnValue {
    XCTAssertNotNil([[@"abc" dataUsingEncoding:NSUTF8StringEncoding] KST_MD5String]);
    XCTAssertNotNil([[@"abc" dataUsingEncoding:NSUTF8StringEncoding] KST_SHA1String]);
    XCTAssertNotNil([[@"abc" dataUsingEncoding:NSUTF8StringEncoding] KST_SHA256String]);
    XCTAssertNotNil([[@"abc" dataUsingEncoding:NSUTF8StringEncoding] KST_SHA512String]);
}

@end
