//
//  NSObject+KSTExtensions.h
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
