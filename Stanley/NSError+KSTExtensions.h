//
//  NSError+KSTExtensions.h
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

NS_ASSUME_NONNULL_BEGIN

/**
 Typedef for additional keys to be used when constructing the userInfo dictionary of an NSError.
 */
typedef NSString* KSTErrorAlertKey NS_STRING_ENUM;

/**
 The key used to identify the alert title.
 */
FOUNDATION_EXTERN KSTErrorAlertKey const KSTErrorAlertKeyTitle;
/**
 The key used to identify the alert message.
 */
FOUNDATION_EXTERN KSTErrorAlertKey const KSTErrorAlertKeyMessage;

@interface NSError (KSTExtensions)

/**
 Returns the default alert title.
 */
@property (class,readonly,nonatomic) NSString *KST_defaultAlertTitle;
/**
 Returns the default alert message.
 */
@property (class,readonly,nonatomic) NSString *KST_defaultAlertMessage;

/**
 Returns the value for the KSTErrorAlertTitleKey key in the receiver's userInfo dictionary if non-nil, otherwise returns KST_defaultAlertTitle.
 
 @return The alert title
 */
@property (readonly,nonatomic) NSString *KST_alertTitle;
/**
 Returns the value for the KSTErrorAlertMessageKey key in the receiver's userInfo dictionary if non-nil, then the value for the NSLocalizedDescriptionKey key, then KST_defaultAlertMessage.
 
 @return The alert message
 */
@property (readonly,nonatomic) NSString *KST_alertMessage;

@end

NS_ASSUME_NONNULL_END
