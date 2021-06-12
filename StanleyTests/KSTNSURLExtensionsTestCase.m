//
//  KSTNSURLExtensionsTestCase.m
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

#import <Stanley/NSURL+KSTExtensions.h>

@interface KSTNSURLExtensionsTestCase : XCTestCase

@end

@implementation KSTNSURLExtensionsTestCase

- (void)testQueryDictionary {
    NSURL *start = [NSURL URLWithString:@"https://www.a.com/b?first=firstkey&second=secondkey&third=thirdkey"];
    NSDictionary *end = @{@"first": @"firstkey",
                          @"second": @"secondkey",
                          @"third": @"thirdkey"};
    
    XCTAssertEqualObjects([start KST_queryDictionary], end);
}
- (void)testURLWithBaseString {
    NSString *base = @"https://www.a.com/b";
    NSDictionary *params = @{@"first": @"firstkey",
                             @"second": @"secondkey",
                             @"third": @"thirdkey"};
    NSURL *end = [NSURL URLWithString:@"https://www.a.com/b?first=firstkey&second=secondkey&third=thirdkey"];
    
    XCTAssertEqualObjects([NSURL KST_URLWithBaseString:base parameters:params], end);
}

@end
