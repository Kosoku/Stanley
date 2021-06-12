//
//  KSTEnvironmentMacros.h
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

#ifndef __KST_ENVIRONMENT_MACROS__
#define __KST_ENVIRONMENT_MACROS__

#import <Foundation/Foundation.h>

/**
 Check to see if an environment variable is defined.
 
 if (KSTIsEnvironmentVariableDefined(MY_ENVIRONMENT_VARIABLE)) {
 // do something
 }
 
 @param envVariable The environment variable to check
 @return YES if the variable exists, otherwise NO
 */
#define KSTIsEnvironmentVariableDefined(envVariable) ([NSProcessInfo processInfo].environment[[NSString stringWithUTF8String:(#envVariable)]])
/**
 Returns the environment string value for the provided environment string variable.
 
 @param envString The string for which to return the environment value
 @return The environment string value
 */
#define KSTEnvironmentStringForString(envString) ([NSProcessInfo processInfo].environment[envString])

#endif
