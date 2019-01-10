//
//  KSTNSDateExtensionsTestCase.m
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

#import <Stanley/NSDate+KSTExtensions.h>

@interface KSTNSDateExtensionsTestCase : XCTestCase

@end

@implementation KSTNSDateExtensionsTestCase

- (void)testDay {
    NSDateComponents *comps = [[NSDateComponents alloc] init];
    
    [comps setDay:17];
    
    NSDate *date = [[NSCalendar currentCalendar] dateFromComponents:comps];
    
    XCTAssertEqual(date.KST_day, 17);
}
- (void)testMonth {
    NSDateComponents *comps = [[NSDateComponents alloc] init];
    
    [comps setMonth:10];
    
    NSDate *date = [[NSCalendar currentCalendar] dateFromComponents:comps];
    
    XCTAssertEqual(date.KST_month, 10);
}
- (void)testYear {
    NSDateComponents *comps = [[NSDateComponents alloc] init];
    
    [comps setYear:1984];
    
    NSDate *date = [[NSCalendar currentCalendar] dateFromComponents:comps];
    
    XCTAssertEqual(date.KST_year, 1984);
}

@end
