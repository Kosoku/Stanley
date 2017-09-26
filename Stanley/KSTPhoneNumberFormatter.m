//
//  KSTPhoneNumberFormatter.m
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

#import "KSTPhoneNumberFormatter.h"
#import "NSString+KSTExtensions.h"

@implementation KSTPhoneNumberFormatter

- (NSString *)stringForObjectValue:(id)obj {
    if (![obj isKindOfClass:NSString.class] ||
        [(NSString *)obj length] == 0) {
        
        return nil;
    }
    
    return obj;
}
- (BOOL)getObjectValue:(out id  _Nullable __autoreleasing *)obj forString:(NSString *)string errorDescription:(out NSString *__autoreleasing  _Nullable *)error {
    *obj = [self phoneNumberFromString:string];
    return YES;
}
- (BOOL)isPartialStringValid:(NSString *__autoreleasing  _Nonnull *)partialStringPtr proposedSelectedRange:(NSRangePointer)proposedSelRangePtr originalString:(NSString *)origString originalSelectedRange:(NSRange)origSelRange errorDescription:(NSString *__autoreleasing  _Nullable *)error {
    *partialStringPtr = [self phoneNumberFromString:*partialStringPtr];
    *proposedSelRangePtr = NSMakeRange((*partialStringPtr).length, 0);
    return NO;
}

- (NSString *)stringFromPhoneNumber:(NSString *)phoneNumber {
    return [self stringForObjectValue:phoneNumber];
}
- (NSString *)phoneNumberFromString:(NSString *)string {
    return [string KST_stringByRemovingCharactersInSet:NSCharacterSet.decimalDigitCharacterSet.invertedSet];
}

- (NSString *)localizedStringFromPhoneNumber:(NSString *)phoneNumber; {
    return [self stringFromPhoneNumber:phoneNumber];
}

@end
