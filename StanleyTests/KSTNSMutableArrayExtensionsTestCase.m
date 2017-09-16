//
//  KSTNSMutableArrayExtensionsTestCase.m
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
