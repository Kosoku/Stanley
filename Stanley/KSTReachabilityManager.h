//
//  KSTReachabilityManager.h
//  Stanley
//
//  Created by William Towe on 9/29/17.
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
#import <SystemConfiguration/SystemConfiguration.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger, KSTReachabilityManagerStatus) {
    KSTReachabilityManagerStatusUnknown = 0,
    KSTReachabilityManagerStatusNotReachable,
    KSTReachabilityManagerStatusReachableViaWWAN,
    KSTReachabilityManagerStatusReachableViaWiFi
};

FOUNDATION_EXTERN NSNotificationName const KSTReachabilityManagerNotificationDidChangeStatus;
FOUNDATION_EXTERN NSString *const KSTReachabilityManagerUserInfoKeyStatus;

@interface KSTReachabilityManager : NSObject

@property (class,readonly,nonatomic) KSTReachabilityManager *sharedManager;

@property (readonly,assign,nonatomic) KSTReachabilityManagerStatus status;

@property (readonly,nonatomic,getter=isReachable) BOOL reachable;
@property (readonly,nonatomic,getter=isReachableViaWWAN) BOOL reachableViaWWAN;
@property (readonly,nonatomic,getter=isReachableViaWiFi) BOOL reachableViaWiFi;

- (instancetype)initWithNetworkReachability:(SCNetworkReachabilityRef)networkReachability NS_DESIGNATED_INITIALIZER;
- (instancetype)initWithAddress:(const struct sockaddr_in6 *)address;
- (instancetype)initWithDomain:(NSString *)domain;

- (instancetype)init NS_UNAVAILABLE;
+ (instancetype)new NS_UNAVAILABLE;

- (void)startMonitoringReachability;
- (void)stopMonitoringReachability;

+ (NSString *)localizedStringForStatus:(KSTReachabilityManagerStatus)status;

@end

NS_ASSUME_NONNULL_END
