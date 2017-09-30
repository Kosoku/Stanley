//
//  KSTFunctions.h
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
