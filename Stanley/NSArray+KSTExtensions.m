//
//  NSArray+KSTExtensions.m
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

#import "NSArray+KSTExtensions.h"
#import "NSMutableArray+KSTExtensions.h"

@implementation NSArray (KSTExtensions)

- (NSArray *)KST_reversedArray; {
    return [self reverseObjectEnumerator].allObjects;
}

- (NSArray *)KST_arrayByAppendingObject:(id)object {
    return [self arrayByAddingObject:object];
}
- (NSArray *)KST_arrayByAppendingArray:(NSArray *)array; {
    return [self arrayByAddingObjectsFromArray:array];
}
- (NSArray *)KST_arrayByPrependingObject:(id)object {
    return [self KST_arrayByPrependingArray:@[object]];
}
- (NSArray *)KST_arrayByPrependingArray:(NSArray *)array {
    NSMutableArray *retval = [self mutableCopy];
    
    [retval insertObjects:array atIndexes:[NSIndexSet indexSetWithIndexesInRange:NSMakeRange(0, array.count)]];
    
    return [retval copy];
}

- (NSArray *)KST_arrayByRemovingArray:(NSArray *)array {
    NSMutableArray *retval = [self mutableCopy];
    
    [retval removeObjectsInArray:array];
    
    return [retval copy];
}

- (NSSet *)KST_set; {
    return [NSSet setWithArray:self];
}
- (NSMutableSet *)KST_mutableSet; {
    return [NSMutableSet setWithArray:self];
}

- (NSOrderedSet *)KST_orderedSet {
    return [NSOrderedSet orderedSetWithArray:self];
}
- (NSMutableOrderedSet *)KST_mutableOrderedSet {
    return [NSMutableOrderedSet orderedSetWithArray:self];
}

- (NSArray *)KST_shuffledArray; {
    NSMutableArray *retval = [self mutableCopy];
    
    [retval KST_shuffle];
    
    return [retval copy];
}

- (id)KST_objectAtRandomIndex {
    if (self.count == 0) {
        return nil;
    }
    
    return self[arc4random_uniform((u_int32_t)self.count)];
}

- (id)KST_safeObjectAtIndex:(NSUInteger)index {
    if (index < self.count) {
        return self[index];
    }
    return nil;
}

@end
