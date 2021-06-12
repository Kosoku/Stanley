//
//  NSData+KSTExtensions.m
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

#import "NSData+KSTExtensions.h"

#import <CommonCrypto/CommonDigest.h>

@implementation NSData (KSTExtensions)

- (NSString *)KST_SHA1String; {
    if (self.length == 0) {
        return nil;
    }
    
    unsigned char buffer[CC_SHA1_DIGEST_LENGTH];
    
    CC_SHA1(self.bytes, (CC_LONG)self.length, buffer);
    
    NSMutableString *retval = [[NSMutableString alloc] initWithCapacity:CC_SHA1_DIGEST_LENGTH * 2];
    
    for (NSUInteger i=0; i<CC_SHA1_DIGEST_LENGTH; i++) {
        [retval appendFormat:@"%02x",buffer[i]];
    }
    
    return retval;
}
- (NSString *)KST_SHA256String; {
    if (self.length == 0) {
        return nil;
    }
    
    unsigned char buffer[CC_SHA256_DIGEST_LENGTH];
    
    CC_SHA256(self.bytes, (CC_LONG)self.length, buffer);
    
    NSMutableString *retval = [[NSMutableString alloc] initWithCapacity:CC_SHA256_DIGEST_LENGTH * 2];
    
    for (NSUInteger i=0; i<CC_SHA256_DIGEST_LENGTH; i++) {
        [retval appendFormat:@"%02x",buffer[i]];
    }
    
    return retval;
}
- (NSString *)KST_SHA512String; {
    if (self.length == 0) {
        return nil;
    }
    
    unsigned char buffer[CC_SHA512_DIGEST_LENGTH];
    
    CC_SHA512(self.bytes, (CC_LONG)self.length, buffer);
    
    NSMutableString *retval = [[NSMutableString alloc] initWithCapacity:CC_SHA512_DIGEST_LENGTH * 2];
    
    for (NSUInteger i=0; i<CC_SHA512_DIGEST_LENGTH; i++) {
        [retval appendFormat:@"%02x",buffer[i]];
    }
    
    return retval;
}

@end
