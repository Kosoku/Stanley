//
//  KSTNSObjectExtensionsTestCase.m
//  StanleyTests-iOS
//
//  Created by Jason Anderson on 12/13/17.
//  Copyright © 2017 Kosoku Interactive, LLC. All rights reserved.
//

#import <XCTest/XCTest.h>

#import <Stanley/NSObject+KSTExtensions.h>
#import <Stanley/KSTSnakeCaseToLlamaCaseValueTransformer.h>

@interface KSTTestObject: NSObject
@property (nonatomic, copy) NSString *excludedProperty;
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
    NSDictionary *jsonDict = @{@"string_property":@"stringValue",@"date_property":@"2017-12-14",@"bool_property":@YES,@"integer_property":@1,@"float_property":@1.0,@"dictionary_property":@{@"key":@"value"},@"array_property":@[@"first",@"second"]};
    [testObject KST_setPropertiesWithJSONDictionary:jsonDict dateFormatter:nil valueTransformer:[NSValueTransformer valueTransformerForName:KSTSnakeCaseToLlamaCaseValueTransformerName]];
    
    XCTAssertEqualObjects(testObject.stringProperty,@"stringValue");
    XCTAssertTrue(testObject.boolProperty);
    XCTAssertEqual(testObject.integerProperty,1);
    XCTAssertEqual(testObject.floatProperty,1.0);
    XCTAssertEqualObjects(testObject.dictionaryProperty[@"key"], @"value");
    XCTAssertEqualObjects(testObject.arrayProperty.firstObject, @"first");
}

- (void)testKST_dictionaryFromObject {
    KSTTestObject *testObject = [[KSTTestObject alloc] init];
    testObject.excludedProperty = @"excludeMe";
    testObject.stringProperty = @"stringValue";
    testObject.dateProperty = [NSDate date];
    testObject.boolProperty = YES;
    testObject.integerProperty = 1;
    testObject.floatProperty = 1.0;
    testObject.dictionaryProperty = @{@"key":@"value"};
    testObject.arrayProperty = @[@"first",@"second"];
    NSDictionary *jsonDict = [testObject KST_dictionaryWithValueTransformer:[NSValueTransformer valueTransformerForName:KSTSnakeCaseToLlamaCaseValueTransformerName] dateFormatter:nil excludingProperties:[NSSet setWithArray:@[@"excludedProperty"]]];
    
    XCTAssertEqualObjects(jsonDict[@"string_property"],@"stringValue");
    XCTAssertTrue([jsonDict[@"bool_property"] boolValue]);
    XCTAssertEqual([jsonDict[@"integer_property"] integerValue],1);
    XCTAssertEqual([jsonDict[@"float_property"] floatValue],1.0);
    XCTAssertEqualObjects(jsonDict[@"dictionary_property"][@"key"], @"value");
    XCTAssertEqualObjects(((NSArray *)jsonDict[@"array_property"]).firstObject, @"first");
    XCTAssertNil(jsonDict[@"excluded_property"]);
}

@end
