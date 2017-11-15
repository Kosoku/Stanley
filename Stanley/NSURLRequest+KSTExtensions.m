//
//  NSURLRequest+KSTExtensions.m
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

#import "NSURLRequest+KSTExtensions.h"

KSTHTTPMethod const KSTHTTPMethodOPTIONS = @"OPTIONS";
KSTHTTPMethod const KSTHTTPMethodGET = @"GET";
KSTHTTPMethod const KSTHTTPMethodHEAD = @"HEAD";
KSTHTTPMethod const KSTHTTPMethodPOST = @"POST";
KSTHTTPMethod const KSTHTTPMethodPUT = @"PUT";
KSTHTTPMethod const KSTHTTPMethodDELETE = @"DELETE";
KSTHTTPMethod const KSTHTTPMethodTRACE = @"TRACE";
KSTHTTPMethod const KSTHTTPMethodCONNECT = @"CONNECT";

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
