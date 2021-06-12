//
//  NSObject+KSTExtensions.h
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

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSObject (KSTExtensions)

/**
 Set and get an arbitrary object associated with the receiver. Convenience property to associate additional objects with the receiver.
 */
@property (strong,nonatomic,nullable) id KST_representedObject;

/**
 Used in place of a respondsToSelector: check before calling a method that returns void. For example:
 
 MyClass foo = ...;
 
 if ([foo respondsToSelector:@selector(bar)]) {
    [foo bar];
 }
 
 would become:
 
 MyClass foo = ...;
 
 [[foo KST_performIfResponds] bar];
 */
- (instancetype)KST_performIfResponds;
/**
 Used in place of a respondsToSelector: check before calling a method that returns an id value. For example:
 
 MyClass foo = ...;
 
 if ([foo respondsToSelector:@selector(baz)]) {
    id retval = [foo baz];
 }
 
 would become:
 
 MyClass foo = ...;
 id retval = [[foo KST_performOrReturn:nil] baz];
 
 @param value The default return value that should be used if the receiver does not respond to the method
 @return Either the return value from the receiver or the default return value
 */
- (instancetype)KST_performOrReturn:(nullable id)value;
/**
 Used in place of a respondsToSelector: check before calling a method that returns a non-object value (struct, primitive, etc). For example:
 
 MyClass foo = ...;
 
 if ([foo respondsToSelector:@selector(boop)]) {
    NSUInteger retval = [foo boop];
 }
 
 would become:
 
 MyClass foo = ...;
 NSUInteger retval = [[foo KST_performOrReturnValue:@0] boop];
 
 @param value The default value that should be used if the receiver does not respond to the method
 @return Either the return value from the receiver or the default return value
 */
- (instancetype)KST_performOrReturnValue:(nullable NSValue *)value;

/**
 A method for mapping the properties of an NSObject and returning the contents as an NSDictionary
 
 @param transformer An NSValueTransformer instance for converting the property names/dictionary keys
 @param dateFormatter An NSDateFormatter to format NSDate properties
 @param properties A set of property names to be excluded from the return dictionary
 @return The dictionary representaiton of the object
 */
- (nullable NSDictionary *)KST_dictionaryWithValueTransformer:(nullable NSValueTransformer *)transformer dateFormatter:(nullable NSDateFormatter *)dateFormatter excludingProperties:(NSSet <NSString *> *)properties;

/**
 A method for populating the properties of an NSObject with a JSON dictionary
 
 @param dictionary The dictionary representation of the object to populate
 @param dateFormatter An NSDateFormatter to format NSDate properties
 @param transformer An NSValueTrasformer for converting JSON keys to property names
 */
- (void)KST_setPropertiesWithJSONDictionary:(NSDictionary <NSString *, id> *)dictionary dateFormatter:(nullable NSDateFormatter *)dateFormatter valueTransformer:(nullable NSValueTransformer *)transformer;

@end

NS_ASSUME_NONNULL_END
