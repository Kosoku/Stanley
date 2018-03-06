//
//  NSObject+KSTExtensions.m
//  Stanley
//
//  Created by Jason Anderson on 12/7/17.
//  Copyright © 2017 Kosoku Interactive, LLC. All rights reserved.
//
//  Redistribution and use in source and binary forms, with or without modification, are permitted provided that the following conditions are met:
//
//  1. Redistributions of source code must retain the above copyright notice, this list of conditions and the following disclaimer.
//
//  2. Redistributions in binary form must reproduce the above copyright notice, this list of conditions and the following disclaimer in the documentation and/or other materials provided with the distribution.
//
//  THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.

#import "NSObject+KSTExtensions.h"

#import <objc/runtime.h>

typedef NSString* KSTPropertyType NS_EXTENSIBLE_STRING_ENUM;
KSTPropertyType const KSTPropertyTypeBool = @"BOOL";
KSTPropertyType const KSTPropertyTypeInt = @"int";
KSTPropertyType const KSTPropertyTypeLong = @"long";
KSTPropertyType const KSTPropertyTypeFloat = @"float";
KSTPropertyType const KSTPropertyTypeId = @"id";
KSTPropertyType const KSTPropertyTypeNSDate = @"NSDate";

@implementation NSObject (KSTExtensions)

- (nullable NSDictionary *)KST_dictionaryWithValueTransformer:(nullable NSValueTransformer *)transformer dateFormatter:(nullable NSDateFormatter *)dateFormatter excludingProperties:(NSSet <NSString *> *)properties; {
        Class objClass = self.class;
        if (objClass == NULL) {
            return nil;
        }
        
        NSMutableDictionary *retval = [[NSMutableDictionary alloc] init];
        
        unsigned int count;
        objc_property_t *objProperties = class_copyPropertyList(objClass, &count);
        for (int i = 0; i < count; i++) {
            objc_property_t property = objProperties[i];
            if (property) {
                const char *propertyName = property_getName(property);
                if (propertyName) {
                    NSString *key = [NSString stringWithUTF8String:propertyName];
                    NSString *const kDictionaryKey = (transformer) ? [transformer reverseTransformedValue:key] : key;
                    id value = [self valueForKey:key];
                    if (value) {
                        if (![properties containsObject:key]) {
                            if ([value isKindOfClass:[NSString class]] || [value isKindOfClass:[NSDictionary class]]) {
                                [retval setObject:value forKey:kDictionaryKey];
                            } else if ([value isKindOfClass:[NSArray class]]) {
                                NSMutableArray *tempArray = [NSMutableArray array];
                                for (id object in (NSArray *)value) {
                                    if ([object isKindOfClass:[NSDictionary class]]) {
                                        NSDictionary *newDict = [object KST_dictionaryWithValueTransformer:transformer dateFormatter:dateFormatter excludingProperties:properties];
                                        [tempArray addObject:newDict];
                                    } else {
                                        [tempArray addObject:object];
                                    }
                                }
                                [retval setObject:[NSArray arrayWithArray:tempArray] forKey:kDictionaryKey];
                            } else if ([value isKindOfClass:[NSDate class]]) {
                                if (dateFormatter) {
                                    [retval setObject:[dateFormatter stringFromDate:(NSDate *)value] forKey:kDictionaryKey];
                                } else {
                                    [retval setObject:@([(NSDate *)value timeIntervalSince1970]) forKey:kDictionaryKey];
                                }
                            } else if ([value isKindOfClass:[NSNumber class]]) {
                                KSTPropertyType propertyType = [self KST_propertyType:property];
                                if ([propertyType isEqualToString:KSTPropertyTypeBool]) {
                                    [retval setValue:@([value boolValue]) forKey:kDictionaryKey];
                                } if ([propertyType isEqualToString:KSTPropertyTypeInt]) {
                                    [retval setValue:@([value intValue]) forKey:kDictionaryKey];
                                } if ([propertyType isEqualToString:KSTPropertyTypeLong]) {
                                    [retval setValue:@([value longValue]) forKey:kDictionaryKey];
                                } if ([propertyType isEqualToString:KSTPropertyTypeFloat]) {
                                    [retval setValue:@([value floatValue]) forKey:kDictionaryKey];
                                }
                            } else if ([value conformsToProtocol:@protocol(NSCoding)]) {
                                NSData *data = [NSKeyedArchiver archivedDataWithRootObject:value];
                                NSString *base64String = [data base64EncodedStringWithOptions:0];
                                [retval setObject:base64String forKey:kDictionaryKey];
                            } else {
                                NSDictionary *newDict = [value KST_dictionaryWithValueTransformer:transformer dateFormatter:dateFormatter excludingProperties:properties];
                                [retval setObject:newDict forKey:kDictionaryKey];
                            }
                        }
                    }
                    
                }
            }
        }
        free(objProperties);
        
        return retval;
}

