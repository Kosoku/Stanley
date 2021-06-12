//
//  NSBundle+KSTExtensions.m
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

#import "NSBundle+KSTExtensions.h"

#import <dlfcn.h>

static NSString *const kKSTBundleIdentifierKey = @"CFBundleIdentifier";
static NSString *const kKSTBundleDisplayNameKey = @"CFBundleDisplayName";
static NSString *const kKSTBundleExecutableKey = @"CFBundleExecutable";
static NSString *const kKSTBundleShortVersionStringKey = @"CFBundleShortVersionString";
static NSString *const kKSTBundleVersionKey = @"CFBundleVersion";

@implementation NSBundle (KSTExtensions)

// implementation translated from Swift from https://bou.io/NSBundle.current.html
+ (NSBundle *)KST_currentBundle {
    static NSCache *kCache;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        kCache = [[NSCache alloc] init];
        
        kCache.name = @"com.kosoku.stanley.current-bundle.cache";
    });
    
    NSNumber *caller = NSThread.callStackReturnAddresses[1];
    NSBundle *retval = [kCache objectForKey:caller];
    
    if (retval == nil) {
        Dl_info info = {
            .dli_fname = "",
            .dli_fbase = NULL,
            .dli_sname = "",
            .dli_saddr = NULL
        };
        
        if (dladdr(caller.pointerValue, &info) == 0) {
            return nil;
        }
        
        NSString *bundlePath = [NSString stringWithCString:info.dli_fname encoding:NSUTF8StringEncoding];
        
        if (bundlePath == nil) {
            return nil;
        }
        
        for (NSBundle *bundle in [NSBundle.allBundles arrayByAddingObjectsFromArray:NSBundle.allFrameworks]) {
            NSString *path = bundle.executablePath.stringByResolvingSymlinksInPath;
            
            if ([path isEqualToString:bundlePath]) {
                retval = bundle;
                
                [kCache setObject:retval forKey:caller];
                
                break;
            }
        }
    }
    
    return retval;
}

- (NSString *)KST_bundleIdentifier; {
    return self.infoDictionary[kKSTBundleIdentifierKey];
}
- (NSString *)KST_bundleDisplayName; {
    return self.infoDictionary[kKSTBundleDisplayNameKey];
}
- (NSString *)KST_bundleExecutable; {
    return self.infoDictionary[kKSTBundleExecutableKey];
}
- (NSString *)KST_bundleShortVersionString; {
    return self.infoDictionary[kKSTBundleShortVersionStringKey];
}
- (NSString *)KST_bundleVersion; {
    return self.infoDictionary[kKSTBundleVersionKey];
}

@end
