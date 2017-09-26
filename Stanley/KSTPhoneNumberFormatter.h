//
//  KSTPhoneNumberFormatter.h
//  Stanley
//
//  Created by William Towe on 9/25/17.
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
