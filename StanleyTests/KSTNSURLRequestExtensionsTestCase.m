//
//  KSTNSURLRequestExtensionsTestCase.m
//  Stanley
//
//  Created by William Towe on 3/7/17.
//  Copyright © 2019 Kosoku Interactive, LLC. All rights reserved.
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

#import <XCTest/XCTest.h>

#import <Stanley/NSURLRequest+KSTExtensions.h>

@interface KSTNSURLRequestExtensionsTestCase : XCTestCase

@end

@implementation KSTNSURLRequestExtensionsTestCase

- (void)testExample {
    NSURL *URL = [NSURL URLWithString:@"https://www.google.com"];
    NSString *HTTPMethod = KSTHTTPMethodCONNECT;
    NSDictionary *HTTPHeaderFields = @{KSTHTTPHeaderFieldAcceptLanguage: @"en"};
    NSURLRequest *request = [NSURLRequest KST_URLRequestWithURL:URL HTTPMethod:HTTPMethod HTTPHeaderFields:HTTPHeaderFields];
    
    XCTAssertEqualObjects(request.URL, URL);
    XCTAssertEqualObjects(request.HTTPMethod, HTTPMethod);
    XCTAssertEqualObjects(request.allHTTPHeaderFields, HTTPHeaderFields);
}

@end
