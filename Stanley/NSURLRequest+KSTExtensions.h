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
typedef NSString* KSTHTTPMethod NS_EXTENSIBLE_STRING_ENUM;

FOUNDATION_EXTERN KSTHTTPMethod const KSTHTTPMethodOPTIONS;
FOUNDATION_EXTERN KSTHTTPMethod const KSTHTTPMethodGET;
FOUNDATION_EXTERN KSTHTTPMethod const KSTHTTPMethodHEAD;
FOUNDATION_EXTERN KSTHTTPMethod const KSTHTTPMethodPOST;
FOUNDATION_EXTERN KSTHTTPMethod const KSTHTTPMethodPUT;
FOUNDATION_EXTERN KSTHTTPMethod const KSTHTTPMethodDELETE;
FOUNDATION_EXTERN KSTHTTPMethod const KSTHTTPMethodTRACE;
FOUNDATION_EXTERN KSTHTTPMethod const KSTHTTPMethodCONNECT;

/**
 Typedef for string constants for supported HTTP header fields. See https://www.w3.org/Protocols/rfc2616/rfc2616-sec14.html for more information.
 */
typedef NSString* KSTHTTPHeaderField NS_EXTENSIBLE_STRING_ENUM;

FOUNDATION_EXTERN KSTHTTPHeaderField const KSTHTTPHeaderFieldAccept;
FOUNDATION_EXTERN KSTHTTPHeaderField const KSTHTTPHeaderFieldAcceptCharset;
FOUNDATION_EXTERN KSTHTTPHeaderField const KSTHTTPHeaderFieldAcceptEncoding;
FOUNDATION_EXTERN KSTHTTPHeaderField const KSTHTTPHeaderFieldAcceptLanguage;
FOUNDATION_EXTERN KSTHTTPHeaderField const KSTHTTPHeaderFieldAcceptRanges;
FOUNDATION_EXTERN KSTHTTPHeaderField const KSTHTTPHeaderFieldAge;
FOUNDATION_EXTERN KSTHTTPHeaderField const KSTHTTPHeaderFieldAllow;
FOUNDATION_EXTERN KSTHTTPHeaderField const KSTHTTPHeaderFieldAuthorization;
FOUNDATION_EXTERN KSTHTTPHeaderField const KSTHTTPHeaderFieldCacheControl;
FOUNDATION_EXTERN KSTHTTPHeaderField const KSTHTTPHeaderFieldConnection;
FOUNDATION_EXTERN KSTHTTPHeaderField const KSTHTTPHeaderFieldContentEncoding;
FOUNDATION_EXTERN KSTHTTPHeaderField const KSTHTTPHeaderFieldContentLanguage;
FOUNDATION_EXTERN KSTHTTPHeaderField const KSTHTTPHeaderFieldContentLength;
FOUNDATION_EXTERN KSTHTTPHeaderField const KSTHTTPHeaderFieldContentLocation;
FOUNDATION_EXTERN KSTHTTPHeaderField const KSTHTTPHeaderFieldContentMD5;
FOUNDATION_EXTERN KSTHTTPHeaderField const KSTHTTPHeaderFieldContentRange;
FOUNDATION_EXTERN KSTHTTPHeaderField const KSTHTTPHeaderFieldContentType;
FOUNDATION_EXTERN KSTHTTPHeaderField const KSTHTTPHeaderFieldDate;
FOUNDATION_EXTERN KSTHTTPHeaderField const KSTHTTPHeaderFieldETag;
FOUNDATION_EXTERN KSTHTTPHeaderField const KSTHTTPHeaderFieldExpect;
FOUNDATION_EXTERN KSTHTTPHeaderField const KSTHTTPHeaderFieldExpires;
FOUNDATION_EXTERN KSTHTTPHeaderField const KSTHTTPHeaderFieldFrom;
FOUNDATION_EXTERN KSTHTTPHeaderField const KSTHTTPHeaderFieldHost;
FOUNDATION_EXTERN KSTHTTPHeaderField const KSTHTTPHeaderFieldIfMatch;
FOUNDATION_EXTERN KSTHTTPHeaderField const KSTHTTPHeaderFieldIfModifiedSince;
FOUNDATION_EXTERN KSTHTTPHeaderField const KSTHTTPHeaderFieldIfNoneMatch;
FOUNDATION_EXTERN KSTHTTPHeaderField const KSTHTTPHeaderFieldIfRange;
FOUNDATION_EXTERN KSTHTTPHeaderField const KSTHTTPHeaderFieldIfUnmodifiedSince;
FOUNDATION_EXTERN KSTHTTPHeaderField const KSTHTTPHeaderFieldLastModified;
FOUNDATION_EXTERN KSTHTTPHeaderField const KSTHTTPHeaderFieldLocation;
FOUNDATION_EXTERN KSTHTTPHeaderField const KSTHTTPHeaderFieldMaxForwards;
FOUNDATION_EXTERN KSTHTTPHeaderField const KSTHTTPHeaderFieldPragma;
FOUNDATION_EXTERN KSTHTTPHeaderField const KSTHTTPHeaderFieldProxyAuthenticate;
FOUNDATION_EXTERN KSTHTTPHeaderField const KSTHTTPHeaderFieldProxyAuthorization;
FOUNDATION_EXTERN KSTHTTPHeaderField const KSTHTTPHeaderFieldRange;
FOUNDATION_EXTERN KSTHTTPHeaderField const KSTHTTPHeaderFieldReferer;
FOUNDATION_EXTERN KSTHTTPHeaderField const KSTHTTPHeaderFieldRetryAfter;
FOUNDATION_EXTERN KSTHTTPHeaderField const KSTHTTPHeaderFieldServer;
FOUNDATION_EXTERN KSTHTTPHeaderField const KSTHTTPHeaderFieldTE;
FOUNDATION_EXTERN KSTHTTPHeaderField const KSTHTTPHeaderFieldTrailer;
FOUNDATION_EXTERN KSTHTTPHeaderField const KSTHTTPHeaderFieldTransferEncoding;
FOUNDATION_EXTERN KSTHTTPHeaderField const KSTHTTPHeaderFieldUpgrade;
FOUNDATION_EXTERN KSTHTTPHeaderField const KSTHTTPHeaderFieldUserAgent;
FOUNDATION_EXTERN KSTHTTPHeaderField const KSTHTTPHeaderFieldVary;
FOUNDATION_EXTERN KSTHTTPHeaderField const KSTHTTPHeaderFieldVia;
FOUNDATION_EXTERN KSTHTTPHeaderField const KSTHTTPHeaderFieldWarning;
FOUNDATION_EXTERN KSTHTTPHeaderField const KSTHTTPHeaderFieldWWWAuthenticate;

@interface NSURLRequest (KSTExtensions)

/**
 Returns `[self KST_URLRequestWithURL:URL HTTPMethod:HTTPMethod HTTPHeaderFields:nil]`.
 
 @param URL The URL for the request
 @param HTTPMethod The HTTP method for the request
 @return The request
 */
+ (NSURLRequest *)KST_URLRequestWithURL:(NSURL *)URL HTTPMethod:(KSTHTTPMethod)HTTPMethod;
/**
 Creates and returns an `NSURLRequest` instance with the provided *URL*, *HTTPMethod* and *HTTPHeaderFields*.
 
 @param URL The URL for the request
 @param HTTPMethod The HTTP method for the request
 @param HTTPHeaderFields The HTTP header fields for the request
 @return The request
 */
+ (NSURLRequest *)KST_URLRequestWithURL:(NSURL *)URL HTTPMethod:(KSTHTTPMethod)HTTPMethod HTTPHeaderFields:(nullable NSDictionary<KSTHTTPHeaderField, NSString *> *)HTTPHeaderFields;

@end

NS_ASSUME_NONNULL_END
