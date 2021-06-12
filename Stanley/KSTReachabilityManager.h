//
//  KSTReachabilityManager.h
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

#import <Foundation/Foundation.h>
#import <SystemConfiguration/SystemConfiguration.h>

NS_ASSUME_NONNULL_BEGIN

/**
 Options mask for available flags. These mirror the values available for SCNetworkReachabilityFlags.
 */
typedef NS_OPTIONS(uint32_t, KSTReachabilityManagerFlags) {
    /**
     The flags could not be determined.
     */
    KSTReachabilityManagerFlagsUnknown = 0,
    /**
     The host can be reached by a transient connection (e.g. PPP).
     */
    KSTReachabilityManagerFlagsTransientConnection = kSCNetworkReachabilityFlagsTransientConnection,
    /**
     The host is reachable with the current network config.
     */
    KSTReachabilityManagerFlagsReachable = kSCNetworkReachabilityFlagsReachable,
    /**
     The host is reachable but a connection must first be made (e.g. VPN).
     */
    KSTReachabilityManagerFlagsConnectionRequired = kSCNetworkReachabilityFlagsConnectionRequired,
    /**
     The host is reachable and the required connection will be established with any traffic.
     */
    KSTReachabilityManagerFlagsConnectionOnTraffic = kSCNetworkReachabilityFlagsConnectionOnTraffic,
    /**
     The host is reachable but user intervention is required.
     */
    KSTReachabilityManagerFlagsInterventionRequired = kSCNetworkReachabilityFlagsInterventionRequired,
    /**
     The host is reachable and the required connection will be established by the CFSocketStream APIs.
     */
    KSTReachabilityManagerFlagsConnectionOnDemand = kSCNetworkReachabilityFlagsConnectionOnDemand,
    /**
     The host is local.
     */
    KSTReachabilityManagerFlagsIsLocalAddress = kSCNetworkReachabilityFlagsIsLocalAddress,
    /**
     Traffic will go directly to the host, instead of through a gateway.
     */
    KSTReachabilityManagerFlagsIsDirect = kSCNetworkReachabilityFlagsIsDirect,
    /**
     The host is reachable through a cellular connection.
     */
#if (TARGET_OS_IPHONE)
    KSTReachabilityManagerFlagsIsWWAN = kSCNetworkReachabilityFlagsIsWWAN
#endif
};

/**
 Enum for possible status values. These are derived from the value of flags.
 */
typedef NS_ENUM(NSInteger, KSTReachabilityManagerStatus) {
    /**
     The status is not known. If you access self.status it will block until status has been determined.
     */
    KSTReachabilityManagerStatusUnknown = 0,
    /**
     The host is not reachable.
     */
    KSTReachabilityManagerStatusNotReachable,
    /**
     The host is reachable via WWAN (cellular).
     */
    KSTReachabilityManagerStatusReachableViaWWAN,
    /**
     The host is reachable via WiFi.
     */
    KSTReachabilityManagerStatusReachableViaWiFi
};

/**
 Notification that is posted whenever the status changes. The object of the notification is the manager whose status changed. The notification is always posted on the main thread.
 */
FOUNDATION_EXTERN NSNotificationName const KSTReachabilityManagerNotificationDidChangeStatus;
/**
 The user info key used to hold the new status value.
 */
FOUNDATION_EXTERN NSString *const KSTReachabilityManagerUserInfoKeyStatus;

/**
 KSTReachabilityManager wraps the SCNetworkReachability APIs.
 */
@interface KSTReachabilityManager : NSObject

/**
 The shared manager, unless you need to check a specific host name, this should suffice.
 */
@property (class,readonly,nonatomic) KSTReachabilityManager *sharedManager;

/**
 The current flags of the receiver. Calling this method will block until flags can be determined if they are unknown when the method is called.
 
 @see KSTReachabilityManagerFlags
 */
@property (readonly,assign,nonatomic) KSTReachabilityManagerFlags flags;
/**
 The current status of the receiver. Calling this method will block until status can be determined if they are unknown when the method is called.
 
 @see KSTReachabilityManagerStatus
 */
@property (readonly,assign,nonatomic) KSTReachabilityManagerStatus status;

/**
 Return YES if the host is reachable by WiFi or WWAN, otherwise NO. This method will block to determine if the host is reachable.
 */
@property (readonly,nonatomic,getter=isReachable) BOOL reachable;
/**
 Return YES if the host is reachable by WWAN, otherwise NO. This method will block to determine if the host is reachable by WWAN.
 */
@property (readonly,nonatomic,getter=isReachableViaWWAN) BOOL reachableViaWWAN;
/**
 Return YES if the host is reachable by WiFi, otherwise NO. This method will block to determine if the host is reachable by WiFi.
 */
@property (readonly,nonatomic,getter=isReachableViaWiFi) BOOL reachableViaWiFi;

/**
 The designated initializer.
 
 Monitors the provided *networkReachability* object for changes, updates its properties and posts the appropriate notification when changes occur.
 
 @param networkReachability The network reachability object to monitor
 @return The initialized instance
 */
- (instancetype)initWithNetworkReachability:(SCNetworkReachabilityRef)networkReachability NS_DESIGNATED_INITIALIZER;
/**
 Calls `initWithNetworkReachability:` passing a network reachability object created by calling `SCNetworkReachabilityCreateWithAddress()`.
 
 @param address A pointer to the sockaddr_in6 to monitor
 @return The initialized instance
 */
- (instancetype)initWithAddress:(const struct sockaddr_in6 *)address;
/**
 Calls `initWithNetworkReachability:` passing a network reachability object created by calling `SCNetworkReachabilityCreateWithName()`.
 
 @param domain The domain to monitor (e.g. @"www.google.com")
 @return The initialized instance
 */
- (instancetype)initWithDomain:(NSString *)domain;

- (instancetype)init NS_UNAVAILABLE;
+ (instancetype)new NS_UNAVAILABLE;

/**
 Start monitoring the networkk reachability object for changes and post a notification when changes occur.
 */
- (void)startMonitoringReachability;
/**
 Stop monitoring the network reachability object for changes.
 */
- (void)stopMonitoringReachability;

/**
 Return a localized string representing the *status*.
 
 @param status The reachability manager status
 @return The localized string
 */
+ (NSString *)localizedStringForStatus:(KSTReachabilityManagerStatus)status;

@end

NS_ASSUME_NONNULL_END
