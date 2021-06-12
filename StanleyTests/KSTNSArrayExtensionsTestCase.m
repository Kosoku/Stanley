//
//  KSTNSArrayExtensionsTestCase.m
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

#import <Stanley/NSArray+KSTExtensions.h>

@interface KSTNSArrayExtensionsTestCase : XCTestCase

@end

@implementation KSTNSArrayExtensionsTestCase

- (void)testReversedArray {
    NSArray *begin = @[@1,@2,@3];
    NSArray *end = @[@3,@2,@1];
    
    XCTAssertEqualObjects([begin KST_reversedArray], end);
}
- (void)testKST_arrayByAppendingObject {
    NSArray *begin = @[@1,@2,@3];
    NSNumber *object = @4;
    NSArray *end = @[@1,@2,@3,@4];
    
    XCTAssertEqualObjects([begin KST_arrayByAppendingObject:object], end);
}
- (void)testArrayByAppendingArray {
    NSArray *begin = @[@1,@2,@3];
    NSArray *append = @[@4,@5,@6];
    NSArray *end = @[@1,@2,@3,@4,@5,@6];
    
    XCTAssertEqualObjects([begin KST_arrayByAppendingArray:append], end);
}
- (void)testKST_arrayByPrependingObject {
    NSArray *begin = @[@1,@2,@3];
    NSNumber *object = @4;
    NSArray *end = @[@4,@1,@2,@3];
    
    XCTAssertEqualObjects([begin KST_arrayByPrependingObject:object], end);
}
- (void)testArrayByPrependingArray {
    NSArray *begin = @[@1,@2,@3];
    NSArray *prepend = @[@4,@5,@6];
    NSArray *end = @[@4,@5,@6,@1,@2,@3];
    
    XCTAssertEqualObjects([begin KST_arrayByPrependingArray:prepend], end);
}

- (void)testRemove {
    NSArray *begin = @[@1,@2,@3,@4,@5,@6];
    NSArray *remove = @[@1,@3,@5];
    NSArray *end = @[@2,@4,@6];
    
    XCTAssertEqualObjects([begin KST_arrayByRemovingArray:remove], end);
}

- (void)testSet {
    NSArray *begin = @[@1,@2,@3];
    NSSet *end = [NSSet setWithArray:begin];
    
    XCTAssertEqualObjects([begin KST_set], end);
}
- (void)testMutableSet {
    NSArray *begin = @[@1,@2,@3];
    NSMutableSet *end = [NSMutableSet setWithArray:begin];
    
    XCTAssertEqualObjects([begin KST_mutableSet], end);
}

- (void)testOrderedSet {
    NSArray *begin = @[@1,@2,@3];
    NSOrderedSet *end = [NSOrderedSet orderedSetWithArray:begin];
    
    XCTAssertEqualObjects([begin KST_orderedSet], end);
}
- (void)testMutableOrderedSet {
    NSArray *begin = @[@1,@2,@3];
    NSMutableOrderedSet *end = [NSMutableOrderedSet orderedSetWithArray:begin];
    
    XCTAssertEqualObjects([begin KST_mutableOrderedSet], end);
}

- (void)testShuffledArray {
    NSArray *begin = @[@1,@2,@3];
    
    XCTAssertNotEqual([begin KST_shuffledArray], begin);
}
- (void)testObjectAtRandomIndex {
    NSArray *begin = @[];
    
    XCTAssertNil([begin KST_objectAtRandomIndex]);
}

@end
