//
//  NSString+KSTExtensions.h
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

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSString (KSTExtensions)

/**
 Create and return a string by removing all characters in the provided *set* from the receiver. This is distinct from stringByTrimmingCharactersInSet: which only removes characters at the beginning and end of the receiver.
 
 For example, [@"+1 (123) 456-7890" KST_stringByRemovingCharactersInSet:NSCharacterSet.decimalDigitCharacterSet.invertedSet] -> @"11234567890".
 
 @param set The set of characters to remove
 @return The string with characters removed
 */
- (NSString *)KST_stringByRemovingCharactersInSet:(NSCharacterSet *)set;

/**
 Create and return a string by removing characters in the provided *set* from the beginning of the receiver. This is similar to stringByTrimmingCharactersInSet:, but only removes characters from the beginning of the receiver.
 
 @param set The set of characters to remove
 @return The trimmed string
 */
- (NSString *)KST_stringByTrimmingLeadingCharactersInSet:(NSCharacterSet *)set;
/**
 Create and return a string by removing characters in the provided *set* from the end of the receiver. This is similar to stringByTrimmingCharactersInSet:, but only removes characters from the end of the receiver.
 
 @param set The set of characters to remove
 @return The trimmed string
 */
- (NSString *)KST_stringByTrimmingTrailingCharactersInSet:(NSCharacterSet *)set;

/**
 Creates and returns an NSString representing the MD5 hash of the receiver.
 
 @return The NSString hash
 */
- (nullable NSString *)KST_MD5String;
/**
 Creates and returns an NSString representing the SHA1 hash of the receiver.
 
 @return The NSString hash
 */
- (nullable NSString *)KST_SHA1String;
/**
 Creates and returns an NSString representing the SHA256 hash of the receiver.
 
 @return The NSString hash
 */
- (nullable NSString *)KST_SHA256String;
/**
 Creates and returns an NSString representing the SHA512 hash of the receiver.
 
 @return The NSString hash
 */
- (nullable NSString *)KST_SHA512String;

@end

NS_ASSUME_NONNULL_END
