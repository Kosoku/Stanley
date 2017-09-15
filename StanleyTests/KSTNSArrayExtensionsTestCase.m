//
//  KSTNSArrayExtensionsTestCase.m
//  Stanley
//
//  Created by William Towe on 3/7/17.
//  Copyright © 2017 Kosoku Interactive, LLC. All rights reserved.
//
//  Redistribution and use in source and binary forms, with or without modification, are permitted provided that the following conditions are met:
//
//  1. Redistributions of source code must retain the above copyright notice, this list of conditions and the following disclaimer.
//
//  2. Redistributions in binary form must reproduce the above copyright notice, this list of conditions and the following disclaimer in the documentation and/or other materials provided with the distribution.
//
//  THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.

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
    
    XCTAssertEqualObjects([begin KST_remove:remove], end);
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
