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
#import "NSBundle+KSTPrivateExtensions.h"
#import "KSTLoggingMacros.h"

static NSString *const kPhoneNumberFormatsName = @"PhoneNumberFormats";
static NSString *const kPhoneNumberFormatsExtension = @"plist";

static NSString *const kPlistKeyFormats = @"formats";
static NSString *const kPlistKeyFormat = @"format";
static NSString *const kPlistKeyPattern = @"pattern";

@interface KSTPhoneNumberFormatter ()
- (NSString *)_stringFromPhoneNumber:(NSString *)phoneNumber locale:(NSLocale *)locale;
- (NSURL *)_plistFileURLForLocale:(NSLocale *)locale;
- (BOOL)_formatPhoneNumber:(NSString *)phoneNumber outString:(NSString **)outString plist:(NSDictionary *)plist;
@end

@implementation KSTPhoneNumberFormatter
#pragma mark *** Subclass Overrides ***
- (NSString *)stringForObjectValue:(id)obj {
    if (![obj isKindOfClass:NSString.class]) {
        if ([obj respondsToSelector:@selector(stringValue)]) {
            obj = [obj stringValue];
        }
        else if ([obj respondsToSelector:@selector(description)]) {
            obj = [obj description];
        }
        else {
            return nil;
        }
    }
    
    return [self _stringFromPhoneNumber:obj locale:self.locale];
}
- (BOOL)getObjectValue:(out id  _Nullable __autoreleasing *)obj forString:(NSString *)string errorDescription:(out NSString *__autoreleasing  _Nullable *)error {
    *obj = [self phoneNumberFromString:string];
    return YES;
}
- (BOOL)isPartialStringValid:(NSString *__autoreleasing  _Nonnull *)partialStringPtr proposedSelectedRange:(NSRangePointer)proposedSelRangePtr originalString:(NSString *)origString originalSelectedRange:(NSRange)origSelRange errorDescription:(NSString *__autoreleasing  _Nullable *)error {
    // ignore the empty string
    if ((*partialStringPtr).length == 0) {
        return YES;
    }
    // ignore deletions
    else if ((*partialStringPtr).length < origString.length) {
        return YES;
    }
    // only format when the user enters new text
    else {
        NSString *string = [self stringFromPhoneNumber:*partialStringPtr];
        NSRange range = NSMakeRange(NSMaxRange([string rangeOfCharacterFromSet:NSCharacterSet.KST_phoneNumberDecimalCharacterSet options:NSBackwardsSearch range:NSMakeRange(0, string.length)]), 0);
        
        if (NSMaxRange(range) < string.length) {
            range = NSMakeRange(string.length, 0);
        }
        
        *partialStringPtr = string;
        *proposedSelRangePtr = range;
        return NO;
    }
}
#pragma mark *** Public Methods ***
- (NSString *)stringFromPhoneNumber:(NSString *)phoneNumber {
    return [self _stringFromPhoneNumber:phoneNumber locale:self.locale];
}
- (NSString *)localizedStringFromPhoneNumber:(NSString *)phoneNumber; {
    return [self _stringFromPhoneNumber:phoneNumber locale:NSLocale.currentLocale];
}
#pragma mark -
- (NSString *)phoneNumberFromString:(NSString *)string {
    return [[string KST_stringByRemovingCharactersInSet:NSCharacterSet.KST_phoneNumberRoutingCharacterSet.invertedSet] KST_stringByTrimmingLeadingCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@"0"]].uppercaseString;
}
- (int64_t)numericPhoneNumberFromString:(NSString *)string; {
    return [[string KST_stringByRemovingCharactersInSet:NSCharacterSet.KST_phoneNumberDecimalCharacterSet.invertedSet] KST_stringByTrimmingLeadingCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@"0"]].longLongValue;
}
#pragma mark Properties
+ (KSTPhoneNumberFormatter *)sharedFormatter {
    static KSTPhoneNumberFormatter *kRetval;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        kRetval = [[KSTPhoneNumberFormatter alloc] init];
    });
    return kRetval;
}

