//
//  NSArray+KSTExtensions.h
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

@interface NSArray<__covariant ObjectType> (KSTExtensions)

/**
 Creates and returns an NSArray with the receiver's objects in reverse order.
 
 @return The reversed array
 */
- (NSArray<ObjectType> *)KST_reversedArray;

/**
 Creates and returns an array by appending the objects from array onto the receiver.
 
 @return The appended array
 */
- (NSArray *)KST_append:(NSArray<ObjectType> *)array;
/**
 Creates and returns an array by prepending the objects from array onto the receiver.
 
 @return The prepended array
 */
- (NSArray *)KST_prepend:(NSArray<ObjectType> *)array;

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
- (ObjectType)KST_objectAtRandomIndex;

@end

NS_ASSUME_NONNULL_END
