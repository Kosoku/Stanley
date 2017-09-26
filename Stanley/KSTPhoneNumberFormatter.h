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

@interface KSTPhoneNumberFormatter : NSFormatter

@property (copy,nonatomic,null_resettable) NSLocale *locale;

- (nullable NSString *)stringFromPhoneNumber:(NSString *)phoneNumber;
- (nullable NSString *)phoneNumberFromString:(NSString *)string;

+ (nullable NSString *)localizedStringFromPhoneNumber:(NSString *)phoneNumber;

@end

@interface NSCharacterSet (KSTPhoneNumberFormatterExtensions)

@property (class,readonly,nonatomic) NSCharacterSet *KST_phoneNumberFormattedCharacterSet;
@property (class,readonly,nonatomic) NSCharacterSet *KST_phoneNumberRoutingCharacterSet;
@property (class,readonly,nonatomic) NSCharacterSet *KST_phoneNumberDecimalCharacterSet;

@end

NS_ASSUME_NONNULL_END
