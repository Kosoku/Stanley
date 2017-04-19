//
//  NSError+KSTExtensions.m
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

#import "NSError+KSTExtensions.h"
#import "NSBundle+KSTPrivateExtensions.h"

KSTErrorAlertKey const KSTErrorAlertKeyTitle = @"KSTErrorAlertKeyTitle";
KSTErrorAlertKey const KSTErrorAlertKeyMessage = @"KSTErrorAlertKeyMessage";

@implementation NSError (KSTExtensions)

+ (NSString *)KST_defaultAlertTitle; {
    return NSLocalizedStringWithDefaultValue(@"ERROR_ALERT_DEFAULT_TITLE", nil, [NSBundle KST_frameworkBundle], @"Error", @"default error alert title");
}
+ (NSString *)KST_defaultAlertMessage; {
    return NSLocalizedStringWithDefaultValue(@"ERROR_ALERT_DEFAULT_MESSAGE", nil, [NSBundle KST_frameworkBundle], @"The operation could not be completed.", @"default error alert message");
}

- (NSString *)KST_alertTitle {
#if (TARGET_OS_IPHONE)
    return self.userInfo[KSTErrorAlertKeyTitle] ?: self.class.KST_defaultAlertTitle;
#else
    return self.userInfo[KSTErrorAlertKeyTitle] ?: self.userInfo[NSLocalizedDescriptionKey] ?: self.class.KST_defaultAlertTitle;
#endif
}
- (NSString *)KST_alertMessage {
#if (TARGET_OS_IPHONE)
    return self.userInfo[KSTErrorAlertKeyMessage] ?: self.userInfo[NSLocalizedDescriptionKey] ?: self.class.KST_defaultAlertMessage;
#else
    return self.userInfo[KSTErrorAlertKeyMessage] ?: self.userInfo[NSLocalizedRecoverySuggestionErrorKey] ?: self.class.KST_defaultAlertMessage;
#endif
}

@end
