//
//  KSTTimer.m
//  Stanley
//
//  Created by William Towe on 2/1/18.
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
