//
//  KSTDirectoryWatcher.m
//  Stanley
//
//  Created by William Towe on 4/18/17.
//  Copyright © 2017 Kosoku Interactive, LLC. All rights reserved.
//
//  Redistribution and use in source and binary forms, with or without modification, are permitted provided that the following conditions are met:
//
//  1. Redistributions of source code must retain the above copyright notice, this list of conditions and the following disclaimer.
//
//  2. Redistributions in binary form must reproduce the above copyright notice, this list of conditions and the following disclaimer in the documentation and/or other materials provided with the distribution.
//
//  THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.

#import "KSTDirectoryWatcher.h"

@interface KSTDirectoryWatcher ()
@property (readwrite,copy,nonatomic) NSArray<NSURL *> *URLs;
@property (copy,nonatomic) KSTDirectoryWatcherBlock block;
@property (assign,nonatomic) FSEventStreamRef eventStreamRef;
@property (strong,nonatomic) dispatch_queue_t eventQueue;

- (void)_createEventStreamRef;
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
        
        watcher.block(eventID, flags, URL);
    }
}

@implementation KSTDirectoryWatcher

- (void)dealloc {
    [self _destroyEventStreamRef];
}

- (instancetype)initWithURLs:(NSArray<NSURL *> *)URLs block:(KSTDirectoryWatcherBlock)block; {
    if (!(self = [super init]))
        return nil;
    
    NSParameterAssert(URLs != nil);
    
    _URLs = [URLs copy];
    _block = [block copy];
    
    [self _createEventStreamRef];
    
    _eventQueue = dispatch_queue_create([NSString stringWithFormat:@"%@.%p.queue",NSStringFromClass(self.class),self].UTF8String, DISPATCH_QUEUE_SERIAL);
    
    return self;
}

- (void)startWatchingURLs; {
    [self _startEventStreamRef];
}
- (void)stopWatchingURLs; {
    [self _stopEventStreamRef];
}

- (void)_createEventStreamRef {
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
    
    _eventStreamRef = FSEventStreamCreate(kCFAllocatorDefault, &kKSTFSEventStreamCallback, &context, (__bridge CFArrayRef)paths, kFSEventStreamEventIdSinceNow, 0.2, kFSEventStreamCreateFlagUseCFTypes|kFSEventStreamCreateFlagWatchRoot);
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
