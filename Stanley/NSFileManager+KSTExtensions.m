//
//  NSFileManager+KSTExtensions.m
//  Stanley
//
//  Created by William Towe on 3/7/17.
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

#import "NSFileManager+KSTExtensions.h"
#import "NSBundle+KSTExtensions.h"
#import "KSTOSLoggingMacros.h"

static os_log_t kKSTOSLogTarget;

@implementation NSFileManager (KSTExtensions)

+ (void)load {
    kKSTOSLogTarget = KSTOSLogCreateWithSubsystem(@"com.kosoku.stanley", @"NSFileManager-KSTExtensions");
}

- (NSURL *)KST_applicationSupportDirectoryURL; {
    NSURL *retval = [self URLsForDirectory:NSApplicationSupportDirectory inDomains:NSUserDomainMask].firstObject;
    
#if (TARGET_OS_OSX)
    retval = [retval URLByAppendingPathComponent:[[NSBundle mainBundle] KST_bundleExecutable] isDirectory:YES];
#endif
    
    if (![retval checkResourceIsReachableAndReturnError:NULL]) {
        NSError *outError;
        if (![self createDirectoryAtURL:retval withIntermediateDirectories:NO attributes:nil error:&outError]) {
            KSTOSLogError("%@", outError);
        }
    }
    
    return retval;
}

- (NSURL *)KST_cachesDirectoryURL; {
    NSURL *retval = [self URLsForDirectory:NSCachesDirectory inDomains:NSUserDomainMask].firstObject;
    
#if (TARGET_OS_OSX)
    retval = [retval URLByAppendingPathComponent:[[NSBundle mainBundle] KST_bundleIdentifier] isDirectory:YES];
    
    if (![retval checkResourceIsReachableAndReturnError:NULL]) {
        NSError *outError;
        if (![self createDirectoryAtURL:retval withIntermediateDirectories:NO attributes:nil error:&outError]) {
            KSTOSLogError("%@", outError);
        }
    }
#endif
    
    return retval;
}

- (NSURL *)KST_documentDirectoryURL; {
    NSURL *retval = [self URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask].firstObject;
    
    return retval;
}

@end
