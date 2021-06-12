//
//  NSArray+KSTExtensions.h
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

@interface NSArray<__covariant ObjectType> (KSTExtensions)

/**
 Creates and returns an NSArray with the receiver's objects in reverse order.
 
 @return The reversed array
 */
- (NSArray<ObjectType> *)KST_reversedArray;

/**
 Create and return an array by appending *object* onto the receiver.
 
 @param object The object to append
 @return The new array
 */
- (NSArray<ObjectType> *)KST_arrayByAppendingObject:(ObjectType)object;
/**
 Creates and returns an array by appending the objects from array onto the receiver.
 
 @param array The objects to append
 @return The new array
 */
- (NSArray<ObjectType> *)KST_arrayByAppendingArray:(NSArray<ObjectType> *)array;
/**
 Create and return an array by prepending *object* onto the receiver.
 
 @param object The object to prepend
 @return The new array
 */
- (NSArray<ObjectType> *)KST_arrayByPrependingObject:(ObjectType)object;
/**
 Creates and returns an array by prepending the objects from array onto the receiver.
 
 @param array The objects to prepend
 @return The new array
 */
- (NSArray<ObjectType> *)KST_arrayByPrependingArray:(NSArray<ObjectType> *)array;

/**
 Create and return an array by removing the objects in the provided *array*.
 
 @param array The objects to remove
 @return The new array
 */
- (NSArray<ObjectType> *)KST_arrayByRemovingArray:(NSArray<ObjectType> *)array;

/**
 Creates and returns an NSArray with the receiver's objects.
 
 @return The NSSet created from the receiver
 */
- (NSSet<ObjectType> *)KST_set;
/**
 Creates and returns an NSMutableSet with the receiver's objects.
 
 @return The NSMutableSet created from the receiver
 */
- (NSMutableSet<ObjectType> *)KST_mutableSet;

/**
 Returns an NSOrderedSet with the receiver's objects.
 
 @return The NSOrderedSet
 */
- (NSOrderedSet<ObjectType> *)KST_orderedSet;
/**
 Returns an NSMutableOrderedSet with the receiver's objects.
 
 @return The NSMutableOrderedSet
 */
- (NSMutableOrderedSet<ObjectType> *)KST_mutableOrderedSet;

/**
 Creates and returns a shuffled copy of the receiver.
 
 @return The shuffled NSArray
 */
- (NSArray<ObjectType> *)KST_shuffledArray;

/**
 Returns the object at a random index in the receiver.
 
 @return The random object
 */
- (nullable ObjectType)KST_objectAtRandomIndex;

/**
 Returns the object at the provided *index* if *index* is within the receiver's bounds, otherwise returns nil.
 
 @param index The array index
 @return The object or nil
 */
- (nullable ObjectType)KST_safeObjectAtIndex:(NSUInteger)index;

@end

NS_ASSUME_NONNULL_END
