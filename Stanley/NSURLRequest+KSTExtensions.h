//
//  NSURLRequest+KSTExtensions.h
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
FOUNDATION_EXTERN KSTHTTPMethod const KSTHTTPMethodPATCH;

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
