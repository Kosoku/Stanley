//
//  KSTReachabilityManager.m
//  Stanley
//
//  Created by William Towe on 9/29/17.
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

#import "KSTReachabilityManager.h"
#import "KSTScopeMacros.h"
#import "KSTFunctions.h"
#import "NSBundle+KSTPrivateExtensions.h"

#import <netinet/in.h>
#import <netinet6/in6.h>
#import <arpa/inet.h>
#import <ifaddrs.h>
#import <netdb.h>

static KSTReachabilityManagerStatus KSTReachabilityManagerStatusForNetworkReachabilityFlags(SCNetworkReachabilityFlags flags) {
    BOOL reachable = ((flags & kSCNetworkReachabilityFlagsReachable) != 0);
    BOOL needsConnection = ((flags & kSCNetworkReachabilityFlagsConnectionRequired) != 0);
    BOOL canConnectionAutomatically = (((flags & kSCNetworkReachabilityFlagsConnectionOnDemand ) != 0) || ((flags & kSCNetworkReachabilityFlagsConnectionOnTraffic) != 0));
    BOOL canConnectWithoutUserInteraction = (canConnectionAutomatically && (flags & kSCNetworkReachabilityFlagsInterventionRequired) == 0);
    BOOL networkReachable = (reachable && (!needsConnection || canConnectWithoutUserInteraction));
    
    KSTReachabilityManagerStatus retval = KSTReachabilityManagerStatusUnknown;
    
    if (!networkReachable) {
        retval = KSTReachabilityManagerStatusNotReachable;
    }
#if (TARGET_OS_IPHONE)
    else if ((flags & kSCNetworkReachabilityFlagsIsWWAN) != 0) {
        retval = KSTReachabilityManagerStatusReachableViaWWAN;
    }
#endif
    else {
        retval = KSTReachabilityManagerStatusReachableViaWiFi;
    }
    
    return retval;
}

NSNotificationName const KSTReachabilityManagerNotificationDidChangeStatus = @"KSTReachabilityManagerNotificationDidChangeStatus";
NSString *const KSTReachabilityManagerUserInfoKeyStatus = @"KSTReachabilityManagerUserInfoKeyStatus";

@interface KSTReachabilityManager ()
@property (readwrite,assign,nonatomic) KSTReachabilityManagerFlags flags;
@property (readwrite,assign,nonatomic) KSTReachabilityManagerStatus status;

@property (assign,nonatomic) SCNetworkReachabilityRef networkReachability;
@end

static void KSTReachabilityManagerNetworkReachabilityCallback(SCNetworkReachabilityRef networkReachability, SCNetworkReachabilityFlags flags, void *info) {
    KSTReachabilityManagerStatus status = KSTReachabilityManagerStatusForNetworkReachabilityFlags(flags);
    KSTReachabilityManager *manager = (__bridge id)info;
    
    kstWeakify(manager);
    KSTDispatchMainAsync(^{
        kstStrongify(manager);
        [manager setFlags:(KSTReachabilityManagerFlags)flags];
        [manager setStatus:status];
        
        [NSNotificationCenter.defaultCenter postNotificationName:KSTReachabilityManagerNotificationDidChangeStatus object:manager userInfo:@{KSTReachabilityManagerUserInfoKeyStatus: @(status)}];
    });
}

@implementation KSTReachabilityManager

- (void)dealloc {
    [self stopMonitoringReachability];
    
    if (_networkReachability != NULL) {
        CFRelease(_networkReachability);
    }
}

- (instancetype)initWithNetworkReachability:(SCNetworkReachabilityRef)networkReachability {
    if (!(self = [super init]))
        return nil;
    
    _networkReachability = CFRetain(networkReachability);
    _status = KSTReachabilityManagerStatusUnknown;
    
    return self;
}
- (instancetype)initWithAddress:(const struct sockaddr_in6 *)address {
    SCNetworkReachabilityRef reachability = SCNetworkReachabilityCreateWithAddress(kCFAllocatorDefault, (const struct sockaddr *)address);
    id retval = [self initWithNetworkReachability:reachability];
    
    CFRelease(reachability);
    
    return retval;
}
- (instancetype)initWithDomain:(NSString *)domain {
    SCNetworkReachabilityRef reachability = SCNetworkReachabilityCreateWithName(kCFAllocatorDefault, [domain UTF8String]);
    
    id retval = [self initWithNetworkReachability:reachability];
    
    CFRelease(reachability);
    
    return retval;
}

