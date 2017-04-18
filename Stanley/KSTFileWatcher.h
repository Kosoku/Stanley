//
//  KSTFileWatcher.h
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

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_OPTIONS(unsigned long, KSTFileWatcherFlags) {
    KSTFileWatcherFlagsDelete = DISPATCH_VNODE_DELETE,
    KSTFileWatcherFlagsWrite = DISPATCH_VNODE_WRITE,
    KSTFileWatcherFlagsExtend = DISPATCH_VNODE_EXTEND,
    KSTFileWatcherFlagsAttrib = DISPATCH_VNODE_ATTRIB,
    KSTFileWatcherFlagsLink = DISPATCH_VNODE_LINK,
    KSTFileWatcherFlagsRename = DISPATCH_VNODE_RENAME,
    KSTFileWatcherFlagsRevoke = DISPATCH_VNODE_REVOKE,
    KSTFileWatcherFlagsUnlock = DISPATCH_VNODE_FUNLOCK,
    KSTFileWatcherFlagsAll = KSTFileWatcherFlagsDelete|KSTFileWatcherFlagsWrite|KSTFileWatcherFlagsExtend|KSTFileWatcherFlagsAttrib|KSTFileWatcherFlagsLink|KSTFileWatcherFlagsRename|KSTFileWatcherFlagsRevoke|KSTFileWatcherFlagsUnlock
};

@class KSTFileWatcher;

typedef void(^KSTFileWatcherBlock)(KSTFileWatcher *fileWatcher, NSURL *URL, KSTFileWatcherFlags flags);

@interface KSTFileWatcher : NSObject

@property (readonly,copy,nonatomic) NSArray<NSURL *> *URLs;
@property (readonly,assign,nonatomic) KSTFileWatcherFlags flags;

- (instancetype)initWithURLs:(NSArray<NSURL *> *)URLs block:(KSTFileWatcherBlock)block;
- (instancetype)initWithURLs:(NSArray<NSURL *> *)URLs flags:(KSTFileWatcherFlags)flags block:(KSTFileWatcherBlock)block NS_DESIGNATED_INITIALIZER;
- (instancetype)init NS_UNAVAILABLE;

@end

NS_ASSUME_NONNULL_END
