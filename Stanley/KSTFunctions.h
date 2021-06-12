//
//  KSTFunctions.h
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

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

/**
 Returns YES if the object is empty, otherwise NO.
 
 This first tests the object against nil, then against NSNull.null, then checks if the object responds to count or length invokes the method and checks its return value.
 
 @param object The object to test for emptiness
 @return YES if the object is empty, otherwise NO
 */
FOUNDATION_EXTERN BOOL KSTIsEmptyObject(id _Nullable object);

/**
 Returns NSNull.null if the object is empty, using KSTIsEmptyObject to test, otherwise returns object.
 
 @param object The object to test
 @return NSNull.null or the object
 */
FOUNDATION_EXTERN id KSTNullIfEmptyOrObject(id _Nullable object);
/**
 Returns nil if the object is empty, using KSTIsEmptyObject to test, otherwise returns object.
 
 @param object The object to test
 @return nil or the object
 */
FOUNDATION_EXTERN id _Nullable KSTNilIfEmptyOrObject(id _Nullable object);

/**
 Executes *block* on the main thread asynchronously, using dispatch_async, passing dispatch_get_main_queue() and *block* respectively.
 
 @param block The block to execute on the main thread
 @exception NSException Thrown if block is NULL
 */
FOUNDATION_EXTERN void KSTDispatchMainAsync(dispatch_block_t block);
/**
 Executes *block* on the main thread synchronously, first checking to see if already on the main thread and if so, executing the *block* immediately. Otherwise using dispatch_sync, passing dispatch_get_main_queue() and *block* respectively.
 
 @param block The block to execute on the main thread
 @exception NSException Thrown if block is NULL
 */
FOUNDATION_EXTERN void KSTDispatchMainSync(dispatch_block_t block);

/**
 Executes *block* on the main thread after the provided *delay*.
 
 @param delay The delay after which to execute *block*
 @param block The block to execute
 @exception NSException Thrown if block is NULL
 */
FOUNDATION_EXTERN void KSTDispatchMainAfter(NSTimeInterval delay, dispatch_block_t block);
/**
 Executes *block* on the provided *queue* after the provided *delay*.
 
 @param delay The delay after which to execute *block*
 @param queue The queue to execute *block* on
 @param block The block to execute
 @exception NSException Thrown if block is NULL
 */
FOUNDATION_EXTERN void KSTDispatchAfter(NSTimeInterval delay, dispatch_queue_t _Nullable queue, dispatch_block_t block);

NS_ASSUME_NONNULL_END
