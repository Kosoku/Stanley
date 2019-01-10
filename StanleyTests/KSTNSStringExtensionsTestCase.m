//
//  KSTNSStringExtensionsTestCase.m
//  Stanley
//
//  Created by William Towe on 3/7/17.
//  Copyright © 2019 Kosoku Interactive, LLC. All rights reserved.
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

#import <Stanley/NSString+KSTExtensions.h>

@interface KSTNSStringExtensionsTestCase : XCTestCase

@end

@implementation KSTNSStringExtensionsTestCase

- (void)testKST_stringByRemovingCharactersInSet {
    NSString *begin = @"abc";
    NSString *end = @"abc";
    
    XCTAssertEqualObjects([begin KST_stringByRemovingCharactersInSet:NSCharacterSet.decimalDigitCharacterSet], end);
    
    begin = @"+1 (123) 456-7890";
    end = @"11234567890";
    
    XCTAssertEqualObjects([begin KST_stringByRemovingCharactersInSet:NSCharacterSet.decimalDigitCharacterSet.invertedSet], end);
}
- (void)testNilReturnValue {
    XCTAssertNil([@"" KST_MD5String]);
    XCTAssertNil([@"" KST_SHA1String]);
    XCTAssertNil([@"" KST_SHA256String]);
    XCTAssertNil([@"" KST_SHA512String]);
}

@end
