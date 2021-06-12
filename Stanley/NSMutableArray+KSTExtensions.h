//
//  NSMutableArray+KSTExtensions.h
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

@interface NSMutableArray<ObjectType> (KSTExtensions)

/**
 If self.count > 0, removes the first object in the receiver; otherwise does nothing.
 */
- (void)KST_removeFirstObject;

/**
 Reverses the objects of the receiver. This is distinct from KST_reversedArray, which returns a new array.
 */
- (void)KST_reverse;

/**
 Adds *object* to the end of the receiver. Simply calls addObject:.
 
 @param object The object to add
 */
- (void)KST_appendObject:(ObjectType)object;
/**
 Adds the objects in *array* to the end of the receiver. Simply calls addObjectsFromArray:.
 
 @param array The objects to add
 */
- (void)KST_appendArray:(NSArray<ObjectType> *)array;
/**
 Adds the *object* to the beginning of the receiver (i.e. index 0).
 
 @param object The object to add
 */
- (void)KST_prependObject:(ObjectType)object;
/**
 Adds the objects in *array* to the beginning of the receiver (i.e. starting at index 0).
 
 @param array The objects to add
 */
- (void)KST_prependArray:(NSArray<ObjectType> *)array;

/**
 Inserts _object_ at index 0 of the receiver.
 
 @param object The object to insert
 */
- (void)KST_push:(ObjectType)object;
/**
 Removes the first object of the receiver and returns it.
 
 @return The first object of the receiver or nil
 */
- (nullable ObjectType)KST_pop;

/**
 Shuffles the receiver. See http://stackoverflow.com/questions/56648/whats-the-best-way-to-shuffle-an-nsmutablearray for implementation reference.
 */
- (void)KST_shuffle;

@end

NS_ASSUME_NONNULL_END
