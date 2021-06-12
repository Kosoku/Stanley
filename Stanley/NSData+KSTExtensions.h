//
//  NSData+KSTExtensions.h
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

@interface NSData (KSTExtensions)

/**
 Creates and returns an NSString representing the SHA1 hash of the receiver's bytes.
 
 @return The NSString hash
 */
- (nullable NSString *)KST_SHA1String;
/**
 Creates and returns an NSString representing the SHA256 hash of the receiver's bytes.
 
 @return The NSString hash
 */
- (nullable NSString *)KST_SHA256String;
/**
 Creates and returns an NSString representing the SHA512 hash of the receiver's bytes.
 
 @return The NSString hash
 */
- (nullable NSString *)KST_SHA512String;

@end

NS_ASSUME_NONNULL_END
