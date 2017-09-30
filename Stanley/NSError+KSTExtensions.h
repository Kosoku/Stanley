//
//  NSError+KSTExtensions.h
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
