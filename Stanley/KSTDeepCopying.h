//
//  KSTDeepCopying.h
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
 A protocol indicating the object supports deep copying semantics.
 
 For example, if the object manages instances of collection classes, its deep copy would contain deep copies of those collections, and so on.
 */
@protocol KSTDeepCopying <NSObject>
@required
/**
 Creates and returns a deep copy of the receiver.
 
 @return The deep copy
 */
- (id)deepCopy;
@end

/**
 Adds support for KSTDeepCopying to NSArray.
 */
@interface NSArray<ObjectType> (KSTDeepCopyingExtensions) <KSTDeepCopying>
- (NSArray<ObjectType> *)deepCopy;
@end

/**
 Adds support for KSTDeepCopying to NSSet.
 */
@interface NSSet<ObjectType> (KSTDeepCopyingExtensions) <KSTDeepCopying>
- (NSSet<ObjectType> *)deepCopy;
@end

/**
 Adds support for KSTDeepCopying to NSDictionary.
 */
@interface NSDictionary<KeyType, ObjectType> (KSTDeepCopyingExtensions) <KSTDeepCopying>
- (NSDictionary<KeyType, ObjectType> *)deepCopy;
@end

NS_ASSUME_NONNULL_END
