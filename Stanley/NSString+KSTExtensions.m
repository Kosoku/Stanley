//
//  NSString+KSTExtensions.m
//  Stanley
//
//  Created by William Towe on 3/7/17.
//  Copyright © 2017 Kosoku Interactive, LLC. All rights reserved.
//
//  Redistribution and use in source and binary forms, with or without modification, are permitted provided that the following conditions are met:
//
//  1. Redistributions of source code must retain the above copyright notice, this list of conditions and the following disclaimer.
//
//  2. Redistributions in binary form must reproduce the above copyright notice, this list of conditions and the following disclaimer in the documentation and/or other materials provided with the distribution.
//
//  THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.

#import "NSString+KSTExtensions.h"
#import "NSData+KSTExtensions.h"

@implementation NSString (KSTExtensions)

- (NSString *)KST_reversedString {
    NSMutableString *retval = [NSMutableString stringWithCapacity:self.length];
    
    [self enumerateSubstringsInRange:NSMakeRange(0, self.length) options:NSStringEnumerationReverse|NSStringEnumerationByComposedCharacterSequences usingBlock:^(NSString * _Nullable substring, NSRange substringRange, NSRange enclosingRange, BOOL * _Nonnull stop) {
        [retval appendString:substring];
    }];
    
    return [retval copy];
}

- (NSString *)KST_stringByRemovingCharactersInSet:(NSCharacterSet *)set {
    set = set.invertedSet;
    
    NSMutableString *retval = [[NSMutableString alloc] init];
    NSRange range = [self rangeOfCharacterFromSet:set options:0 range:NSMakeRange(0, self.length)];
    
    while (range.length > 0) {
        [retval appendString:[self substringWithRange:range]];
        
        range = [self rangeOfCharacterFromSet:set options:0 range:NSMakeRange(NSMaxRange(range), self.length - NSMaxRange(range))];
    }
    
    return [retval copy];
}

- (NSString *)KST_stringByTrimmingLeadingCharactersInSet:(NSCharacterSet *)set; {
    NSRange range = [self rangeOfCharacterFromSet:set options:NSAnchoredSearch];
    
    if (range.length > 0) {
        return [self substringFromIndex:NSMaxRange(range)];
    }
    else {
        return self;
    }
}
- (NSString *)KST_stringByTrimmingTrailingCharactersInSet:(NSCharacterSet *)set; {
    NSRange range = [self rangeOfCharacterFromSet:set options:NSAnchoredSearch|NSBackwardsSearch];
    
    if (range.length > 0) {
        return [self substringToIndex:range.location];
    }
    else {
        return self;
    }
}

- (NSString *)KST_wordAtRange:(NSRange)range {
    return [self KST_wordAtRange:range outRange:NULL];
}
- (NSString *)KST_wordAtRange:(NSRange)range outRange:(NSRangePointer)outRange; {
    NSInteger location = range.location;
    
    if (location == NSNotFound) {
        return nil;
    }
    
    // Aborts in case minimum requieres are not fufilled
    if (self.length == 0 || location < 0 || (range.location+range.length) > self.length) {
        if (outRange != NULL) {
            *outRange = NSMakeRange(0, 0);
        }
        return nil;
    }
    
    NSString *leftPortion = [self substringToIndex:location];
    NSArray *leftComponents = [leftPortion componentsSeparatedByCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    NSString *leftWordPart = [leftComponents lastObject];
    
    NSString *rightPortion = [self substringFromIndex:location];
    NSArray *rightComponents = [rightPortion componentsSeparatedByCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    NSString *rightPart = [rightComponents firstObject];
    
    if (location > 0) {
        NSString *characterBeforeCursor = [self substringWithRange:NSMakeRange(location-1, 1)];
        NSRange whitespaceRange = [characterBeforeCursor rangeOfCharacterFromSet:[NSCharacterSet whitespaceCharacterSet]];
        
        if (whitespaceRange.length == 1) {
            // At the start of a word, just use the word behind the cursor for the current word
            if (outRange != NULL) {
                *outRange = NSMakeRange(location, rightPart.length);
            }
            
            return rightPart;
        }
    }
    
    // In the middle of a word, so combine the part of the word before the cursor, and after the cursor to get the current word
    if (outRange != NULL) {
        *outRange = NSMakeRange(location-leftWordPart.length, leftWordPart.length+rightPart.length);
    }
    
    NSString *word = [leftWordPart stringByAppendingString:rightPart];
    NSString *linebreak = @"\n";
    
    // If a break is detected, return the last component of the string
    if ([word rangeOfString:linebreak].location != NSNotFound) {
        if (outRange != NULL) {
            *outRange = [self rangeOfString:word];
        }
        word = [[word componentsSeparatedByString:linebreak] lastObject];
    }
    
    return word;
}

- (NSString *)KST_MD5String; {
    return [[self dataUsingEncoding:NSUTF8StringEncoding] KST_MD5String];
}
- (NSString *)KST_SHA1String; {
    return [[self dataUsingEncoding:NSUTF8StringEncoding] KST_SHA1String];
}
- (NSString *)KST_SHA256String; {
    return [[self dataUsingEncoding:NSUTF8StringEncoding] KST_SHA256String];
}
- (NSString *)KST_SHA512String; {
    return [[self dataUsingEncoding:NSUTF8StringEncoding] KST_SHA512String];
}

@end
