//
//  KSTDirectoryWatcher.h
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
#import <CoreServices/CoreServices.h>

NS_ASSUME_NONNULL_BEGIN

/**
 Options mask describing the possible values passed when creating a KSTDirectoryWatcher instance. See FSEventStreamCreateFlags for more information.
 */
typedef NS_OPTIONS(UInt32, KSTDirectoryWatcherCreateFlags) {
    /**
     See kFSEventStreamCreateFlagNone for more information.
     */
    KSTDirectoryWatcherCreateFlagsNone = kFSEventStreamCreateFlagNone,
    /**
     See kFSEventStreamCreateFlagNoDefer for more information.
     */
    KSTDirectoryWatcherCreateFlagsNoDefer = kFSEventStreamCreateFlagNoDefer,
    /**
     See kFSEventStreamCreateFlagIgnoreSelf for more information.
     */
    KSTDirectoryWatcherCreateFlagsIgnoreSelf = kFSEventStreamCreateFlagIgnoreSelf,
    /**
     See kFSEventStreamCreateFlagFileEvents for more information.
     */
    KSTDirectoryWatcherCreateFlagsFlagFileEvents = kFSEventStreamCreateFlagFileEvents,
    /**
     See kFSEventStreamCreateFlagMarkSelf for more information.
     */
    KSTDirectoryWatcherCreateFlagsMarkSelf = kFSEventStreamCreateFlagMarkSelf
};

/**
 Options mask describing the possible values passed to the block that is invoked when watcher events happen. See FSEventStreamEventFlags for more information.
 */
typedef NS_OPTIONS(UInt32, KSTDirectoryWatcherEventFlags) {
    /**
     See kFSEventStreamEventFlagNone for more information.
     */
    KSTDirectoryWatcherEventFlagsNone = kFSEventStreamEventFlagNone,
    /**
     See kFSEventStreamEventFlagMustScanSubDirs for more information.
     */
    KSTDirectoryWatcherEventFlagsMustScanSubDirs = kFSEventStreamEventFlagMustScanSubDirs,
    /**
     See kFSEventStreamEventFlagUserDropped for more information.
     */
    KSTDirectoryWatcherEventFlagsUserDropped = kFSEventStreamEventFlagUserDropped,
    /**
     See kFSEventStreamEventFlagKernelDropped for more information.
     */
    KSTDirectoryWatcherEventFlagsKernelDropped = kFSEventStreamEventFlagKernelDropped,
    /**
     See kFSEventStreamEventFlagEventIdsWrapped for more information.
     */
    KSTDirectoryWatcherEventFlagsEventIDsWrapped = kFSEventStreamEventFlagEventIdsWrapped,
    /**
     See kFSEventStreamEventFlagHistoryDone for more information.
     */
    KSTDirectoryWatcherEventFlagsHistoryDone = kFSEventStreamEventFlagHistoryDone,
    /**
     See kFSEventStreamEventFlagRootChanged for more information.
     */
    KSTDirectoryWatcherEventFlagsRootChanged = kFSEventStreamEventFlagRootChanged,
    /**
     See kFSEventStreamEventFlagMount for more information.
     */
    KSTDirectoryWatcherEventFlagsMount = kFSEventStreamEventFlagMount,
    /**
     See kFSEventStreamEventFlagUnmount for more information.
     */
    KSTDirectoryWatcherEventFlagsUnmount = kFSEventStreamEventFlagUnmount,
    /**
     See kFSEventStreamEventFlagItemCreated for more information.
     */
    KSTDirectoryWatcherEventFlagsItemCreated = kFSEventStreamEventFlagItemCreated,
    /**
     See kFSEventStreamEventFlagItemRemoved for more information.
     */
    KSTDirectoryWatcherEventFlagsItemRemoved = kFSEventStreamEventFlagItemRemoved,
    /**
     See kFSEventStreamEventFlagItemInodeMetaMod for more information.
     */
    KSTDirectoryWatcherEventFlagsItemInodeMetaMod = kFSEventStreamEventFlagItemInodeMetaMod,
    /**
     See kFSEventStreamEventFlagItemRenamed for more information.
     */
    KSTDirectoryWatcherEventFlagsItemRenamed = kFSEventStreamEventFlagItemRenamed,
    /**
     See kFSEventStreamEventFlagItemModified for more information.
     */
    KSTDirectoryWatcherEventFlagsItemModified = kFSEventStreamEventFlagItemModified,
    /**
     See kFSEventStreamEventFlagItemFinderInfoMod for more information.
     */
    KSTDirectoryWatcherEventFlagsFinderInfoMod = kFSEventStreamEventFlagItemFinderInfoMod,
    /**
     See kFSEventStreamEventFlagItemChangeOwner for more information.
     */
    KSTDirectoryWatcherEventFlagsItemChangeOwner = kFSEventStreamEventFlagItemChangeOwner,
    /**
     See kFSEventStreamEventFlagItemXattrMod for more information.
     */
    KSTDirectoryWatcherEventFlagsItemXattrMod = kFSEventStreamEventFlagItemXattrMod,
    /**
     See kFSEventStreamEventFlagItemIsFile for more information.
     */
    KSTDirectoryWatcherEventFlagsItemIsFile = kFSEventStreamEventFlagItemIsFile,
    /**
     See kFSEventStreamEventFlagItemIsDir for more information.
     */
    KSTDirectoryWatcherEventFlagsItemIsDir = kFSEventStreamEventFlagItemIsDir,
    /**
     See kFSEventStreamEventFlagItemIsSymlink for more information.
     */
    KSTDirectoryWatcherEventFlagsItemIsSymlink = kFSEventStreamEventFlagItemIsSymlink,
    /**
     See kFSEventStreamEventFlagOwnEvent for more information.
     */
    KSTDirectoryWatcherEventFlagsOwnEvent = kFSEventStreamEventFlagOwnEvent,
    /**
     See kFSEventStreamEventFlagItemIsHardlink for more information.
     */
    KSTDirectoryWatcherEventFlagsItemIsHardLink = kFSEventStreamEventFlagItemIsHardlink,
    /**
     See kFSEventStreamEventFlagItemIsLastHardlink for more information.
     */
    KSTDirectoryWatcherEventFlagsItemIsLastHardLink = kFSEventStreamEventFlagItemIsLastHardlink
};

