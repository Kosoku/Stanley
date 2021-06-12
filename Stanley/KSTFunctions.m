//
//  KSTFunctions.m
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

#import "KSTFunctions.h"

BOOL KSTIsEmptyObject(id object) {
    return (object == nil ||
            [object isEqual:NSNull.null] ||
            ([object respondsToSelector:@selector(count)] && [(NSArray *)object count] == 0) ||
            ([object respondsToSelector:@selector(length)] && [(NSString *)object length] == 0));
}

id KSTNullIfEmptyOrObject(id object) {
    return KSTIsEmptyObject(object) ? NSNull.null : object;
}
id KSTNilIfEmptyOrObject(id object) {
    return KSTIsEmptyObject(object) ? nil : object;
}

void KSTDispatchMainAsync(dispatch_block_t block) {
    NSCParameterAssert(block);
    
    if ([NSThread isMainThread]) {
        block();
    }
    else {
        dispatch_async(dispatch_get_main_queue(), block);
    }
}

void KSTDispatchMainSync(dispatch_block_t block) {
    NSCParameterAssert(block);
    
    if ([NSThread isMainThread]) {
        block();
    }
    else {
        dispatch_sync(dispatch_get_main_queue(), block);
    }
}

void KSTDispatchMainAfter(NSTimeInterval delay, dispatch_block_t block) {
    NSCParameterAssert(block);
    
    KSTDispatchAfter(delay, dispatch_get_main_queue(), block);
}
void KSTDispatchAfter(NSTimeInterval delay, dispatch_queue_t queue, dispatch_block_t block) {
    NSCParameterAssert(block);
    
    if (queue == NULL) {
        queue = dispatch_get_main_queue();
    }
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delay * NSEC_PER_SEC)), queue, block);
}
