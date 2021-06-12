//
//  KSTNSMutableArrayExtensionsTestCase.m
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

#import <Stanley/NSMutableArray+KSTExtensions.h>

@interface KSTNSMutableArrayExtensionsTestCase : XCTestCase

@end

@implementation KSTNSMutableArrayExtensionsTestCase

- (void)testRemoveFirstObject {
    NSMutableArray *begin = [[NSMutableArray alloc] init];
    
    XCTAssertNoThrow([begin KST_removeFirstObject]);
    
    begin = [[NSMutableArray alloc] initWithObjects:@1, @2, nil];
    
    [begin KST_removeFirstObject];
    
    NSMutableArray *end = [[NSMutableArray alloc] initWithObjects:@2, nil];
    
    XCTAssertEqualObjects(begin, end);
}
- (void)testKST_reverse {
    NSMutableArray *begin = [NSMutableArray arrayWithArray:@[@1]];
    
    XCTAssertNoThrow([begin KST_reverse]);
    
    NSMutableArray *end = [NSMutableArray arrayWithArray:@[@2,@1]];
    
    begin = [NSMutableArray arrayWithArray:@[@1,@2]];
    
    [begin KST_reverse];
    
    XCTAssertEqualObjects(begin, end);
    
    begin = [NSMutableArray arrayWithArray:@[@1,@2,@3]];
    end = [NSMutableArray arrayWithArray:@[@3,@2,@1]];
    
    [begin KST_reverse];
    
    XCTAssertEqualObjects(begin, end);
}
- (void)testKST_appendObject {
    NSMutableArray *begin = [NSMutableArray arrayWithArray:@[@1,@2]];
    NSNumber *object = @3;
    NSMutableArray *end = [NSMutableArray arrayWithArray:@[@1,@2,@3]];
    
    [begin KST_appendObject:object];
    
    XCTAssertEqualObjects(begin, end);
}
- (void)testKST_appendArray {
    NSMutableArray *begin = [NSMutableArray arrayWithArray:@[@1,@2]];
    NSArray *append = @[@3,@4];
    NSMutableArray *end = [NSMutableArray arrayWithArray:@[@1,@2,@3,@4]];
    
    [begin KST_appendArray:append];
    
    XCTAssertEqualObjects(begin, end);
}
- (void)testKST_prependObject {
    NSMutableArray *begin = [NSMutableArray arrayWithArray:@[@1,@2]];
    NSNumber *object = @3;
    NSMutableArray *end = [NSMutableArray arrayWithArray:@[@3,@1,@2]];
    
    [begin KST_prependObject:object];
    
    XCTAssertEqualObjects(begin, end);
}
- (void)testKST_prependArray {
    NSMutableArray *begin = [NSMutableArray arrayWithArray:@[@1,@2]];
    NSArray *append = @[@3,@4];
    NSMutableArray *end = [NSMutableArray arrayWithArray:@[@3,@4,@1,@2]];
    
    [begin KST_prependArray:append];
    
    XCTAssertEqualObjects(begin, end);
}
- (void)testPush {
    NSMutableArray *begin = [[NSMutableArray alloc] init];
    
    [begin KST_push:@1];
    
    NSMutableArray *end = [[NSMutableArray alloc] initWithObjects:@1, nil];
    
    XCTAssertEqualObjects(begin, end);
}
- (void)testPop {
    NSMutableArray *begin = [[NSMutableArray alloc] init];
    
    XCTAssertNil([begin KST_pop]);
}

@end
