//
//  NSError+KSTExtensions.m
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
