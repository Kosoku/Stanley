//
//  KSTOSLoggingMacros.h
//  Stanley
//
//  Created by William Towe on 7/3/19.
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

#ifndef __KST_OS_LOGGING_MACROS__
#define __KST_OS_LOGGING_MACROS__

#import <Foundation/Foundation.h>
#import <CoreGraphics/CGGeometry.h>
#import <os/log.h>
#import <Stanley/NSBundle+KSTExtensions.h>

/**
 Calls through to `KSTOSLogCreateWithSubsystem`, passing `NSBundle.KST_currentBundle.bundleIdentifier` and `categoryAsNSString` respectively.
 
 @param categoryAsNSString The category to create the os log with
 @return The os log
 */
#define KSTOSLogCreate(categoryAsNSString) KSTOSLogCreateWithSubsystem(NSBundle.KST_currentBundle.bundleIdentifier, categoryAsNSString)
/**
 Calls through to `os_log_create` and returns the result.
 
 @param subsystemAsNSString The subsystem, Apple recommends reverse DNS style naming
 @param categoryAsNSString The category, can be anything to help differentiate logs within the console app
 @return The os log
 */
#define KSTOSLogCreateWithSubsystem(subsystemAsNSString, categoryAsNSString) os_log_create((subsystemAsNSString).UTF8String, (categoryAsNSString).UTF8String)

/**
 Logs using the os log system, passing an explicit log to use, along with type, and a format string.
 
 @param log The target os log
 @param type The type of log (e.g. OS_LOG_TYPE_INFO)
 @param format The format string, must be a plain string type, supports all printf format specifiers in addition to %@
 */
#define KSTOSLogExplicit(log, type, format, ...) os_log_with_type((log), (type), ("%s [Line %d] " format), __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__)
/**
 Logs using the os log system, passing an explicit log to use, along with OS_LOG_TYPE_INFO, and a format string.
 
 @param log The target os log
 @param format The format string, must be a plain string type, supports all printf format specifiers in addition to %@
 */
#define KSTOSLogExplicitInfo(log, format, ...) os_log_with_type((log), (OS_LOG_TYPE_INFO), ("%s [Line %d] " format), __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__)
/**
 Logs using the os log system, passing an explicit log to use, along with OS_LOG_TYPE_DEBUG, and a format string.
 
 @param log The target os log
 @param format The format string, must be a plain string type, supports all printf format specifiers in addition to %@
 */
#define KSTOSLogExplicitDebug(log, format, ...) os_log_with_type((log), (OS_LOG_TYPE_DEBUG), ("%s [Line %d] " format), __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__)
/**
 Logs using the os log system, passing an explicit log to use, along with OS_LOG_TYPE_ERROR, and a format string.
 
 @param log The target os log
 @param format The format string, must be a plain string type, supports all printf format specifiers in addition to %@
 */
#define KSTOSLogExplicitError(log, format, ...) os_log_with_type((log), (OS_LOG_TYPE_ERROR), ("%s [Line %d] " format), __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__)
/**
 Logs using the os log system, passing an explicit log to use, along with OS_LOG_TYPE_FAULT, and a format string.
 
 @param log The target os log
 @param format The format string, must be a plain string type, supports all printf format specifiers in addition to %@
 */
#define KSTOSLogExplicitFault(log, format, ...) os_log_with_type((log), (OS_LOG_TYPE_FAULT), ("%s [Line %d] " format), __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__)

/**
 When using the below logging macros, they implicitly pass a constant defined as KST_OS_LOG_TARGET_DEF as the log argument. You must define this somewhere within calling scope or the below macros will fail to compile. For example:
 
 ````
 static os_log_t kKSTOSLogTarget;
 
 @implementation MyClass
 + (void)initialize {
     if (self == MyClass.class) {
        kKSTOSLogTarget = KSTOSLogCreate(NSStringFromClass(self));
     }
 }
 
 - (void)myMethod {
    KSTOSLogInfo("this is a log message");
 }
 @end
 ````
 */
#ifndef KST_OS_LOG_TARGET_DEF
#define KST_OS_LOG_TARGET_DEF kKSTOSLogTarget
#endif

/**
 Logs using the os log system, passing the KST_OS_LOG_TARGET_DEF as the log argument, a type, and a format string.
 
 @param type The type of log (e.g. OS_LOG_TYPE_INFO)
 @param format The format string, must be a plain string type, supports all printf format specifiers in addition to %@
 */
#define KSTOSLog(type, format, ...) os_log_with_type((KST_OS_LOG_TARGET_DEF), (type), ("%s [Line %d] " format), __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__)
/**
 Logs using the os log system, passing the KST_OS_LOG_TARGET_DEF as the log argument, OS_LOG_TYPE_INFO as the type, and a format string.
 
 @param format The format string, must be a plain string type, supports all printf format specifiers in addition to %@
 */
#define KSTOSLogInfo(format, ...) os_log_with_type((KST_OS_LOG_TARGET_DEF), (OS_LOG_TYPE_INFO), ("%s [Line %d] " format), __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__)
/**
 Logs using the os log system, passing the KST_OS_LOG_TARGET_DEF as the log argument, OS_LOG_TYPE_DEBUG as the type, and a format string.
 
 @param format The format string, must be a plain string type, supports all printf format specifiers in addition to %@
 */
#define KSTOSLogDebug(format, ...) os_log_with_type((KST_OS_LOG_TARGET_DEF), (OS_LOG_TYPE_DEBUG), ("%s [Line %d] " format), __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__)
/**
 Logs using the os log system, passing the KST_OS_LOG_TARGET_DEF as the log argument, OS_LOG_TYPE_ERROR as the type, and a format string.
 
 @param format The format string, must be a plain string type, supports all printf format specifiers in addition to %@
 */
#define KSTOSLogError(format, ...) os_log_with_type((KST_OS_LOG_TARGET_DEF), (OS_LOG_TYPE_ERROR), ("%s [Line %d] " format), __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__)
/**
 Logs using the os log system, passing the KST_OS_LOG_TARGET_DEF as the log argument, OS_LOG_TYPE_FAULT as the type, and a format string.
 
 @param format The format string, must be a plain string type, supports all printf format specifiers in addition to %@
 */
#define KSTOSLogFault(format, ...) os_log_with_type((KST_OS_LOG_TARGET_DEF), (OS_LOG_TYPE_FAULT), ("%s [Line %d] " format), __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__)

#endif
