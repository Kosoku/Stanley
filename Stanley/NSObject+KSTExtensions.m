//
//  NSObject+KSTExtensions.m
//  Stanley
//
//  Created by Jason Anderson on 12/7/17.
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

#import "NSObject+KSTExtensions.h"

#import <objc/runtime.h>

typedef NSString* KSTPropertyType NS_EXTENSIBLE_STRING_ENUM;
KSTPropertyType const KSTPropertyTypeBool = @"BOOL";
KSTPropertyType const KSTPropertyTypeInt = @"int";
KSTPropertyType const KSTPropertyTypeLong = @"long";
KSTPropertyType const KSTPropertyTypeFloat = @"float";
KSTPropertyType const KSTPropertyTypeId = @"id";
KSTPropertyType const KSTPropertyTypeNSDate = @"NSDate";

typedef void(^KSTPerformProxyReturnValueHandler)(NSInvocation *invocation);

@interface KSTPerformProxy : NSProxy
@property (strong,nonatomic) id target;
@property (assign,nonatomic) const char *returnType;
@property (copy,nonatomic) KSTPerformProxyReturnValueHandler returnValueHandler;

- (id)initWithTarget:(id)target returnType:(const char *)returnType returnValueHandler:(KSTPerformProxyReturnValueHandler)returnValueHandler;
@end

@implementation NSObject (KSTExtensions)

static void const *kKST_representedObjectKey = &kKST_representedObjectKey;
@dynamic KST_representedObject;
- (id)KST_representedObject {
    return objc_getAssociatedObject(self, kKST_representedObjectKey);
}
- (void)setKST_representedObject:(id)KST_representedObject {
    objc_setAssociatedObject(self, kKST_representedObjectKey, KST_representedObject, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

// implementation for perform methods taken from https://bou.io/PerformIfResponds.html and https://github.com/n-b/PerformIfResponds
- (instancetype)KST_performIfResponds {
    return (id)[[KSTPerformProxy alloc] initWithTarget:self returnType:@encode(void) returnValueHandler:^(NSInvocation *invocation){}];
}
- (instancetype)KST_performOrReturn:(id)value {
    return (id)[[KSTPerformProxy alloc] initWithTarget:self returnType:@encode(id) returnValueHandler:^(NSInvocation *invocation){
        id retval = value;
        
        [invocation setReturnValue:&retval];
    }];
}
- (instancetype)KST_performOrReturnValue:(NSValue *)value {
    return (id)[[KSTPerformProxy alloc] initWithTarget:self returnType:value.objCType returnValueHandler:^(NSInvocation *invocation){
        char buffer[invocation.methodSignature.methodReturnLength];
        
        [value getValue:&buffer];
        
        [invocation setReturnValue:&buffer];
    }];
}

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
                            NSData *data = [NSKeyedArchiver archivedDataWithRootObject:value requiringSecureCoding:false error:NULL];
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

@end

@implementation KSTPerformProxy
- (id)initWithTarget:(id)target returnType:(const char *)returnType returnValueHandler:(KSTPerformProxyReturnValueHandler)returnValueHandler {
    _target = target;
    _returnType = returnType;
    _returnValueHandler = [returnValueHandler copy];
    
    return self;
}

- (id)forwardingTargetForSelector:(SEL)sel {
    if ([self.target respondsToSelector:sel]) {
        return self.target;
    }
    else {
        return self;
    }
}
- (NSMethodSignature *)methodSignatureForSelector:(SEL)sel {
    NSString *types = [NSString stringWithFormat:@"%s%s%s",self.returnType,@encode(id),@encode(SEL)];
    
    return [NSMethodSignature signatureWithObjCTypes:types.UTF8String];
}
- (void)forwardInvocation:(NSInvocation *)invocation {
    self.returnValueHandler(invocation);
}
@end
