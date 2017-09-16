//
//  NSMutableArray+KSTExtensions.m
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
