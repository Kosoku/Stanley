//
//  KSTDeepCopying.h
//  Stanley
//
//  Created by William Towe on 9/30/17.
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
