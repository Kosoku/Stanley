//
//  NSHTTPURLResponse+KSTExtensions.h
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
