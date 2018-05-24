//
//  KSTFunctionsTestCase.m
//  Stanley
//
//  Created by William Towe on 4/20/17.
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

#import <Stanley/KSTFunctions.h>

@interface KSTFunctionsTestCase : XCTestCase

@end

@implementation KSTFunctionsTestCase

- (void)testIsEmptyObject {
    XCTAssertEqual(KSTIsEmptyObject(nil), YES);
    XCTAssertEqual(KSTIsEmptyObject(NSNull.null), YES);
    XCTAssertEqual(KSTIsEmptyObject(@""), YES);
    XCTAssertEqual(KSTIsEmptyObject(@[]), YES);
    XCTAssertEqual(KSTIsEmptyObject(@{}), YES);
    XCTAssertEqual(KSTIsEmptyObject([NSData data]), YES);
}

- (void)testDispatchMain {
    XCTestExpectation *expect1 = [self expectationWithDescription:@"testDispatchMain1"];
    XCTestExpectation *expect2 = [self expectationWithDescription:@"testDispatchMain2"];
    XCTestExpectation *expect3 = [self expectationWithDescription:@"testDispatchMain3"];
    XCTestExpectation *expect4 = [self expectationWithDescription:@"testDispatchMain4"];
    
    KSTDispatchMainSync(^{
        XCTAssertTrue([NSThread isMainThread]);
        [expect1 fulfill];
    });
    KSTDispatchMainAsync(^{
        XCTAssertTrue([NSThread isMainThread]);
        [expect2 fulfill];
    });
    dispatch_async(dispatch_get_global_queue(QOS_CLASS_DEFAULT, 0), ^{
        KSTDispatchMainSync(^{
            XCTAssertTrue([NSThread isMainThread]);
            [expect3 fulfill];
        });
        KSTDispatchMainAsync(^{
            XCTAssertTrue([NSThread isMainThread]);
            [expect4 fulfill];
        });
    });
    
    [self waitForExpectationsWithTimeout:5.0 handler:nil];
}
- (void)testDispatchAfter {
    XCTestExpectation *expect1 = [self expectationWithDescription:@"testDispatchAfter1"];
    XCTestExpectation *expect2 = [self expectationWithDescription:@"testDispatchAfter2"];
    XCTestExpectation *expect3 = [self expectationWithDescription:@"testDispatchAfter3"];
    
    KSTDispatchMainAfter(0.1, ^{
        XCTAssertTrue([NSThread isMainThread]);
        [expect1 fulfill];
    });
    KSTDispatchAfter(0.1, dispatch_get_main_queue(), ^{
        XCTAssertTrue([NSThread isMainThread]);
        [expect2 fulfill];
    });
    KSTDispatchAfter(0.1, nil, ^{
        XCTAssertTrue([NSThread isMainThread]);
        [expect3 fulfill];
    });
    
    [self waitForExpectationsWithTimeout:5.0 handler:nil];
}

@end
