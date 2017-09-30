//
//  KSTDeepCopying.m
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

#import "KSTDeepCopying.h"

@implementation NSArray (KSTDeepCopyingExtensions)
- (NSArray *)deepCopy {
    NSMutableArray *retval = [[NSMutableArray alloc] init];
    
    for (id object in self) {
        if ([object conformsToProtocol:@protocol(KSTDeepCopying)]) {
            [retval addObject:[object deepCopy]];
        }
        else if ([object conformsToProtocol:@protocol(NSCopying)]) {
            [retval addObject:[object copyWithZone:nil]];
        }
        else {
            [retval addObject:object];
        }
    }
    
    return [retval copy];
}
@end

@implementation NSSet (KSTDeepCopyingExtensions)
- (NSSet *)deepCopy {
    NSMutableSet *retval = [[NSMutableSet alloc] init];
    
    for (id object in self) {
        if ([object conformsToProtocol:@protocol(KSTDeepCopying)]) {
            [retval addObject:[object deepCopy]];
        }
        else if ([object conformsToProtocol:@protocol(NSCopying)]) {
            [retval addObject:[object copyWithZone:nil]];
        }
        else {
            [retval addObject:object];
        }
    }
    
    return [retval copy];
}
@end

@implementation NSDictionary (KSTDeepCopyingExtensions)
- (NSDictionary *)deepCopy {
    NSMutableDictionary *retval = [[NSMutableDictionary alloc] init];
    
    [self enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
        if ([obj conformsToProtocol:@protocol(KSTDeepCopying)]) {
            [retval setObject:[obj deepCopy] forKey:key];
        }
        else if ([obj conformsToProtocol:@protocol(NSCopying)]) {
            [retval setObject:[obj copyWithZone:nil] forKey:key];
        }
        else {
            [retval setObject:obj forKey:key];
        }
    }];
    
    return [retval copy];
}
@end
