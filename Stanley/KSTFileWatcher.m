//
//  KSTFileWatcher.m
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

#import "KSTFileWatcher.h"
#import "KSTScopeMacros.h"

@interface KSTFileWatcher ()
@property (readwrite,copy,nonatomic) NSArray<NSURL *> *URLs;
@property (readwrite,assign,nonatomic) KSTFileWatcherFlags flags;
@property (copy,nonatomic) KSTFileWatcherBlock block;
@property (copy,nonatomic) NSArray *fileDescriptors;
@property (strong,nonatomic) dispatch_queue_t fileQueue;
@end

@interface KSTFileWatcherFileDescriptor : NSObject
@property (copy,nonatomic) NSURL *URL;
@property (strong,nonatomic) dispatch_source_t fileSource;
@property (weak,nonatomic) KSTFileWatcher *fileWatcher;

- (instancetype)initWithFileWatcher:(KSTFileWatcher *)fileWatcher URL:(NSURL *)URL;

- (BOOL)_createFileSource;
@end

@implementation KSTFileWatcherFileDescriptor

- (void)dealloc {
    dispatch_source_cancel(_fileSource);
}

- (instancetype)initWithFileWatcher:(KSTFileWatcher *)fileWatcher URL:(NSURL *)URL {
    if (!(self = [super init]))
        return nil;
    
    _fileWatcher = fileWatcher;
    _URL = [URL copy];
    
    if (![self _createFileSource]) {
        return nil;
    }
    
    return self;
}

- (BOOL)_createFileSource; {
    if (_fileSource != nil) {
        dispatch_source_cancel(_fileSource);
    }
    
    int fd = open(_URL.path.fileSystemRepresentation, O_EVTONLY);
    
    if (fd < 0) {
        return NO;
    }
    
    _fileSource = dispatch_source_create(DISPATCH_SOURCE_TYPE_VNODE, fd, _fileWatcher.flags, _fileWatcher.fileQueue);
    
    if (_fileSource == nil) {
        return NO;
    }
    
    kstWeakify(self);
    dispatch_source_set_event_handler(_fileSource, ^{
        kstStrongify(self);
        dispatch_source_vnode_flags_t flags = dispatch_source_get_data(self.fileSource);
        
        if (flags & DISPATCH_VNODE_REVOKE) {
            dispatch_source_cancel(self.fileSource);
        }
        if (flags & DISPATCH_VNODE_DELETE) {
            [self _createFileSource];
        }
        
        self.fileWatcher.block(self.fileWatcher, self.URL, flags);
    });
    dispatch_source_set_cancel_handler(_fileSource, ^{
        close(fd);
    });
    dispatch_activate(_fileSource);
    
    return YES;
}

@end

@implementation KSTFileWatcher

- (instancetype)initWithURLs:(NSArray<NSURL *> *)URLs block:(KSTFileWatcherBlock)block {
    return [self initWithURLs:URLs flags:KSTFileWatcherFlagsAll block:block];
}
- (instancetype)initWithURLs:(NSArray<NSURL *> *)URLs flags:(KSTFileWatcherFlags)flags block:(KSTFileWatcherBlock)block {
    if (!(self = [super init]))
        return nil;
    
    NSParameterAssert(URLs != nil);
    NSParameterAssert(block != nil);
    
    _URLs = [URLs copy];
    _block = [block copy];
    _flags = flags;
    _fileQueue = dispatch_queue_create([NSString stringWithFormat:@"%@.%p.queue",NSStringFromClass(self.class),self].UTF8String, DISPATCH_QUEUE_SERIAL);
    
    NSMutableArray *fileDescriptors = [[NSMutableArray alloc] init];
    
    for (NSURL *URL in _URLs) {
        KSTFileWatcherFileDescriptor *fd = [[KSTFileWatcherFileDescriptor alloc] initWithFileWatcher:self URL:URL];
        
        if (fd != nil) {
            [fileDescriptors addObject:fd];
        }
    }
    
    _fileDescriptors = [fileDescriptors copy];
    
    return self;
}

@end
