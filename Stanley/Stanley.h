//
//  Stanley.h
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

#import <Foundation/Foundation.h>

//! Project version number for Stanley.
FOUNDATION_EXPORT double StanleyVersionNumber;

//! Project version string for Stanley.
FOUNDATION_EXPORT const unsigned char StanleyVersionString[];

// In this header, you should import all the public headers of your framework using statements like #import <Stanley/PublicHeader.h>

// defines
#import <Stanley/KSTDefines.h>

// macros
#import <Stanley/KSTScopeMacros.h>
#import <Stanley/KSTEnvironmentMacros.h>
#import <Stanley/KSTLoggingMacros.h>
#import <Stanley/KSTOSLoggingMacros.h>
#import <Stanley/KSTMacros.h>

// functions
#import <Stanley/KSTFunctions.h>
#import <Stanley/KSTGeometryFunctions.h>

// protocols
#import <Stanley/KSTDeepCopying.h>
#import <Stanley/KSTDeepMutableCopying.h>

// categories
#import <Stanley/NSBundle+KSTExtensions.h>
#import <Stanley/NSFileManager+KSTExtensions.h>
#import <Stanley/NSData+KSTExtensions.h>
#import <Stanley/NSString+KSTExtensions.h>
#import <Stanley/NSHTTPURLResponse+KSTExtensions.h>
#import <Stanley/NSURLRequest+KSTExtensions.h>
#import <Stanley/NSArray+KSTExtensions.h>
#import <Stanley/NSMutableArray+KSTExtensions.h>
#import <Stanley/NSObject+KSTExtensions.h>
#import <Stanley/NSError+KSTExtensions.h>
#import <Stanley/NSURL+KSTExtensions.h>
#import <Stanley/NSDate+KSTExtensions.h>
#import <Stanley/NSCharacterSet+KSTExtensions.h>
#import <Stanley/NSDictionary+KSTExtensions.h>

// classes
#import <Stanley/KSTSnakeCaseToLlamaCaseValueTransformer.h>
#import <Stanley/KSTFileWatcher.h>
#import <Stanley/KSTPhoneNumberFormatter.h>
#import <Stanley/KSTTimer.h>
#if (TARGET_OS_OSX || TARGET_OS_IOS || TARGET_OS_TV)
#import <Stanley/KSTReachabilityManager.h>
#endif
#if (TARGET_OS_OSX)
#import <Stanley/KSTDirectoryWatcher.h>
#endif
