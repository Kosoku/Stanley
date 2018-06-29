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

- (void)testPerformIfResponds {
    KSTTestObject *object = [[KSTTestObject alloc] init];
    
    XCTAssertThrows([(id)object formUnionWithCharacterSet:NSCharacterSet.whitespaceCharacterSet]);
    XCTAssertNoThrow([(id)[object KST_performIfResponds] formUnionWithCharacterSet:NSCharacterSet.whitespaceCharacterSet]);
}
- (void)testPerformOrReturn {
    KSTTestObject *object = [[KSTTestObject alloc] init];
    
    XCTAssertThrows([(id)object countryCode]);
    XCTAssertNil([[(id)object KST_performOrReturn:nil] countryCode]);
    XCTAssertEqualObjects([[(id)object KST_performOrReturn:@"en"] countryCode], @"en");
}
- (void)testPerformOrReturnValue {
    KSTTestObject *object = [[KSTTestObject alloc] init];
    
    XCTAssertThrows([(id)object count]);
    XCTAssertEqual([[(id)object KST_performOrReturnValue:@0] count], 0);
}

- (void)testKST_setPropertiesWithJSONDictionary {
    KSTTestObject *testObject = [[KSTTestObject alloc] init];
    NSDictionary *jsonDict = @{@"string_property":@"stringValue",@"date_property":@"11/23/17",@"bool_property":@YES,@"integer_property":@1,@"float_property":@1.0,@"dictionary_property":@{@"key":@"value"},@"array_property":@[@"first",@"second"]};
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateStyle:NSDateFormatterShortStyle];
    [testObject KST_setPropertiesWithJSONDictionary:jsonDict dateFormatter:dateFormatter valueTransformer:[NSValueTransformer valueTransformerForName:KSTSnakeCaseToLlamaCaseValueTransformerName]];
    
    XCTAssertEqualObjects(testObject.stringProperty,@"stringValue");
    XCTAssertTrue(testObject.boolProperty);
    XCTAssertEqual(testObject.integerProperty,1);
    XCTAssertEqual(testObject.floatProperty,1.0);
    XCTAssertEqualObjects(testObject.dictionaryProperty[@"key"], @"value");
    XCTAssertEqualObjects(testObject.arrayProperty.firstObject, @"first");
    XCTAssertEqualObjects([dateFormatter stringFromDate:testObject.dateProperty], @"11/23/17");
}

- (void)testKST_dictionaryFromObject {
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *dateComponents = [[NSDateComponents alloc] init];
    [dateComponents setYear:2017];
    [dateComponents setMonth:11];
    [dateComponents setDay:23];
    KSTTestObject *testObject = [[KSTTestObject alloc] init];
    testObject.excludedProperty = @"excludeMe";
    testObject.stringProperty = @"stringValue";
    testObject.dateProperty = [calendar dateFromComponents:dateComponents];
    testObject.boolProperty = YES;
    testObject.integerProperty = 1;
    testObject.floatProperty = 1.0;
    testObject.dictionaryProperty = @{@"key":@"value"};
    testObject.arrayProperty = @[@"first",@"second"];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateStyle:NSDateFormatterShortStyle];
    NSDictionary *jsonDict = [testObject KST_dictionaryWithValueTransformer:[NSValueTransformer valueTransformerForName:KSTSnakeCaseToLlamaCaseValueTransformerName] dateFormatter:dateFormatter excludingProperties:[NSSet setWithArray:@[@"excludedProperty"]]];
    
    XCTAssertEqualObjects(jsonDict[@"string_property"],@"stringValue");
    XCTAssertTrue([jsonDict[@"bool_property"] boolValue]);
    XCTAssertEqual([jsonDict[@"integer_property"] integerValue],1);
    XCTAssertEqual([jsonDict[@"float_property"] floatValue],1.0);
    XCTAssertEqualObjects(jsonDict[@"dictionary_property"][@"key"], @"value");
    XCTAssertEqualObjects(((NSArray *)jsonDict[@"array_property"]).firstObject, @"first");
    XCTAssertNil(jsonDict[@"excluded_property"]);
    XCTAssertEqualObjects(jsonDict[@"date_property"], @"11/23/17");
}

@end