/**
 Typedef for the event ID that is passed in the block when watcher events happen.
 */
typedef FSEventStreamEventId KSTDirectoryWatcherEventID;

@class KSTDirectoryWatcher;

/**
 Block that is invoked when a watcher event happens.
 
 @param directoryWatcher The directory watcher that generated the event
 @param eventID The ID of the event
 @param flags The flags describing the event
 @param URL The URL pointing to the file/directory that generated the event
 */
typedef void(^KSTDirectoryWatcherBlock)(KSTDirectoryWatcher *directoryWatcher, KSTDirectoryWatcherEventID eventID, KSTDirectoryWatcherEventFlags flags, NSURL *URL);

/**
 KSTDirectoryWatcher wraps the FSEvents APIs and allows you to watch a collection of directory URLs and invoke the provided block when an event takes place.
 */
@interface KSTDirectoryWatcher : NSObject

/**
 Get the directory URLs that are being watched.
 */
@property (readonly,copy,nonatomic) NSArray<NSURL *> *URLs;
/**
 Get the flags that were passed in on creation.
 
 @see KSTDirectoryWatcherCreateFlags
 */
@property (readonly,assign,nonatomic) KSTDirectoryWatcherCreateFlags flags;

/**
 Returns `[self initWithURLs:URLs flags:KSTDirectoryWatcherCreateFlagsNone block:block]`.
 
 @param URLs The directory URLs to watch
 @param block The block to invoke whenever an event occurs
 @return The initialized instance
 */
- (instancetype)initWithURLs:(NSArray<NSURL *> *)URLs block:(KSTDirectoryWatcherBlock)block;
/**
 Creates and returns an instance of the receiver to watch the provided directory URLs and invoke the provided *block* whenever an event occurs. The *block* will always be invoked on a private background queue.
 
 @param URLs The directory URLs to watch
 @param flags The flags affecting watch behavior
 @param block The block to invoke whenever an event occurs
 @return The initialized instance
 */
- (instancetype)initWithURLs:(NSArray<NSURL *> *)URLs flags:(KSTDirectoryWatcherCreateFlags)flags block:(KSTDirectoryWatcherBlock)block NS_DESIGNATED_INITIALIZER;
- (instancetype)init NS_UNAVAILABLE;

/**
 Start watching the directory URLs.
 */
- (void)startWatchingURLs;
/**
 Stop watching the directory URLs.
 */
- (void)stopWatchingURLs;

@end

NS_ASSUME_NONNULL_END
