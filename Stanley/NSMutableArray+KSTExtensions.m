//
//  NSMutableArray+KSTExtensions.m
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

#import "NSMutableArray+KSTExtensions.h"

@implementation NSMutableArray (KSTExtensions)

- (void)KST_removeFirstObject; {
    if (self.count > 0) {
        [self removeObjectAtIndex:0];
    }
}

- (void)KST_reverse {
    if (self.count <= 1) {
        return;
    }
    
    for (NSUInteger i=0, j=self.count-1; i<j; i++, j--) {
        [self exchangeObjectAtIndex:i withObjectAtIndex:j];
    }
}

- (void)KST_appendObject:(id)object {
    [self addObject:object];
}
- (void)KST_appendArray:(NSArray *)array {
    [self addObjectsFromArray:array];
}
- (void)KST_prependObject:(id)object {
    [self insertObject:object atIndex:0];
}
- (void)KST_prependArray:(NSArray *)array {
    [self insertObjects:array atIndexes:[NSIndexSet indexSetWithIndexesInRange:NSMakeRange(0, array.count)]];
}

- (void)KST_push:(id)object; {
    [self insertObject:object atIndex:0];
}
- (id)KST_pop; {
    id retval = self.firstObject;
    
    [self KST_removeFirstObject];
    
    return retval;
}

- (void)KST_shuffle {
    for (NSUInteger i=0; i<self.count-1; i++) {
        NSUInteger n = arc4random_uniform((u_int32_t)(self.count - i)) + i;
        
        [self exchangeObjectAtIndex:i withObjectAtIndex:n];
    }
}

@end
