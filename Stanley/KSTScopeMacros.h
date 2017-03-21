//
//  KSTScopeMacros.h
//  Stanley
//
//  Created by William Towe on 3/7/17.
//  Copyright (c) 2017 Kosoku Interactive, LLC. All rights reserved.
//
//  Redistribution and use in source and binary forms, with or without modification, are permitted provided that the following conditions are met:
//
//  1. Redistributions of source code must retain the above copyright notice, this list of conditions and the following disclaimer.
//
//  2. Redistributions in binary form must reproduce the above copyright notice, this list of conditions and the following disclaimer in the documentation and/or other materials provided with the distribution.
//
//  THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.

#ifndef __KST_SCOPE_MACROS__
#define __KST_SCOPE_MACROS__

#import "KSTScopePrivateMacros.h"

/**
 Given a real object receiver and key path, returns the string concatentation of all arguments except the first. If the keypath is invalid, it will be flagged at compile time.
 
 NSString *string = ...;
 NSString *keypath = @kstKeypath(string.lowercaseString); // @"lowercaseString"
 
 keypath = @kstKeypath(NSObject, version); // @"version"
 
 keypath = @kstKeypath(NSString.new, lowercaseString); // @"lowercaseString"
 */
#define kstKeypath(...) \
kstmetamacro_if_eq(1, kstmetamacro_argcount(__VA_ARGS__))(kstkeypath1(__VA_ARGS__))(kstkeypath2(__VA_ARGS__))

/**
 Macro that defines some code to be executed when the current scope exits. The code must be enclosed in braces and terminated with a semicolon, and will be executed regardless of how the scope is exited.
 
 void *bytes = malloc(100);
 
 @kstOnExit {
    free(bytes);
 };
 
 // the free(bytes) will always be executed before the function/method returns
 if (someCondition) {
    return 0;
 }
 else {
    return 1;
 }
 */
#define kstOnExit \
__strong kst_cleanupBlock_t kstmetamacro_concat(kst_exitBlock_, __LINE__) __attribute__((cleanup(kst_executeCleanupBlock), unused)) = ^

/**
 Macro to create a weakly referenced variable of type var.
 
 @param The variable you want to weakly reference
 */
#define kstWeakify(var) __weak typeof(var) kstweak_##var = var;

/**
 Macro to strongly reference a previously weakly referenced variable created by using kstweakify. The strongly referenced variable shadows the weakly referenced variable, preventing a retain cycle. Especially useful for referencing self within a block.
 
 kstweakify(self); // expands to __weak typeof(self) kstweak_selfvar = self;
 self.myBlock = ^{
    kststrongify(self); // expands to  __strong typeof(self) self = kstweak_selfvar;
    // safely reference self within the block because self is actually a shadow variable
    self.myString = @"myStringValue";
 }
 
 @param The variable you want to strongly reference, which must have been previously created using kstweakify
 */
#define kstStrongify(var) \
_Pragma("clang diagnostic push") \
_Pragma("clang diagnostic ignored \"-Wshadow\"") \
__strong typeof(var) var = kstweak_##var; \
_Pragma("clang diagnostic pop")

#endif
