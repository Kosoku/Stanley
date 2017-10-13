//
//  KSTLoggingMacros.h
//  Stanley
//
//  Created by William Towe on 3/7/17.
//  Copyright © 2017 Kosoku Interactive, LLC. All rights reserved.
//
//  Redistribution and use in source and binary forms, with or without modification, are permitted provided that the following conditions are met:
//
//  1. Redistributions of source code must retain the above copyright notice, this list of conditions and the following disclaimer.
//
//  2. Redistributions in binary form must reproduce the above copyright notice, this list of conditions and the following disclaimer in the documentation and/or other materials provided with the distribution.
//
//  THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.

#ifndef __KST_LOGGING_MACROS__
#define __KST_LOGGING_MACROS__

#import <Foundation/Foundation.h>
#import <CoreGraphics/CGGeometry.h>

/**
 Options mask describing what log statements should show up.
 */
typedef NS_OPTIONS(NSUInteger, KSTLogFlags) {
    /**
     No logging statements will show up.
     */
    KSTLogFlagsNone = 0,
    /**
     Only KSTLogError() statements will show up.
     */
    KSTLogFlagsError = 1 << 0,
    /**
     KSTLogWarning() and below statements will show up.
     */
    KSTLogFlagsWarning = 1 << 1,
    /**
     KSTLogInfo() and below statements will show up.
     */
    KSTLogFlagsInfo = 1 << 2,
    /**
     KSTLogDebug() and below statements will show up.
     */
    KSTLogFlagsDebug = 1 << 3,
    /**
     KSTLogVerbose() and below statements will show up.
     */
    KSTLogFlagsVerbose = 1 << 4
};

/**
 Enum describing the current log level. This should be defined somewhere in your project as a static const variable named kKSTLogLevel with the value equal to one of the below values.
 
 static NSInteger const kKSTLogLevel = ...;
 */
typedef NS_ENUM(NSInteger, KSTLogLevel) {
    /**
     Nothing is logged.
     */
    KSTLogLevelNone = KSTLogFlagsNone,
    /**
     Only error statements are logged.
     */
    KSTLogLevelError = KSTLogFlagsError,
    /**
     Only warning and below statements are logged.
     */
    KSTLogLevelWarning = KSTLogLevelError | KSTLogFlagsWarning,
    /**
     Only info and below statements are logged.
     */
    KSTLogLevelInfo = KSTLogLevelWarning | KSTLogFlagsInfo,
    /**
     Only debug and below statements are logged.
     */
    KSTLogLevelDebug = KSTLogLevelInfo | KSTLogFlagsDebug,
    /**
     Only verbose and below statements are logged.
     */
    KSTLogLevelVerbose = KSTLogLevelDebug | KSTLogFlagsVerbose
};

#ifdef DEBUG

#define KSTLog(fmt, ...) NSLog((@"%s [Line %d] " fmt), __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__)

#else

#ifdef KST_LOGGING_DISABLE_RELEASE_LOGGING
#define KSTLog(...)
#else
#define KSTLog(fmt, ...) NSLog((@"%s [Line %d] " fmt), __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__)
#endif

#endif

#define KSTLogObject(objectToLog) KSTLog(@"%@",objectToLog)
#define KSTLogCGRect(rectToLog) KSTLogObject(NSStringFromCGRect(rectToLog))
#define KSTLogCGSize(sizeToLog) KSTLogObject(NSStringFromCGSize(sizeToLog))
#define KSTLogCGPoint(pointToLog) KSTLogObject(NSStringFromCGPoint(pointToLog))
#define KSTLogCGFloat(floatToLog) KSTLog(@"%f",floatToLog)
#define KSTLogBOOL(boolToLog) KSTLog(@"%@",boolToLog ? @"YES" : @"NO")

#if (!TARGET_OS_IPHONE)

#define KSTLogNSRect(rectToLog) KSTLogObject(NSStringFromRect(rectToLog))
#define KSTLogNSSize(sizeToLog) KSTLogObject(NSStringFromSize(sizeToLog))
#define KSTLogNSPoint(pointToLog) KSTLogObject(NSStringFromPoint(pointToLog))

#endif

/**
 The variable name that should be used when defining the current log level.
 
 static NSInteger const kKSTLogLevel = ...;
 */
#ifndef KST_LOGGING_LOG_LEVEL_DEF
#define KST_LOGGING_LOG_LEVEL_DEF kKSTLogLevel
#endif

/**
 Macro used to check against the current log level and execute the log statement.
 
 This will throw an error if kKSTLogLevel is not defined somewhere within your project.
 */
#define KSTLogMaybe(lvl, flg, fmt, ...) \
do {if (lvl & flg) {KSTLog(fmt, ##__VA_ARGS__);}} while(0)

#define KSTLogError(fmt, ...) KSTLogMaybe(KST_LOGGING_LOG_LEVEL_DEF, KSTLogFlagsError, fmt, ##__VA_ARGS__)
#define KSTLogWarning(fmt, ...) KSTLogMaybe(KST_LOGGING_LOG_LEVEL_DEF, KSTLogFlagsWarning, fmt, ##__VA_ARGS__)
#define KSTLogInfo(fmt, ...) KSTLogMaybe(KST_LOGGING_LOG_LEVEL_DEF, KSTLogFlagsInfo, fmt, ##__VA_ARGS__)
#define KSTLogDebug(fmt, ...) KSTLogMaybe(KST_LOGGING_LOG_LEVEL_DEF, KSTLogFlagsDebug, fmt, ##__VA_ARGS__)
#define KSTLogVerbose(fmt, ...) KSTLogMaybe(KST_LOGGING_LOG_LEVEL_DEF, KSTLogFlagsVerbose, fmt, ##__VA_ARGS__)

#endif
