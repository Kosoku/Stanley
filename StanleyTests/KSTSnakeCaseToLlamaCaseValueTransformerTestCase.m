//
//  KSTSnakeCaseToLlamaCaseValueTransformerTestCase.m
//  Stanley
//
//  Created by William Towe on 3/7/17.
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

#import <Stanley/KSTSnakeCaseToLlamaCaseValueTransformer.h>

@interface KSTSnakeCaseToLlamaCaseValueTransformerTestCase : XCTestCase

@end

@implementation KSTSnakeCaseToLlamaCaseValueTransformerTestCase

- (void)testTransformedValueClass {
    XCTAssertEqualObjects([[[NSValueTransformer valueTransformerForName:KSTSnakeCaseToLlamaCaseValueTransformerName] class] transformedValueClass], [NSString class]);
}
- (void)testAllowsReverseTransformation {
    XCTAssertTrue([[[NSValueTransformer valueTransformerForName:KSTSnakeCaseToLlamaCaseValueTransformerName] class] allowsReverseTransformation]);
}
- (void)testTransformedValue {
    NSString *start = @"first_middle_last";
    NSString *end = @"firstMiddleLast";
    
    XCTAssertEqualObjects([[NSValueTransformer valueTransformerForName:KSTSnakeCaseToLlamaCaseValueTransformerName] transformedValue:start], end);
    
    start = @"first";
    end = @"first";
    
    XCTAssertEqualObjects([[NSValueTransformer valueTransformerForName:KSTSnakeCaseToLlamaCaseValueTransformerName] transformedValue:start], end);
    
    start = @"First";
    end = @"first";
    
    XCTAssertEqualObjects([[NSValueTransformer valueTransformerForName:KSTSnakeCaseToLlamaCaseValueTransformerName] transformedValue:start], end);
    
    start = nil;
    
    XCTAssertNil([[NSValueTransformer valueTransformerForName:KSTSnakeCaseToLlamaCaseValueTransformerName] transformedValue:start]);
}
- (void)testReverseTransformedValue {
    NSString *start = @"firstMiddleLast";
    NSString *end = @"first_middle_last";
    
    XCTAssertEqualObjects([[NSValueTransformer valueTransformerForName:KSTSnakeCaseToLlamaCaseValueTransformerName] reverseTransformedValue:start], end);
    
    start = @"first";
    end = @"first";
    
    XCTAssertEqualObjects([[NSValueTransformer valueTransformerForName:KSTSnakeCaseToLlamaCaseValueTransformerName] reverseTransformedValue:start], end);
    
    start = nil;
    
    XCTAssertNil([[NSValueTransformer valueTransformerForName:KSTSnakeCaseToLlamaCaseValueTransformerName] reverseTransformedValue:start]);
}

@end
