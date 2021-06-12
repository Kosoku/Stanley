//
//  NSURL+KSTExtensions.h
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
