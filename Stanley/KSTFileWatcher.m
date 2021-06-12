//
//  KSTFileWatcher.m
//  Stanley
//
//  Created by William Towe on 4/18/17.
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
