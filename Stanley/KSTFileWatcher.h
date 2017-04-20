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

/**
 Options mask describing the cases where watcher events should be generated. See dispatch_source_vnode_flags_t for more information.
 */
typedef NS_OPTIONS(unsigned long, KSTFileWatcherFlags) {
    /**
     See DISPATCH_VNODE_DELETE for more information.
     */
    KSTFileWatcherFlagsDelete = DISPATCH_VNODE_DELETE,
    /**
     See DISPATCH_VNODE_WRITE for more information.
     */
    KSTFileWatcherFlagsWrite = DISPATCH_VNODE_WRITE,
    /**
     See DISPATCH_VNODE_EXTEND for more information.
     */
    KSTFileWatcherFlagsExtend = DISPATCH_VNODE_EXTEND,
    /**
     See DISPATCH_VNODE_ATTRIB for more information.
     */
    KSTFileWatcherFlagsAttrib = DISPATCH_VNODE_ATTRIB,
    /**
     See DISPATCH_VNODE_LINK for more information.
     */
    KSTFileWatcherFlagsLink = DISPATCH_VNODE_LINK,
    /**
     See DISPATCH_VNODE_RENAME for more information.
     */
    KSTFileWatcherFlagsRename = DISPATCH_VNODE_RENAME,
    /**
     See DISPATCH_VNODE_REVOKE for more information.
     */
    KSTFileWatcherFlagsRevoke = DISPATCH_VNODE_REVOKE,
    /**
     See DISPATCH_VNODE_FUNLOCK for more information.
     */
    KSTFileWatcherFlagsUnlock = DISPATCH_VNODE_FUNLOCK,
    /**
     Generate watcher events for all cases.
     */
    KSTFileWatcherFlagsAll = KSTFileWatcherFlagsDelete|KSTFileWatcherFlagsWrite|KSTFileWatcherFlagsExtend|KSTFileWatcherFlagsAttrib|KSTFileWatcherFlagsLink|KSTFileWatcherFlagsRename|KSTFileWatcherFlagsRevoke|KSTFileWatcherFlagsUnlock
};

@class KSTFileWatcher;

/**
 Block that is invoked whenever a watcher event is generated.
 
 @param fileWatcher The file watcher
 @param URL The URL of the item that generated the event
 @param flags The flags describing the type of event
 */
typedef void(^KSTFileWatcherBlock)(KSTFileWatcher *fileWatcher, NSURL *URL, KSTFileWatcherFlags flags);

/**
 KSTFileWatcher wraps the GCD APIs related to the kqueue file notification mechanism.
 */
@interface KSTFileWatcher : NSObject

/**
 Get the file URLs that are being watched.
 */
@property (readonly,copy,nonatomic) NSArray<NSURL *> *URLs;
/**
 Get the flags passed in during creation.
 */
@property (readonly,assign,nonatomic) KSTFileWatcherFlags flags;

/**
 Returns `[self initWithURLs:URLs flags:KSTFileWatcherFlagsAll block:block]`.
 
 @param URLs The file/directory URLs to watch
 @param block The block to invoke when an event occurs
 @return The initialized instance
 */
- (instancetype)initWithURLs:(NSArray<NSURL *> *)URLs block:(KSTFileWatcherBlock)block;
/**
 Creates and returns an instance of the receiver to watch the provided file/directory URLs and invoke the provided *block* whenever an event occurs. The provided *block* is always invoked on a private background queue.
 
 @param URLs The file/directory URLs to watch
 @param flags The flags determining when to generate events
 @param block The block to invoke when an event occurs
 @return The initialized instance
 */
- (instancetype)initWithURLs:(NSArray<NSURL *> *)URLs flags:(KSTFileWatcherFlags)flags block:(KSTFileWatcherBlock)block NS_DESIGNATED_INITIALIZER;

+ (instancetype)new NS_UNAVAILABLE;
- (instancetype)init NS_UNAVAILABLE;

@end

NS_ASSUME_NONNULL_END