- (void)startMonitoringReachability; {
    [self stopMonitoringReachability];
    
    if (self.networkReachability == NULL) {
        return;
    }
    
    SCNetworkReachabilityContext context = {
        0,
        (__bridge void *)self,
        NULL,
        NULL,
        NULL
    };
    SCNetworkReachabilitySetCallback(self.networkReachability, KSTReachabilityManagerNetworkReachabilityCallback, &context);
    SCNetworkReachabilityScheduleWithRunLoop(self.networkReachability, CFRunLoopGetMain(), kCFRunLoopCommonModes);
    
    kstWeakify(self);
    dispatch_async(dispatch_get_global_queue(QOS_CLASS_UTILITY, 0), ^{
        kstStrongify(self);
        SCNetworkReachabilityFlags flags;
        if (!SCNetworkReachabilityGetFlags(self.networkReachability, &flags)) {
            return;
        }
        
        KSTDispatchMainAsync(^{
            KSTReachabilityManagerStatus status = KSTReachabilityManagerStatusForNetworkReachabilityFlags(flags);
            
            [self setFlags:(KSTReachabilityManagerFlags)flags];
            [self setStatus:status];
            
            [NSNotificationCenter.defaultCenter postNotificationName:KSTReachabilityManagerNotificationDidChangeStatus object:self userInfo:@{KSTReachabilityManagerUserInfoKeyStatus: @(status)}];
        });
    });
}
- (void)stopMonitoringReachability; {
    if (self.networkReachability == NULL) {
        return;
    }
    
    SCNetworkReachabilityUnscheduleFromRunLoop(self.networkReachability, CFRunLoopGetMain(), kCFRunLoopCommonModes);
    
    [self setFlags:KSTReachabilityManagerFlagsUnknown];
    [self setStatus:KSTReachabilityManagerStatusUnknown];
}

+ (NSString *)localizedStringForStatus:(KSTReachabilityManagerStatus)status; {
    switch (status) {
        case KSTReachabilityManagerStatusUnknown:
            return NSLocalizedStringWithDefaultValue(@"REACHABILITY_MANAGER_STATUS_UNKNOWN", nil, [NSBundle KST_frameworkBundle], @"Unknown", @"reachability manager status unknown");
        case KSTReachabilityManagerStatusReachableViaWiFi:
            return NSLocalizedStringWithDefaultValue(@"REACHABILITY_MANAGER_STATUS_REACHABLE_VIA_WIFI", nil, [NSBundle KST_frameworkBundle], @"Reachable via WiFi", @"reachability manager status reachable via wifi");
        case KSTReachabilityManagerStatusReachableViaWWAN:
            return NSLocalizedStringWithDefaultValue(@"REACHABILITY_MANAGER_STATUS_REACHABLE_VIA_WWAN", nil, [NSBundle KST_frameworkBundle], @"Reachable via WWAN", @"reachability manager status reachable via wwan");
        case KSTReachabilityManagerStatusNotReachable:
            return NSLocalizedStringWithDefaultValue(@"REACHABILITY_MANAGER_STATUS_REACHABLE", nil, [NSBundle KST_frameworkBundle], @"Not Reachable", @"reachability manager status not reachable");
    }
}

+ (KSTReachabilityManager *)sharedManager {
    static KSTReachabilityManager *kRetval;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        struct sockaddr_in6 address;
        bzero(&address, sizeof(address));
        address.sin6_len = sizeof(address);
        address.sin6_family = AF_INET6;
        
        kRetval = [[KSTReachabilityManager alloc] initWithAddress:&address];
    });
    return kRetval;
}

- (KSTReachabilityManagerFlags)flags {
    if (_flags == KSTReachabilityManagerFlagsUnknown) {
        SCNetworkReachabilityFlags flags;
        if (SCNetworkReachabilityGetFlags(self.networkReachability, &flags)) {
            _flags = (KSTReachabilityManagerFlags)flags;
        }
    }
    return _flags;
}
- (KSTReachabilityManagerStatus)status {
    if (_status == KSTReachabilityManagerStatusUnknown) {
        SCNetworkReachabilityFlags flags;
        if (SCNetworkReachabilityGetFlags(self.networkReachability, &flags)) {
            KSTReachabilityManagerStatus status = KSTReachabilityManagerStatusForNetworkReachabilityFlags(flags);
            
            _status = status;
        }
    }
    return _status;
}
- (BOOL)isReachable {
    SCNetworkReachabilityFlags flags;
    if (!SCNetworkReachabilityGetFlags(self.networkReachability, &flags)) {
        return NO;
    }
    KSTReachabilityManagerStatus status = KSTReachabilityManagerStatusForNetworkReachabilityFlags(flags);
    
    return (status == KSTReachabilityManagerStatusReachableViaWWAN ||
            status == KSTReachabilityManagerStatusReachableViaWiFi);
}
- (BOOL)isReachableViaWWAN {
    SCNetworkReachabilityFlags flags;
    if (!SCNetworkReachabilityGetFlags(self.networkReachability, &flags)) {
        return NO;
    }
    KSTReachabilityManagerStatus status = KSTReachabilityManagerStatusForNetworkReachabilityFlags(flags);
    
    return (status == KSTReachabilityManagerStatusReachableViaWWAN);
}
- (BOOL)isReachableViaWiFi {
    SCNetworkReachabilityFlags flags;
    if (!SCNetworkReachabilityGetFlags(self.networkReachability, &flags)) {
        return NO;
    }
    KSTReachabilityManagerStatus status = KSTReachabilityManagerStatusForNetworkReachabilityFlags(flags);
    
    return (status == KSTReachabilityManagerStatusReachableViaWiFi);
}

@end
