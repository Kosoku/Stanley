//
//  KSTDeepMutableCopying.h
//  Stanley
//
//  Created by William Towe on 9/30/17.
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

/**
 A protocol indicating the object supports deep mutable copying semantics.
 
 For example, if the object manages instances of collection classes, its deep mutable copy would contain deep mutable copies of those collections, and so on.
 */
@protocol KSTDeepMutableCopying <NSObject>
@required
/**
 Creates and returns a deep mutable copy of the receiver.
 
 @return The deep mutable copy
 */
- (id)deepMutableCopy;
@end

/**
 Adds support for KSTDeepMutableCopying to NSArray.
 */
@interface NSArray<ObjectType> (KSTDeepMutableCopyingExtensions) <KSTDeepMutableCopying>
- (NSMutableArray<ObjectType> *)deepMutableCopy;
@end

/**
 Adds support for KSTDeepMutableCopying to NSSet.
 */
@interface NSSet<ObjectType> (KSTDeepMutableCopyingExtensions) <KSTDeepMutableCopying>
- (NSMutableSet<ObjectType> *)deepMutableCopy;
@end

/**
 Adds support for KSTDeepMutableCopying to NSDictionary.
 */
@interface NSDictionary<KeyType, ObjectType> (KSTDeepMutableCopyingExtensions) <KSTDeepMutableCopying>
- (NSMutableDictionary<KeyType, ObjectType> *)deepMutableCopy;
@end

NS_ASSUME_NONNULL_END
