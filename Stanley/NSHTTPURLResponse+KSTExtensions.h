//
//  NSHTTPURLResponse+KSTExtensions.h
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
 Enum representing the currently defined HTTP status codes. See http://www.w3.org/Protocols/rfc2616/rfc2616-sec10.html for more information.
 */
typedef NS_ENUM(NSInteger, KSTHTTPStatusCode) {
    KSTHTTPStatusCodeContinue = 100,
    KSTHTTPStatusCodeSwitchingProtocols = 101,
    
    KSTHTTPStatusCodeOK = 200,
    KSTHTTPStatusCodeCreated = 201,
    KSTHTTPStatusCodeAccepted = 202,
    KSTHTTPStatusCodeNonAuthoritativeInformation = 203,
    KSTHTTPStatusCodeNoContent = 204,
    KSTHTTPStatusCodeResetContent = 205,
    KSTHTTPStatusCodePartialContent = 206,
    
    KSTHTTPStatusCodeMultipleChoices = 300,
    KSTHTTPStatusCodeMovedPermanently = 301,
    KSTHTTPStatusCodeFound = 302,
    KSTHTTPStatusCodeSeeOther = 303,
    KSTHTTPStatusCodeNotModified = 304,
    KSTHTTPStatusCodeUseProxy = 305,
    KSTHTTPStatusCodeTemporaryRedirect = 307,
    
    KSTHTTPStatusCodeBadRequest = 400,
    KSTHTTPStatusCodeUnauthorized = 401,
    KSTHTTPStatusCodePaymentRequired = 402,
    KSTHTTPStatusCodeForbidden = 403,
    KSTHTTPStatusCodeNotFound = 404,
    KSTHTTPStatusCodeMethoNotAllowed = 405,
    KSTHTTPStatusCodeNotAcceptable = 406,
    KSTHTTPStatusCodeProxyAuthenticationRequired = 407,
    KSTHTTPStatusCodeRequestTimeout = 408,
    KSTHTTPStatusCodeConflict = 409,
    KSTHTTPStatusCodeGone = 410,
    KSTHTTPStatusCodeLengthRequired = 411,
    KSTHTTPStatusCodePreconditionFailed = 412,
    KSTHTTPStatusCodeRequestEntityTooLarge = 413,
    KSTHTTPStatusCodeRequestURITooLarge = 414,
    KSTHTTPStatusCodeUnsupportedMediaType = 415,
    KSTHTTPStatusCodeRequestedRangeNotSatisfiable = 416,
    KSTHTTPStatusCodeExpectationFailed = 417,
    
    KSTHTTPStatusCodeInternalServerError = 500,
    KSTHTTPStatusCodeNotImplemented = 501,
    KSTHTTPStatusCodeBadGateway = 502,
    KSTHTTPStatusCodeServiceUnavailable = 503,
    KSTHTTPStatusCodeGatewayTimeout = 504,
    KSTHTTPStatusCodeHTTPVersionNotSupported = 505
};

@interface NSHTTPURLResponse (KSTExtensions)

/**
 Returns the localized description returned by `[NSHTTPURLResponse localizedStringForStatusCode]`.
 
 @return The localized description
 */
- (NSString *)KST_localizedStatusCodeString;

@end

NS_ASSUME_NONNULL_END