- (NSLocale *)locale {
    return _locale ?: NSLocale.currentLocale;
}
#pragma mark *** Private Methods ***
- (NSString *)_stringFromPhoneNumber:(NSString *)phoneNumber locale:(NSLocale *)locale; {
    if (phoneNumber.length == 0) {
        return nil;
    }
    
    NSURL *fileURL = [self _plistFileURLForLocale:locale];
    NSData *data = [NSData dataWithContentsOfURL:fileURL];
    NSDictionary *plist = [NSPropertyListSerialization propertyListWithData:data options:0 format:NULL error:NULL];
    NSString *retval = phoneNumber;
    
    if (![self _formatPhoneNumber:phoneNumber outString:&retval plist:plist]) {
        fileURL = [[NSBundle KST_frameworkBundle] URLForResource:kPhoneNumberFormatsName withExtension:kPhoneNumberFormatsExtension subdirectory:nil localization:@"Base"];
        
        data = [NSData dataWithContentsOfURL:fileURL];
        plist = [NSPropertyListSerialization propertyListWithData:data options:0 format:NULL error:NULL];
        
        [self _formatPhoneNumber:phoneNumber outString:&retval plist:plist];
    }
    
    return retval;
}
- (NSURL *)_plistFileURLForLocale:(NSLocale *)locale; {
    NSURL *retval = [[NSBundle KST_frameworkBundle] URLForResource:kPhoneNumberFormatsName withExtension:kPhoneNumberFormatsExtension subdirectory:nil localization:locale.localeIdentifier];
    
    if (retval == nil) {
        retval = [[NSBundle KST_frameworkBundle] URLForResource:kPhoneNumberFormatsName withExtension:kPhoneNumberFormatsExtension subdirectory:nil localization:[locale objectForKey:NSLocaleLanguageCode]];
    }
    
    return retval;
}
- (BOOL)_formatPhoneNumber:(NSString *)phoneNumber outString:(NSString **)outString plist:(NSDictionary *)plist; {
    NSString *string = [phoneNumber KST_stringByRemovingCharactersInSet:NSCharacterSet.KST_phoneNumberRoutingCharacterSet.invertedSet];
    
    for (NSDictionary *dict in plist[kPlistKeyFormats]) {
        NSString *pattern = dict[kPlistKeyPattern];
        NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:pattern options:0 error:NULL];
        NSTextCheckingResult *match = [regex firstMatchInString:string options:NSMatchingAnchored range:NSMakeRange(0, string.length)];
        
        if (match == nil) {
            continue;
        }
        
        NSString *format = dict[kPlistKeyFormat];
        NSUInteger formatIndex = 0;
        NSUInteger stringIndex = 0;
        NSMutableString *retval = [[NSMutableString alloc] init];
        
        while (formatIndex < format.length &&
               stringIndex < string.length) {
            
            unichar fc = [format characterAtIndex:formatIndex++];
            
            if (fc == 'x') {
                unichar sc = [string characterAtIndex:stringIndex++];
                
                [retval appendFormat:@"%C",sc];
            }
            else {
                [retval appendFormat:@"%C",fc];
            }
        }
        
        while (formatIndex < format.length) {
            unichar fc = [format characterAtIndex:formatIndex++];
            
            if (fc == 'x') {
                break;
            }
            else {
                [retval appendFormat:@"%C",fc];
            }
        }
        
        if ([retval rangeOfString:@"("].length > 0 &&
            [retval rangeOfString:@")"].length == 0) {
            
            [retval appendString:@" )"];
        }
        
        *outString = [retval copy];
        
        return YES;
    }
    return NO;
}

@end

@implementation NSCharacterSet (KSTPhoneNumberFormatterExtensions)

+ (NSCharacterSet *)KST_phoneNumberFormattedCharacterSet {
    NSMutableCharacterSet *retval = [[self KST_phoneNumberRoutingCharacterSet] mutableCopy];
    
    // \u00A0 is non-breaking space
    [retval addCharactersInString:@"-.,;()\u00A0"];
    
    return [retval copy];
}
+ (NSCharacterSet *)KST_phoneNumberRoutingCharacterSet {
    NSMutableCharacterSet *retval = [[self KST_phoneNumberDecimalCharacterSet] mutableCopy];
    
    [retval addCharactersInString:@"abcdABCD+*#"];
    
    return [retval copy];
}
+ (NSCharacterSet *)KST_phoneNumberDecimalCharacterSet {
    return NSCharacterSet.decimalDigitCharacterSet;
}

@end