- (void)KST_setPropertiesWithJSONDictionary:(NSDictionary <NSString *, id> *)dictionary dateFormatter:(nullable NSDateFormatter *)dateFormatter valueTransformer:(nullable NSValueTransformer *)transformer; {
    Class objClass = self.class;
    if (objClass == NULL) {
        return;
    }
    
    [dictionary enumerateKeysAndObjectsUsingBlock:^(NSString * _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
        NSString *const kPropertyKey = (transformer) ? [transformer transformedValue:key] : key;
        
        if (![obj isMemberOfClass:[NSNull class]] && ![key isEqualToString:KSTPropertyTypeId]) {
            @try {
                objc_property_t property = class_getProperty(objClass, [kPropertyKey UTF8String]);
                if (property) {
                    KSTPropertyType propertyType = [self KST_propertyType:property];
                    if ([propertyType isEqualToString:KSTPropertyTypeNSDate] && [obj isKindOfClass:[NSString class]]) {
                        NSDateFormatter *const formatter = (dateFormatter) ? dateFormatter : [[NSDateFormatter alloc] init];
                        NSDate *date = [formatter dateFromString:obj];
                        [self setValue:date forKey:kPropertyKey];
                    } else if ([propertyType isEqualToString:KSTPropertyTypeNSDate] && [obj isKindOfClass:[NSNumber class]]) {
                        NSDate *date = [NSDate dateWithTimeIntervalSince1970:[obj longValue]];
                        [self setValue:date forKey:kPropertyKey];
                    } else {
                        [self setValue:obj forKey:kPropertyKey];
                    }
                }
            } @catch (NSException *exception) { }
        }
    }];
}

- (KSTPropertyType)KST_propertyType:(objc_property_t)property {
    const char *type = property_getAttributes(property);
    NSString *typeString = [NSString stringWithUTF8String:type];
    NSArray *attributes = [typeString componentsSeparatedByString:@","];
    NSString *typeAttribute = [attributes objectAtIndex:0];
    NSString *propertyType = [typeAttribute substringFromIndex:1];
    const char *rawPropertyType = [propertyType UTF8String];
    
    if (strcmp(rawPropertyType, @encode(BOOL)) == 0) {
        return KSTPropertyTypeBool;
    } else if (strcmp(rawPropertyType, @encode(int)) == 0) {
        return KSTPropertyTypeInt;
    } else if (strcmp(rawPropertyType, @encode(long)) == 0) {
        return KSTPropertyTypeLong;
    } else if (strcmp(rawPropertyType, @encode(float)) == 0) {
        return KSTPropertyTypeFloat;
    }
    
    if ([typeAttribute hasPrefix:@"T@"] && [typeAttribute length] > 1) {
        NSString *typeClassName = [typeAttribute substringWithRange:NSMakeRange(3, [typeAttribute length]-4)];
        if ([typeClassName isEqualToString:KSTPropertyTypeNSDate]) {
            return KSTPropertyTypeNSDate;
        }
    }
    
    return KSTPropertyTypeId;
}

static void const *kKST_representedObjectKey = &kKST_representedObjectKey;
@dynamic KST_representedObject;
- (id)KST_representedObject {
    return objc_getAssociatedObject(self, kKST_representedObjectKey);
}
- (void)setKST_representedObject:(id)KST_representedObject {
    objc_setAssociatedObject(self, kKST_representedObjectKey, KST_representedObject, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

@end
