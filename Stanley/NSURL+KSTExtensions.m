//
//  NSURL+KSTExtensions.m
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

#import "NSURL+KSTExtensions.h"

@interface NSURL (KSTPrivateExtensions)
- (id)_KST_resourceValueForKey:(NSString *)key;
@end

@implementation NSURL (KSTExtensions)

- (NSDate *)KST_creationDate {
    return [self _KST_resourceValueForKey:NSURLCreationDateKey];
}
- (NSDate *)KST_contentModificationDate {
    return [self _KST_resourceValueForKey:NSURLContentModificationDateKey];
}
- (BOOL)KST_isDirectory {
    NSNumber *retval = [self _KST_resourceValueForKey:NSURLIsDirectoryKey];
    
    return retval.boolValue;
}
- (NSString *)KST_typeIdentifier {
    return [self _KST_resourceValueForKey:NSURLTypeIdentifierKey];
}

- (NSDictionary *)KST_queryDictionary; {
    if (self.query.length == 0) {
        return nil;
    }
    
    NSMutableDictionary *retval = [[NSMutableDictionary alloc] init];
    
    for (NSString *pair in [self.query componentsSeparatedByString:@"&"]) {
        NSArray *pairComps = [pair componentsSeparatedByString:@"="];
        
        [retval setObject:pairComps[1] forKey:pairComps[0]];
    }
    
    return retval;
}

+ (NSURL *)KST_URLWithBaseString:(NSString *)baseString parameters:(NSDictionary *)parameters; {
    if (baseString == nil) {
        return nil;
    }
    
    NSMutableString *retval = [[NSMutableString alloc] initWithString:baseString];
    
    if (parameters.count > 0) {
        NSUInteger i = 0;
        
        for (NSString *key in [parameters keysSortedByValueUsingSelector:@selector(localizedStandardCompare:)]) {
            if ((i++) == 0) {
                [retval appendFormat:@"?%@=%@",key,parameters[key]];
            }
            else {
                [retval appendFormat:@"&%@=%@",key,parameters[key]];
            }
        }
    }
    
    return [NSURL URLWithString:retval];
}

@end

@implementation NSURL (KSTPrivateExtensions)

- (id)_KST_resourceValueForKey:(NSString *)key; {
    id retval = nil;
    
    [self getResourceValue:&retval forKey:key error:NULL];
    
    return retval;
}

@end
