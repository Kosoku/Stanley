//
//  KSTNSObjectExtensionsTestCase.m
//  StanleyTests-iOS
//
//  Created by Jason Anderson on 12/13/17.
//  Copyright © 2017 Kosoku Interactive, LLC. All rights reserved.
//

#import <XCTest/XCTest.h>

#import <Stanley/NSObject+KSTExtensions.h>

@interface KSTTestObject: NSObject
@property (nonatomic, copy) NSString *stringProperty;
@property (nonatomic, copy) NSDate *dateProperty;
@property (nonatomic, assign) BOOL boolProperty;
@property (nonatomic, assign) NSInteger integerProperty;
@property (nonatomic, assign) float floatProperty;
@property (nonatomic, copy) NSDictionary<NSString *,NSString *> *dictionaryProperty;
@property (nonatomic, copy) NSArray<NSString *> *arrayProperty;
@end
@implementation KSTTestObject
@end

@interface KSTNSObjectExtensionsTestCase : XCTestCase

@end

@implementation KSTNSObjectExtensionsTestCase

- (void)testKST_setPropertiesWithJSONDictionary {
    KSTTestObject *testObject = [[KSTTestObject alloc] init];
    NSDictionary *jsonDict = @{@"stringProperty":@"stringValue",@"dateProperty":@"2017-12-14",@"boolProperty":@YES,@"integerProperty":@1,@"floatProperty":@1.0,@"dictionaryProperty":@{@"key":@"value"},@"arrayProperty":@[@"first",@"second"]};
    [testObject KST_setPropertiesWithJSONDictionary:jsonDict dateFormatter:nil valueTransformer:nil];
    
    XCTAssertEqualObjects(testObject.stringProperty,@"stringValue");
    XCTAssertTrue(testObject.boolProperty);
    XCTAssertEqual(testObject.integerProperty,1);
    XCTAssertEqual(testObject.floatProperty,1.0);
    XCTAssertEqualObjects(testObject.dictionaryProperty[@"key"], @"value");
    XCTAssertEqualObjects(testObject.arrayProperty.firstObject, @"first");
}

- (void)testKST_dictionaryFromObject {
    KSTTestObject *testObject = [[KSTTestObject alloc] init];
    testObject.stringProperty = @"stringValue";
    testObject.dateProperty = [NSDate date];
    testObject.boolProperty = YES;
    testObject.integerProperty = 1;
    testObject.floatProperty = 1.0;
    testObject.dictionaryProperty = @{@"key":@"value"};
    testObject.arrayProperty = @[@"first",@"second"];
    NSDictionary *jsonDict = [testObject KST_dictionaryWithValueTransformer:nil dateFormatter:nil excludingProperties:[NSSet setWithArray:@[]]];
    
    XCTAssertEqualObjects(jsonDict[@"stringProperty"],@"stringValue");
    XCTAssertTrue([jsonDict[@"boolProperty"] boolValue]);
    XCTAssertEqual([jsonDict[@"integerProperty"] integerValue],1);
    XCTAssertEqual([jsonDict[@"floatProperty"] floatValue],1.0);
    XCTAssertEqualObjects(jsonDict[@"dictionaryProperty"][@"key"], @"value");
    XCTAssertEqualObjects(((NSArray *)jsonDict[@"arrayProperty"]).firstObject, @"first");
}

@end
