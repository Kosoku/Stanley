//
//  KSTMacrosTestCase.m
//  Stanley
//
//  Created by William Towe on 5/24/18.
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

#import <Stanley/KSTMacros.h>

@interface KSTMacrosTestCase : XCTestCase

@end

@implementation KSTMacrosTestCase

- (void)testBoundedValue {
    XCTAssertEqual(KSTBoundedValue(NSIntegerMax, NSIntegerMin, 0), 0);
    XCTAssertEqual(KSTBoundedValue(NSIntegerMin, 0, NSIntegerMax), 0);
}

@end
