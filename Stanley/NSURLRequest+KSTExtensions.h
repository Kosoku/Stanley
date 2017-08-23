//
//  NSURLRequest+KSTExtensions.h
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
 Typedef for string constants for supported HTTP methods. See http://www.w3.org/Protocols/rfc2616/rfc2616-sec9.html for more information.
 */
typedef NSString* KSHTTPMethod NS_EXTENSIBLE_STRING_ENUM;

FOUNDATION_EXPORT KSHTTPMethod const KSHTTPMethodOPTIONS;
FOUNDATION_EXPORT KSHTTPMethod const KSHTTPMethodGET;
FOUNDATION_EXPORT KSHTTPMethod const KSHTTPMethodHEAD;
FOUNDATION_EXPORT KSHTTPMethod const KSHTTPMethodPOST;
FOUNDATION_EXPORT KSHTTPMethod const KSHTTPMethodPUT;
FOUNDATION_EXPORT KSHTTPMethod const KSHTTPMethodDELETE;
FOUNDATION_EXPORT KSHTTPMethod const KSHTTPMethodTRACE;
FOUNDATION_EXPORT KSHTTPMethod const KSHTTPMethodCONNECT;

/**
 Typedef for string constants for supported HTTP header fields. See https://www.w3.org/Protocols/rfc2616/rfc2616-sec14.html for more information.
 */
typedef NSString* KSTHTTPHeaderField NS_EXTENSIBLE_STRING_ENUM;

