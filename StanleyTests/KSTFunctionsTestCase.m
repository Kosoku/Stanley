//
//  KSTFunctionsTestCase.m
//  Stanley
//
//  Created by William Towe on 4/20/17.
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
- (void)testNullIfEmptyOrObject {
    XCTAssertEqualObjects(KSTNullIfEmptyOrObject(nil), NSNull.null);
    XCTAssertEqualObjects(KSTNullIfEmptyOrObject(@""), NSNull.null);
    XCTAssertEqualObjects(KSTNullIfEmptyOrObject(@[]), NSNull.null);
    XCTAssertEqualObjects(KSTNullIfEmptyOrObject(@{}), NSNull.null);
    XCTAssertEqualObjects(KSTNullIfEmptyOrObject([NSData data]), NSNull.null);
    
    XCTAssertNotEqualObjects(KSTNullIfEmptyOrObject(@"a"), NSNull.null);
    XCTAssertNotEqualObjects(KSTNullIfEmptyOrObject(@[@1]), NSNull.null);
    XCTAssertNotEqualObjects(KSTNullIfEmptyOrObject(@{@1: @"a"}), NSNull.null);
}
- (void)testNilIfEmptyOrObject {
    XCTAssertNil(KSTNilIfEmptyOrObject(nil));
    XCTAssertNil(KSTNilIfEmptyOrObject(@""));
    XCTAssertNil(KSTNilIfEmptyOrObject(@[]));
    XCTAssertNil(KSTNilIfEmptyOrObject(@{}));
    XCTAssertNil(KSTNilIfEmptyOrObject([NSData data]));
    
    XCTAssertNotNil(KSTNilIfEmptyOrObject(@"a"));
    XCTAssertNotNil(KSTNilIfEmptyOrObject(@[@1]));
    XCTAssertNotNil(KSTNilIfEmptyOrObject(@{@1: @"a"}));
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
