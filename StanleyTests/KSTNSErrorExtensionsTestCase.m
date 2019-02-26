//
//  KSTNSErrorExtensionsTestCase.m
//  Stanley
//
//  Created by William Towe on 4/6/17.
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

#import <Stanley/NSError+KSTExtensions.h>

@interface KSTNSErrorExtensionsTestCase : XCTestCase

@end

@implementation KSTNSErrorExtensionsTestCase

- (void)testDefaultAlertTitle {
    XCTAssertNotNil(NSError.KST_defaultAlertTitle);
}
- (void)testDefaultAlertMessage {
    XCTAssertNotNil(NSError.KST_defaultAlertMessage);
}
- (void)testAlertTitle {
    NSError *error = [NSError errorWithDomain:@"domain" code:1 userInfo:@{NSLocalizedDescriptionKey: @"message"}];
    
    XCTAssertEqualObjects(error.KST_alertTitle, @"message");
}
- (void)testAlertMessage {
    NSError *error = [NSError errorWithDomain:@"domain" code:1 userInfo:@{NSLocalizedRecoverySuggestionErrorKey: @"message"}];
    
    XCTAssertEqualObjects(error.KST_alertMessage, @"message");
}

@end
