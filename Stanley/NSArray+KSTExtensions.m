//
//  NSArray+KSTExtensions.m
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
