//
//  KSTEnvironmentMacros.h
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
