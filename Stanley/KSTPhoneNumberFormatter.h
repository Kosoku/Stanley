//
//  KSTPhoneNumberFormatter.h
//  Stanley
//
//  Created by William Towe on 9/25/17.
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

/**
 KSTPhoneNumberFormatter is an NSFormatter subclass that can perform locale aware phone number formatting. It also supports formatting as the user types validation by implementing isPartialStringValid:proposedSelectedRange:originalString:originalSelectedRange:errorDescription: though the errorDescription parameter is ignored.
 */
@interface KSTPhoneNumberFormatter : NSFormatter

/**
 Returns the shared formatter object.
 */
@property (class,readonly,nonatomic) KSTPhoneNumberFormatter *sharedFormatter;

/**
 The locale to reference when formatting. If set to a non-nil value, the formatter will attempt to format using the specified locale regardless of the user or system locales.
 
 The default is NSLocale.currentLocale.
 */
@property (copy,nonatomic,null_resettable) NSLocale *locale;

/**
 Returns a formatted string suitable for display from the provided *phoneNumber*. For example @"1234567890" -> @"(123) 456-7890" in the en locale.
 
 This method always respects the receiver's `locale`.
 
 @param phoneNumber The phone number to format
 @return The formatted string
 */
- (nullable NSString *)stringFromPhoneNumber:(NSString *)phoneNumber;
/**
 Returns a formatted string suitable for display from the provided *phoneNumber*. For example @"1234567890" -> @"(123) 456-7890" in the en locale.
 
 This method always uses NSLocale.currentLocale when formatting.
 
 @param phoneNumber The phone number to format
 @return The formatted string
 */
- (nullable NSString *)localizedStringFromPhoneNumber:(NSString *)phoneNumber;

/**
 Returns a phone number stripped of all formatting. For example, @"(123) 456-7890" -> @"1234567890".
 
 @param string The formatted string
 @return The phone number
 */
- (nullable NSString *)phoneNumberFromString:(NSString *)string;
/**
 Returns the numeric phone number suitable for passing to frameworks like CallKit.
 
 @param string The formatted string
 @return The numeric phone number
 */
- (int64_t)numericPhoneNumberFromString:(NSString *)string;
/**
 Strips all formatting from the *string* except for digit characters and returns @"+" prepended to the resulting string.
 
 @param string The string to format
 @return The E.164 formatted phone number or nil
 */
- (nullable NSString *)E164PhoneNumberFromString:(NSString *)string;

@end

@interface NSCharacterSet (KSTPhoneNumberFormatterExtensions)

/**
 The complete set of characters KSTPhoneNumberFormatter allows in formatted string representations of phone numbers.
 */
@property (class,readonly,nonatomic) NSCharacterSet *KST_phoneNumberFormattedCharacterSet;
/**
 The complete set of characters that affect the routing of the phone number. This is defined as @"0123456789" + @"abcdABCD+*#".
 */
@property (class,readonly,nonatomic) NSCharacterSet *KST_phoneNumberRoutingCharacterSet;
/**
 The decimal digits allowed in phone numbers. This is defined as @"0123456789".
 */
@property (class,readonly,nonatomic) NSCharacterSet *KST_phoneNumberDecimalCharacterSet;

@end

NS_ASSUME_NONNULL_END
