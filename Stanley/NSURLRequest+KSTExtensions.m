//
//  NSURLRequest+KSTExtensions.m
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

#import "NSURLRequest+KSTExtensions.h"

KSTHTTPMethod const KSTHTTPMethodOPTIONS = @"OPTIONS";
KSTHTTPMethod const KSTHTTPMethodGET = @"GET";
KSTHTTPMethod const KSTHTTPMethodHEAD = @"HEAD";
KSTHTTPMethod const KSTHTTPMethodPOST = @"POST";
KSTHTTPMethod const KSTHTTPMethodPUT = @"PUT";
KSTHTTPMethod const KSTHTTPMethodDELETE = @"DELETE";
KSTHTTPMethod const KSTHTTPMethodTRACE = @"TRACE";
KSTHTTPMethod const KSTHTTPMethodCONNECT = @"CONNECT";
KSTHTTPMethod const KSTHTTPMethodPATCH = @"PATCH";

KSTHTTPHeaderField const KSTHTTPHeaderFieldAccept = @"Accept";
KSTHTTPHeaderField const KSTHTTPHeaderFieldAcceptCharset = @"Accept-Charset";
KSTHTTPHeaderField const KSTHTTPHeaderFieldAcceptEncoding = @"Accept-Encoding";
KSTHTTPHeaderField const KSTHTTPHeaderFieldAcceptLanguage = @"Accept-Language";
KSTHTTPHeaderField const KSTHTTPHeaderFieldAcceptRanges = @"Accept-Ranges";
KSTHTTPHeaderField const KSTHTTPHeaderFieldAge = @"Age";
KSTHTTPHeaderField const KSTHTTPHeaderFieldAllow = @"Allow";
KSTHTTPHeaderField const KSTHTTPHeaderFieldAuthorization = @"Authorization";
KSTHTTPHeaderField const KSTHTTPHeaderFieldCacheControl = @"Cache-Control";
KSTHTTPHeaderField const KSTHTTPHeaderFieldConnection = @"Connection";
KSTHTTPHeaderField const KSTHTTPHeaderFieldContentEncoding = @"Content-Encoding";
KSTHTTPHeaderField const KSTHTTPHeaderFieldContentLanguage = @"Content-Language";
KSTHTTPHeaderField const KSTHTTPHeaderFieldContentLength = @"Content-Length";
KSTHTTPHeaderField const KSTHTTPHeaderFieldContentLocation = @"Content-Location";
KSTHTTPHeaderField const KSTHTTPHeaderFieldContentMD5 = @"Content-MD5";
KSTHTTPHeaderField const KSTHTTPHeaderFieldContentRange = @"Content-Range";
KSTHTTPHeaderField const KSTHTTPHeaderFieldContentType = @"Content-Type";
KSTHTTPHeaderField const KSTHTTPHeaderFieldDate = @"Date";
KSTHTTPHeaderField const KSTHTTPHeaderFieldETag = @"ETag";
KSTHTTPHeaderField const KSTHTTPHeaderFieldExpect = @"Expect";
KSTHTTPHeaderField const KSTHTTPHeaderFieldExpires = @"Expires";
KSTHTTPHeaderField const KSTHTTPHeaderFieldFrom = @"From";
KSTHTTPHeaderField const KSTHTTPHeaderFieldHost = @"Host";
KSTHTTPHeaderField const KSTHTTPHeaderFieldIfMatch = @"If-Match";
KSTHTTPHeaderField const KSTHTTPHeaderFieldIfModifiedSince = @"If-Modified-Since";
KSTHTTPHeaderField const KSTHTTPHeaderFieldIfNoneMatch = @"If-None-Match";
KSTHTTPHeaderField const KSTHTTPHeaderFieldIfRange = @"If-Range";
KSTHTTPHeaderField const KSTHTTPHeaderFieldIfUnmodifiedSince = @"If-Unmodified-Since";
KSTHTTPHeaderField const KSTHTTPHeaderFieldLastModified = @"Last-Modified";
KSTHTTPHeaderField const KSTHTTPHeaderFieldLocation = @"Location";
KSTHTTPHeaderField const KSTHTTPHeaderFieldMaxForwards = @"Max-Forwards";
KSTHTTPHeaderField const KSTHTTPHeaderFieldPragma = @"Pragma";
KSTHTTPHeaderField const KSTHTTPHeaderFieldProxyAuthentication = @"Proxy-Authentication";
KSTHTTPHeaderField const KSTHTTPHeaderFieldProxyAuthorization = @"Proxy-Authorization";
KSTHTTPHeaderField const KSTHTTPHeaderFieldRange = @"Range";
KSTHTTPHeaderField const KSTHTTPHeaderFieldReferer = @"Referer";
KSTHTTPHeaderField const KSTHTTPHeaderFieldRetryAfter = @"Retry-After";
KSTHTTPHeaderField const KSTHTTPHeaderFieldServer = @"Server";
KSTHTTPHeaderField const KSTHTTPHeaderFieldTE = @"TE";
KSTHTTPHeaderField const KSTHTTPHeaderFieldTrailer = @"Trailer";
KSTHTTPHeaderField const KSTHTTPHeaderFieldTransferEncoding = @"Transfer-Encoding";
KSTHTTPHeaderField const KSTHTTPHeaderFieldUpgrade = @"Upgrade";
KSTHTTPHeaderField const KSTHTTPHeaderFieldUserAgent = @"User-Agent";
KSTHTTPHeaderField const KSTHTTPHeaderFieldVary = @"Vary";
KSTHTTPHeaderField const KSTHTTPHeaderFieldVia = @"Via";
KSTHTTPHeaderField const KSTHTTPHeaderFieldWarning = @"Warning";
KSTHTTPHeaderField const KSTHTTPHeaderFieldWWWAuthenticate = @"WWW-Authenticate";

@implementation NSURLRequest (KSTExtensions)

+ (NSURLRequest *)KST_URLRequestWithURL:(NSURL *)URL HTTPMethod:(KSTHTTPMethod)HTTPMethod; {
    return [self KST_URLRequestWithURL:URL HTTPMethod:HTTPMethod HTTPHeaderFields:nil];
}
+ (NSURLRequest *)KST_URLRequestWithURL:(NSURL *)URL HTTPMethod:(NSString *)HTTPMethod HTTPHeaderFields:(nullable NSDictionary<KSTHTTPHeaderField, NSString *> *)HTTPHeaderFields; {
    NSMutableURLRequest *retval = [[NSMutableURLRequest alloc] initWithURL:URL];
    
    [retval setHTTPMethod:HTTPMethod];
    [retval setAllHTTPHeaderFields:HTTPHeaderFields];
    
    return [retval copy];
}

@end
