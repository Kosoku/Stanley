//
//  NSMutableArray+KSTExtensions.h
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