FOUNDATION_EXPORT KSTHTTPHeaderField const KSTHTTPHeaderFieldAccept;
FOUNDATION_EXPORT KSTHTTPHeaderField const KSTHTTPHeaderFieldAcceptCharset;
FOUNDATION_EXPORT KSTHTTPHeaderField const KSTHTTPHeaderFieldAcceptEncoding;
FOUNDATION_EXPORT KSTHTTPHeaderField const KSTHTTPHeaderFieldAcceptLanguage;
FOUNDATION_EXPORT KSTHTTPHeaderField const KSTHTTPHeaderFieldAcceptRanges;
FOUNDATION_EXPORT KSTHTTPHeaderField const KSTHTTPHeaderFieldAge;
FOUNDATION_EXPORT KSTHTTPHeaderField const KSTHTTPHeaderFieldAllow;
FOUNDATION_EXPORT KSTHTTPHeaderField const KSTHTTPHeaderFieldAuthorization;
FOUNDATION_EXPORT KSTHTTPHeaderField const KSTHTTPHeaderFieldCacheControl;
FOUNDATION_EXPORT KSTHTTPHeaderField const KSTHTTPHeaderFieldConnection;
FOUNDATION_EXPORT KSTHTTPHeaderField const KSTHTTPHeaderFieldContentEncoding;
FOUNDATION_EXPORT KSTHTTPHeaderField const KSTHTTPHeaderFieldContentLanguage;
FOUNDATION_EXPORT KSTHTTPHeaderField const KSTHTTPHeaderFieldContentLength;
FOUNDATION_EXPORT KSTHTTPHeaderField const KSTHTTPHeaderFieldContentLocation;
FOUNDATION_EXPORT KSTHTTPHeaderField const KSTHTTPHeaderFieldContentMD5;
FOUNDATION_EXPORT KSTHTTPHeaderField const KSTHTTPHeaderFieldContentRange;
FOUNDATION_EXPORT KSTHTTPHeaderField const KSTHTTPHeaderFieldContentType;
FOUNDATION_EXPORT KSTHTTPHeaderField const KSTHTTPHeaderFieldDate;
FOUNDATION_EXPORT KSTHTTPHeaderField const KSTHTTPHeaderFieldETag;
FOUNDATION_EXPORT KSTHTTPHeaderField const KSTHTTPHeaderFieldExpect;
FOUNDATION_EXPORT KSTHTTPHeaderField const KSTHTTPHeaderFieldExpires;
FOUNDATION_EXPORT KSTHTTPHeaderField const KSTHTTPHeaderFieldFrom;
FOUNDATION_EXPORT KSTHTTPHeaderField const KSTHTTPHeaderFieldHost;
FOUNDATION_EXPORT KSTHTTPHeaderField const KSTHTTPHeaderFieldIfMatch;
FOUNDATION_EXPORT KSTHTTPHeaderField const KSTHTTPHeaderFieldIfModifiedSince;
FOUNDATION_EXPORT KSTHTTPHeaderField const KSTHTTPHeaderFieldIfNoneMatch;
FOUNDATION_EXPORT KSTHTTPHeaderField const KSTHTTPHeaderFieldIfRange;
FOUNDATION_EXPORT KSTHTTPHeaderField const KSTHTTPHeaderFieldIfUnmodifiedSince;
FOUNDATION_EXPORT KSTHTTPHeaderField const KSTHTTPHeaderFieldLastModified;
FOUNDATION_EXPORT KSTHTTPHeaderField const KSTHTTPHeaderFieldLocation;
FOUNDATION_EXPORT KSTHTTPHeaderField const KSTHTTPHeaderFieldMaxForwards;
FOUNDATION_EXPORT KSTHTTPHeaderField const KSTHTTPHeaderFieldPragma;
FOUNDATION_EXPORT KSTHTTPHeaderField const KSTHTTPHeaderFieldProxyAuthenticate;
FOUNDATION_EXPORT KSTHTTPHeaderField const KSTHTTPHeaderFieldProxyAuthorization;
FOUNDATION_EXPORT KSTHTTPHeaderField const KSTHTTPHeaderFieldRange;
FOUNDATION_EXPORT KSTHTTPHeaderField const KSTHTTPHeaderFieldReferer;
FOUNDATION_EXPORT KSTHTTPHeaderField const KSTHTTPHeaderFieldRetryAfter;
FOUNDATION_EXPORT KSTHTTPHeaderField const KSTHTTPHeaderFieldServer;
FOUNDATION_EXPORT KSTHTTPHeaderField const KSTHTTPHeaderFieldTE;
FOUNDATION_EXPORT KSTHTTPHeaderField const KSTHTTPHeaderFieldTrailer;
FOUNDATION_EXPORT KSTHTTPHeaderField const KSTHTTPHeaderFieldTransferEncoding;
FOUNDATION_EXPORT KSTHTTPHeaderField const KSTHTTPHeaderFieldUpgrade;
FOUNDATION_EXPORT KSTHTTPHeaderField const KSTHTTPHeaderFieldUserAgent;
FOUNDATION_EXPORT KSTHTTPHeaderField const KSTHTTPHeaderFieldVary;
FOUNDATION_EXPORT KSTHTTPHeaderField const KSTHTTPHeaderFieldVia;
FOUNDATION_EXPORT KSTHTTPHeaderField const KSTHTTPHeaderFieldWarning;
FOUNDATION_EXPORT KSTHTTPHeaderField const KSTHTTPHeaderFieldWWWAuthenticate;

@interface NSURLRequest (KSTExtensions)

/**
 Returns `[self KST_URLRequestWithURL:URL HTTPMethod:HTTPMethod HTTPHeaderFields:nil]`.
 
 @param URL The URL for the request
 @param HTTPMethod The HTTP method for the request
 @return The request
 */
+ (NSURLRequest *)KST_URLRequestWithURL:(NSURL *)URL HTTPMethod:(KSHTTPMethod)HTTPMethod;
/**
 Creates and returns an `NSURLRequest` instance with the provided *URL*, *HTTPMethod* and *HTTPHeaderFields*.
 
 @param URL The URL for the request
 @param HTTPMethod The HTTP method for the request
 @param HTTPHeaderFields The HTTP header fields for the request
 @return The request
 */
+ (NSURLRequest *)KST_URLRequestWithURL:(NSURL *)URL HTTPMethod:(KSHTTPMethod)HTTPMethod HTTPHeaderFields:(nullable NSDictionary<KSTHTTPHeaderField, NSString *> *)HTTPHeaderFields;

@end

NS_ASSUME_NONNULL_END
