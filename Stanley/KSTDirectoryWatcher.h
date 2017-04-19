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

typedef NS_OPTIONS(UInt32, KSTDirectoryWatcherCreateFlags) {
    KSTDirectoryWatcherCreateFlagsNone = kFSEventStreamCreateFlagNone,
    KSTDirectoryWatcherCreateFlagsNoDefer = kFSEventStreamCreateFlagNoDefer,
    KSTDirectoryWatcherCreateFlagsIgnoreSelf = kFSEventStreamCreateFlagIgnoreSelf,
    KSTDirectoryWatcherCreateFlagsFlagFileEvents = kFSEventStreamCreateFlagFileEvents,
    KSTDirectoryWatcherCreateFlagsMarkSelf = kFSEventStreamCreateFlagMarkSelf
};

typedef NS_OPTIONS(UInt32, KSTDirectoryWatcherEventFlags) {
    KSTDirectoryWatcherEventFlagsNone = kFSEventStreamEventFlagNone,
    KSTDirectoryWatcherEventFlagsMustScanSubDirs = kFSEventStreamEventFlagMustScanSubDirs,
    KSTDirectoryWatcherEventFlagsUserDropped = kFSEventStreamEventFlagUserDropped,
    KSTDirectoryWatcherEventFlagsKernelDropped = kFSEventStreamEventFlagKernelDropped,
    KSTDirectoryWatcherEventFlagsEventIDsWrapped = kFSEventStreamEventFlagEventIdsWrapped,
    KSTDirectoryWatcherEventFlagsHistoryDone = kFSEventStreamEventFlagHistoryDone,
    KSTDirectoryWatcherEventFlagsRootChanged = kFSEventStreamEventFlagRootChanged,
    KSTDirectoryWatcherEventFlagsMount = kFSEventStreamEventFlagMount,
    KSTDirectoryWatcherEventFlagsUnmount = kFSEventStreamEventFlagUnmount,
    KSTDirectoryWatcherEventFlagsItemCreated = kFSEventStreamEventFlagItemCreated,
    KSTDirectoryWatcherEventFlagsItemRemoved = kFSEventStreamEventFlagItemRemoved,
    KSTDirectoryWatcherEventFlagsItemInodeMetaMod = kFSEventStreamEventFlagItemInodeMetaMod,
    KSTDirectoryWatcherEventFlagsItemRenamed = kFSEventStreamEventFlagItemRenamed,
    KSTDirectoryWatcherEventFlagsItemModified = kFSEventStreamEventFlagItemModified,
    KSTDirectoryWatcherEventFlagsFinderInfoMod = kFSEventStreamEventFlagItemFinderInfoMod,
    KSTDirectoryWatcherEventFlagsItemChangeOwner = kFSEventStreamEventFlagItemChangeOwner,
    KSTDirectoryWatcherEventFlagsItemXattrMod = kFSEventStreamEventFlagItemXattrMod,
    KSTDirectoryWatcherEventFlagsItemIsFile = kFSEventStreamEventFlagItemIsFile,
    KSTDirectoryWatcherEventFlagsItemIsDir = kFSEventStreamEventFlagItemIsDir,
    KSTDirectoryWatcherEventFlagsItemIsSymlink = kFSEventStreamEventFlagItemIsSymlink,
    KSTDirectoryWatcherEventFlagsOwnEvent = kFSEventStreamEventFlagOwnEvent,
    KSTDirectoryWatcherEventFlagsItemIsHardLink = kFSEventStreamEventFlagItemIsHardlink,
    KSTDirectoryWatcherEventFlagsItemIsLastHardLink = kFSEventStreamEventFlagItemIsLastHardlink
};

typedef FSEventStreamEventId KSTDirectoryWatcherEventID;

@class KSTDirectoryWatcher;

typedef void(^KSTDirectoryWatcherBlock)(KSTDirectoryWatcher *directoryWatcher, KSTDirectoryWatcherEventID eventID, KSTDirectoryWatcherEventFlags flags, NSURL *URL);

@interface KSTDirectoryWatcher : NSObject

@property (readonly,copy,nonatomic) NSArray<NSURL *> *URLs;
@property (readonly,assign,nonatomic) KSTDirectoryWatcherCreateFlags flags;

- (instancetype)initWithURLs:(NSArray<NSURL *> *)URLs block:(KSTDirectoryWatcherBlock)block;
- (instancetype)initWithURLs:(NSArray<NSURL *> *)URLs flags:(KSTDirectoryWatcherCreateFlags)flags block:(KSTDirectoryWatcherBlock)block NS_DESIGNATED_INITIALIZER;
- (instancetype)init NS_UNAVAILABLE;

- (void)startWatchingURLs;
- (void)stopWatchingURLs;

@end

NS_ASSUME_NONNULL_END
