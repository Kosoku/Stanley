//
//  KSTDirectoryWatcher.m
//  Stanley
//
//  Created by William Towe on 4/18/17.
//  Copyright © 2019 Kosoku Interactive, LLC. All rights reserved.
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

#import "KSTDirectoryWatcher.h"

@interface KSTDirectoryWatcher ()
@property (readwrite,copy,nonatomic) NSArray<NSURL *> *URLs;
@property (readwrite,assign,nonatomic) KSTDirectoryWatcherCreateFlags flags;
@property (copy,nonatomic) KSTDirectoryWatcherBlock block;
@property (assign,nonatomic) FSEventStreamRef eventStreamRef;
@property (strong,nonatomic) dispatch_queue_t eventQueue;

- (void)_createEventStreamRefWithFlags:(KSTDirectoryWatcherCreateFlags)flags;
- (void)_destroyEventStreamRef;
- (void)_startEventStreamRef;
- (void)_stopEventStreamRef;
@end

static void kKSTFSEventStreamCallback(ConstFSEventStreamRef streamRef, void * __nullable clientCallBackInfo, size_t numEvents, void *eventPaths, const FSEventStreamEventFlags eventFlags[], const FSEventStreamEventId eventIds[]) {
    KSTDirectoryWatcher *watcher = (__bridge KSTDirectoryWatcher *)clientCallBackInfo;
    NSArray *paths = (__bridge NSArray *)eventPaths;
    
    for (size_t i=0; i<numEvents; i++) {
        FSEventStreamEventId eventID = eventIds[i];
        FSEventStreamEventFlags flags = eventFlags[i];
        NSURL *URL = [NSURL fileURLWithPath:paths[i]];
        
        watcher.block(watcher, eventID, flags, URL);
    }
}

@implementation KSTDirectoryWatcher

- (void)dealloc {
    [self _destroyEventStreamRef];
}

- (instancetype)initWithURLs:(NSArray<NSURL *> *)URLs block:(KSTDirectoryWatcherBlock)block; {
    return [self initWithURLs:URLs flags:KSTDirectoryWatcherCreateFlagsNone block:block];
}
- (instancetype)initWithURLs:(NSArray<NSURL *> *)URLs flags:(KSTDirectoryWatcherCreateFlags)flags block:(KSTDirectoryWatcherBlock)block; {
    if (!(self = [super init]))
        return nil;
    
    NSParameterAssert(URLs != nil);
    
    _URLs = [URLs copy];
    _block = [block copy];
    _flags = flags|kFSEventStreamCreateFlagUseCFTypes|kFSEventStreamCreateFlagWatchRoot;
    
    [self _createEventStreamRefWithFlags:_flags];
    
    _eventQueue = dispatch_queue_create([NSString stringWithFormat:@"%@.%p.queue",NSStringFromClass(self.class),self].UTF8String, DISPATCH_QUEUE_SERIAL);
    
    return self;
}

- (void)startWatchingURLs; {
    [self _startEventStreamRef];
}
- (void)stopWatchingURLs; {
    [self _stopEventStreamRef];
}

- (void)_createEventStreamRefWithFlags:(KSTDirectoryWatcherCreateFlags)flags {
    [self _destroyEventStreamRef];
    
    FSEventStreamContext context = {
        .version = 0,
        .info = (__bridge void *)self,
        .retain = NULL,
        .release = NULL,
        .copyDescription = NULL
    };
    
    NSMutableArray *paths = [[NSMutableArray alloc] init];
    
    for (NSURL *URL in _URLs) {
        [paths addObject:URL.path];
    }
    
    _eventStreamRef = FSEventStreamCreate(kCFAllocatorDefault, &kKSTFSEventStreamCallback, &context, (__bridge CFArrayRef)paths, kFSEventStreamEventIdSinceNow, 0.2, flags);
}
- (void)_destroyEventStreamRef {
    if (_eventStreamRef == NULL) {
        return;
    }
    
    [self _stopEventStreamRef];
    
    FSEventStreamRelease(_eventStreamRef);
    _eventStreamRef = NULL;
}
- (void)_startEventStreamRef; {
    if (_eventStreamRef == NULL) {
        return;
    }
    
    FSEventStreamSetDispatchQueue(_eventStreamRef, _eventQueue);
    FSEventStreamStart(_eventStreamRef);
}
- (void)_stopEventStreamRef; {
    if (_eventStreamRef == NULL) {
        return;
    }
    
    FSEventStreamStop(_eventStreamRef);
    FSEventStreamInvalidate(_eventStreamRef);
}

@end
