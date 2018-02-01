//
//  KSTTimer.m
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

#import "KSTTimer.h"
#import "KSTScopeMacros.h"

static NSMutableSet<KSTTimer *> *kNonRepeatingTimers;

@interface KSTTimer ()
@property (assign,nonatomic) NSTimeInterval timeInterval;
@property (weak,nonatomic) id target;
@property (assign,nonatomic) SEL selector;
@property (copy,nonatomic) KSTTimerBlock block;
@property (readwrite,strong,nonatomic,nullable) id userInfo;
@property (assign,nonatomic) BOOL repeats;
@property (strong,nonatomic) dispatch_queue_t queue;

@property (strong,nonatomic) dispatch_queue_t timerQueue;
@property (strong,nonatomic) dispatch_source_t timer;
@property (assign) BOOL hasBeenScheduled;
@property (assign) BOOL hasBeenInvalidated;

- (void)_createTimerQueue;
- (void)_resetTimerProperties;
@end

@implementation KSTTimer
#pragma mark *** Subclass Overrides ***
+ (void)initialize {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        kNonRepeatingTimers = [[NSMutableSet alloc] init];
    });
}

- (void)dealloc {
    [self invalidate];
}
#pragma mark *** Public Methods ***
+ (instancetype)scheduledTimerWithTimeInterval:(NSTimeInterval)timeInterval target:(id)target selector:(SEL)selector userInfo:(id)userInfo repeats:(BOOL)repeats {
    return [self scheduledTimerWithTimeInterval:timeInterval target:target selector:selector userInfo:userInfo repeats:repeats queue:nil];
}
+ (instancetype)scheduledTimerWithTimeInterval:(NSTimeInterval)timeInterval target:(id)target selector:(SEL)selector userInfo:(id)userInfo repeats:(BOOL)repeats queue:(dispatch_queue_t)queue {
    KSTTimer *retval = [[KSTTimer alloc] initWithTimeInterval:timeInterval target:target selector:selector userInfo:userInfo repeats:repeats queue:queue];
    
    [retval schedule];
    
    return retval;
}
+ (instancetype)scheduledTimerWithTimeInterval:(NSTimeInterval)timeInterval block:(KSTTimerBlock)block userInfo:(id)userInfo repeats:(BOOL)repeats queue:(dispatch_queue_t)queue {
    KSTTimer *retval = [[KSTTimer alloc] initWithTimeInterval:timeInterval block:block userInfo:userInfo repeats:repeats queue:queue];
    
    [retval schedule];
    
    return retval;
}
#pragma mark -
- (instancetype)initWithTimeInterval:(NSTimeInterval)timeInterval target:(id)target selector:(SEL)selector userInfo:(id)userInfo repeats:(BOOL)repeats {
    return [self initWithTimeInterval:timeInterval target:target selector:selector userInfo:userInfo repeats:repeats queue:nil];
}
- (instancetype)initWithTimeInterval:(NSTimeInterval)timeInterval target:(id)target selector:(SEL)selector userInfo:(id)userInfo repeats:(BOOL)repeats queue:(dispatch_queue_t)queue {
    if (!(self = [super init]))
        return nil;
    
    _timeInterval = timeInterval;
    _target = target;
    _selector = selector;
    _userInfo = userInfo;
    _repeats = repeats;
    _queue = queue ?: dispatch_get_main_queue();
    
    [self _createTimerQueue];
    
    return self;
}
- (instancetype)initWithTimeInterval:(NSTimeInterval)timeInterval block:(KSTTimerBlock)block userInfo:(id)userInfo repeats:(BOOL)repeats queue:(dispatch_queue_t)queue {
    if (!(self = [super init]))
        return nil;
    
    _timeInterval = timeInterval;
    _block = [block copy];
    _userInfo = userInfo;
    _repeats = repeats;
    _queue = queue ?: dispatch_get_main_queue();
    
    [self _createTimerQueue];
    
    return self;
}
#pragma mark -
- (void)schedule {
    if (self.hasBeenScheduled) {
        return;
    }
    
    self.hasBeenScheduled = YES;
    
    if (!self.repeats) {
        [kNonRepeatingTimers addObject:self];
    }
    
    [self _resetTimerProperties];
    
    kstWeakify(self);
    dispatch_source_set_event_handler(self.timer, ^{
        kstStrongify(self);
        [self fire];
    });
    
    dispatch_resume(self.timer);
}
- (void)fire {
    if (!self.isValid) {
        return;
    }
    
    if (self.block != nil) {
        self.block(self);
    }
    else if (self.target != nil &&
             self.selector != NULL) {
        
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
        [self.target performSelector:self.selector withObject:self];
#pragma clang diagnostic pop
    }
    
    if (!self.repeats) {
        [self invalidate];
    }
}
- (void)invalidate {
    if (self.hasBeenInvalidated) {
        return;
    }
    
    self.hasBeenInvalidated = YES;
    
    dispatch_source_t timer = self.timer;
    dispatch_async(self.timerQueue, ^{
        dispatch_source_cancel(timer);
    });
    
    if (!self.repeats) {
        [kNonRepeatingTimers removeObject:self];
    }
}
#pragma mark Properties
- (BOOL)isValid {
    return !self.hasBeenInvalidated;
}
@synthesize tolerance=_tolerance;
- (NSTimeInterval)tolerance {
    @synchronized(self) {
        return _tolerance;
    }
}
- (void)setTolerance:(NSTimeInterval)tolerance {
    @synchronized(self) {
        if (_tolerance != tolerance) {
            _tolerance = tolerance;
            
            [self _resetTimerProperties];
        }
    }
}
#pragma mark *** Private Methods ***
- (void)_createTimerQueue {
    _timerQueue = dispatch_queue_create([NSString stringWithFormat:@"timer.queue.%p",self].UTF8String, DISPATCH_QUEUE_SERIAL);
    
    dispatch_set_target_queue(_timerQueue, _queue);
    
    _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, _timerQueue);
}
- (void)_resetTimerProperties; {
    int64_t intervalNanos = (int64_t)(self.timeInterval * NSEC_PER_SEC);
    int64_t toleranceNanos = (int64_t)(self.tolerance * NSEC_PER_SEC);
    
    dispatch_source_set_timer(self.timer, dispatch_time(DISPATCH_TIME_NOW, intervalNanos), intervalNanos, toleranceNanos);
}

@end
