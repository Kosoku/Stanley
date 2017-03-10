//
//  NSURL+KSTExtensions.h
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

@interface NSURL (KSTExtensions)

/**
 Returns the value associated with the NSURLCreationDateKey key.
 
 @return The associated creation date
 */
@property (readonly,nonatomic,nullable) NSDate *KST_creationDate;
/**
 Returns the value associated with the NSURLContentModificationDateKey key.
 
 @return The associated content modification date
 */
@property (readonly,nonatomic,nullable) NSDate *KST_contentModificationDate;
/**
 Returns the value associated with the NSURLIsDirectoryKey key.
 
 @return The associated isDirectory value
 */
@property (readonly,nonatomic) BOOL KST_isDirectory;
/**
 Returns the value associated with the NSURLTypeIdentifierKey key.
 
 @return The associated type identifier
 */
@property (readonly,nonatomic,nullable) NSString *KST_typeIdentifier;

/**
 Creates and returns a dictionary with query keys mapping to query values.
 
 @return The query dictionary
 */
- (nullable NSDictionary *)KST_queryDictionary;

/**
 Create and return an NSURL with *baseString* and optional query *parameters*.
 
 @param baseString The base string of the NSURL
 @param parameters Optional parameters dictionary
 @return The NSURL created from *baseString* and *parameters*
 */
+ (nullable NSURL *)KST_URLWithBaseString:(NSString *)baseString parameters:(nullable NSDictionary *)parameters;

@end

NS_ASSUME_NONNULL_END
