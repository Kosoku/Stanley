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

@interface KSTPhoneNumberFormatter ()
@property (strong,nonatomic) NSNumberFormatter *numberFormatter;

- (BOOL)_formatPhoneNumber:(NSString *)phoneNumber outString:(NSString **)outString plist:(NSDictionary *)plist;
@end

@implementation KSTPhoneNumberFormatter

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
    
    NSString *resourceName = @"PhoneNumberFormats";
    NSString *resourceExtension = @"plist";
    NSURL *localizedFileURL = [[NSBundle KST_frameworkBundle] URLForResource:resourceName withExtension:resourceExtension];
    
    KSTLog(@"phone number formats file URL %@",localizedFileURL);
    
    NSData *data = [NSData dataWithContentsOfURL:localizedFileURL];
    NSDictionary *plist = [NSPropertyListSerialization propertyListWithData:data options:0 format:NULL error:NULL];
    NSString *retval = obj;
    
    if (![self _formatPhoneNumber:obj outString:&retval plist:plist]) {
        NSURL *baseFileURL = [[NSBundle KST_frameworkBundle] URLForResource:resourceName withExtension:resourceExtension subdirectory:nil localization:@"Base"];
        
        data = [NSData dataWithContentsOfURL:baseFileURL];
        
        plist = [NSPropertyListSerialization propertyListWithData:data options:0 format:NULL error:NULL];
        
        [self _formatPhoneNumber:obj outString:&retval plist:plist];
    }
    
    return retval;
}
- (BOOL)getObjectValue:(out id  _Nullable __autoreleasing *)obj forString:(NSString *)string errorDescription:(out NSString *__autoreleasing  _Nullable *)error {
    *obj = [self phoneNumberFromString:string];
    return YES;
}
- (BOOL)isPartialStringValid:(NSString *__autoreleasing  _Nonnull *)partialStringPtr proposedSelectedRange:(NSRangePointer)proposedSelRangePtr originalString:(NSString *)origString originalSelectedRange:(NSRange)origSelRange errorDescription:(NSString *__autoreleasing  _Nullable *)error {
    if ((*partialStringPtr).length < origString.length) {
        return YES;
    }
    else {
        *partialStringPtr = [self stringFromPhoneNumber:*partialStringPtr];
        *proposedSelRangePtr = NSMakeRange((*partialStringPtr).length, 0);
        return NO;
    }
}

- (NSString *)stringFromPhoneNumber:(NSString *)phoneNumber {
    return [self stringForObjectValue:phoneNumber];
}
- (NSString *)phoneNumberFromString:(NSString *)string {
    return [[string KST_stringByRemovingCharactersInSet:NSCharacterSet.KST_phoneNumberRoutingCharacterSet.invertedSet] KST_stringByTrimmingLeadingCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@"0"]];
}

- (NSString *)localizedStringFromPhoneNumber:(NSString *)phoneNumber; {
    return [self stringFromPhoneNumber:phoneNumber];
}

- (BOOL)_formatPhoneNumber:(NSString *)phoneNumber outString:(NSString **)outString plist:(NSDictionary *)plist; {
    NSString *string = [phoneNumber KST_stringByRemovingCharactersInSet:NSCharacterSet.KST_phoneNumberRoutingCharacterSet.invertedSet];
    
    KSTLog(@"attempting to format %@",string);
    
    for (NSDictionary *dict in plist[KSTPhoneNumberFormatterKeyPlistKeyFormats]) {
        NSString *pattern = dict[KSTPhoneNumberFormatterKeyPlistKeyPattern];
        NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:pattern options:0 error:NULL];
        NSTextCheckingResult *match = [regex firstMatchInString:string options:NSMatchingAnchored range:NSMakeRange(0, string.length)];
        
        if (match == nil) {
            continue;
        }
        
        KSTLog(@"match against pattern %@",pattern);
        
        NSString *format = dict[KSTPhoneNumberFormatterKeyPlistKeyFormat];
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
        
        KSTLog(@"formatted string %@",retval);
        
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
