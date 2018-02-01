//
//  KSTTimer.h
//  Stanley
//
//  Created by William Towe on 2/1/18.
//  Copyright © 2018 Kosoku Interactive, LLC. All rights reserved.
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

@class KSTTimer;

typedef void(^KSTTimerBlock)(KSTTimer *timer);

@interface KSTTimer : NSObject

@property (readonly,getter=isValid) BOOL valid;
@property (readonly,strong,nonatomic,nullable) id userInfo;
@property (assign) NSTimeInterval tolerance;

+ (instancetype)scheduledTimerWithTimeInterval:(NSTimeInterval)timeInterval target:(id)target selector:(SEL)selector userInfo:(nullable id)userInfo repeats:(BOOL)repeats queue:(nullable dispatch_queue_t)queue;
+ (instancetype)scheduledTimerWithTimeInterval:(NSTimeInterval)timeInterval block:(KSTTimerBlock)block userInfo:(nullable id)userInfo repeats:(BOOL)repeats queue:(nullable dispatch_queue_t)queue;

- (instancetype)initWithTimeInterval:(NSTimeInterval)timeInterval target:(id)target selector:(SEL)selector userInfo:(nullable id)userInfo repeats:(BOOL)repeats queue:(nullable dispatch_queue_t)queue;
- (instancetype)initWithTimeInterval:(NSTimeInterval)timeInterval block:(KSTTimerBlock)block userInfo:(id)userInfo repeats:(BOOL)repeats queue:(nullable dispatch_queue_t)queue;

- (instancetype)init NS_UNAVAILABLE;
+ (instancetype)new NS_UNAVAILABLE;

/**
 Schedules the receiver to fire. Calling this on a timer that has already been scheduled does nothing.
 */
- (void)schedule;
/**
 Fires the timer synchronously on the calling queue. If called on a repeating timer, its regular schedule will not be interrupted. If called on a non-repeating timer, it will invalidate itself after firing.
 */
- (void)fire;
/**
 Cancels a scheduled timer and prevents it from firing again. This method can be called from any thread.
 */
- (void)invalidate;

@end

NS_ASSUME_NONNULL_END
