//
//  KSTDeepMutableCopying.m
//  Stanley
//
//  Created by William Towe on 9/30/17.
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

#import "KSTDeepMutableCopying.h"

@implementation NSArray (KSTDeepMutableCopyingExtensions)
- (NSMutableArray *)deepMutableCopy {
    NSMutableArray *retval = [[NSMutableArray alloc] init];
    
    for (id object in self) {
        if ([object conformsToProtocol:@protocol(KSTDeepMutableCopying)]) {
            [retval addObject:[object deepMutableCopy]];
        }
        else if ([object conformsToProtocol:@protocol(NSMutableCopying)]) {
            [retval addObject:[object mutableCopyWithZone:nil]];
        }
        else {
            [retval addObject:object];
        }
    }
    
    return retval;
}
@end

@implementation NSSet (KSTDeepMutableCopyingExtensions)
- (NSMutableSet *)deepMutableCopy {
    NSMutableSet *retval = [[NSMutableSet alloc] init];
    
    for (id object in self) {
        if ([object conformsToProtocol:@protocol(KSTDeepMutableCopying)]) {
            [retval addObject:[object deepMutableCopy]];
        }
        else if ([object conformsToProtocol:@protocol(NSMutableCopying)]) {
            [retval addObject:[object mutableCopyWithZone:nil]];
        }
        else {
            [retval addObject:object];
        }
    }
    
    return retval;
}
@end

@implementation NSDictionary (KSTDeepMutableCopyingExtensions)
- (NSMutableDictionary *)deepMutableCopy {
    NSMutableDictionary *retval = [[NSMutableDictionary alloc] init];
    
    [self enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
        if ([obj conformsToProtocol:@protocol(KSTDeepMutableCopying)]) {
            [retval setObject:[obj deepMutableCopy] forKey:key];
        }
        else if ([obj conformsToProtocol:@protocol(NSMutableCopying)]) {
            [retval setObject:[obj mutableCopyWithZone:nil] forKey:key];
        }
        else {
            [retval setObject:obj forKey:key];
        }
    }];
    
    return retval;
}
@end
