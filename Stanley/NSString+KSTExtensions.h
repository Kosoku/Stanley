//
//  NSString+KSTExtensions.h
//  Stanley
//
//  Created by William Towe on 3/7/17.
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

@interface NSString (KSTExtensions)

/**
 Creates and returns a reversed string from the receiver.
 
 @return The reversed string
 */
- (NSString *)KST_reversedString;

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
 Returns the word within the receiver at the provided *range* or nil. Words are delimited by NSCharacterSet.whitespaceAndNewlineCharacterSet.
 
 @param range The range at which to search for a word
 @return The word or nil
 */
- (nullable NSString *)KST_wordAtRange:(NSRange)range;
/**
 Returns the word within the receiver at the provided *range* or nil. Words are delimited by NSCharacterSet.whitespaceAndNewlineCharacterSet. The range of the word within the receiver is returned by reference if *outRange* is non-Null.
 
 @param range The range at which to search for a word
 @param outRange The range of the word within the receiver
 @return The word or nil
 */
- (nullable NSString *)KST_wordAtRange:(NSRange)range outRange:(nullable NSRangePointer)outRange;

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
