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

const struct KSTHTTPMethod KSTHTTPMethod = {
    .OPTIONS = @"OPTIONS",
    .GET = @"GET",
    .HEAD = @"HEAD",
    .POST = @"POST",
    .PUT = @"PUT",
    .DELETE = @"DELETE",
    .TRACE = @"TRACE",
    .CONNECT = @"CONNECT"
};

const struct KSTHTTPHeaderField KSTHTTPHeaderField = {
    .Accept = @"Accept",
    .Accept_Charset = @"Accept-Charset",
    .Accept_Encoding = @"Accept-Encoding",
    .Accept_Language = @"Accept-Language",
    .Accept_Ranges = @"Accept-Ranges",
    .Age = @"Age",
    .Allow = @"Allow",
    .Authorization = @"Authorization",
    .Cache_Control = @"Cache-Control",
    .Connection = @"Connection",
    .Content_Encoding = @"Content-Encoding",
    .Content_Language = @"Content-Language",
    .Content_Length = @"Content-Length",
    .Content_Location = @"Content-Location",
    .Content_MD5 = @"Content-MD5",
    .Content_Range = @"Content-Range",
    .Content_Type = @"Content-Type",
    .Date = @"Date",
    .ETag = @"ETag",
    .Expect = @"Expect",
    .Expires = @"Expires",
    .From = @"From",
    .Host = @"Host",
    .If_Match = @"If-Match",
    .If_Modified_Since = @"If-Modified-Since",
    .If_None_Match = @"If-None-Match",
    .If_Range = @"If-Range",
    .If_Unmodified_Since = @"If-Unmodified-Since",
    .Last_Modified = @"Last-Modified",
    .Location = @"Location",
    .Max_Forwards = @"Max-Forwards",
    .Pragma = @"Pragma",
    .Proxy_Authenticate = @"Proxy-Authenticate",
    .Proxy_Authorization = @"Proxy-Authorization",
    .Range = @"Range",
    .Referer = @"Referer",
    .Retry_After = @"Retry-After",
    .Server = @"Server",
    .TE = @"TE",
    .Trailer = @"Trailer",
    .Transfer_Encoding = @"Transfer-Encoding",
    .Upgrade = @"Upgrade",
    .User_Agent = @"User-Agent",
    .Vary = @"Vary",
    .Via = @"Via",
    .Warning = @"Warning",
    .WWW_Authenticate = @"WWW-Authenticate"
};

@implementation NSURLRequest (KSTExtensions)

+ (NSURLRequest *)KST_URLRequestWithURL:(NSURL *)URL HTTPMethod:(NSString *)HTTPMethod; {
    return [self KST_URLRequestWithURL:URL HTTPMethod:HTTPMethod HTTPHeaderFields:nil];
}
+ (NSURLRequest *)KST_URLRequestWithURL:(NSURL *)URL HTTPMethod:(NSString *)HTTPMethod HTTPHeaderFields:(nullable NSDictionary<NSString *, NSString *> *)HTTPHeaderFields; {
    NSMutableURLRequest *retval = [[NSMutableURLRequest alloc] initWithURL:URL];
    
    [retval setHTTPMethod:HTTPMethod];
    [retval setAllHTTPHeaderFields:HTTPHeaderFields];
    
    return [retval copy];
}

@end
