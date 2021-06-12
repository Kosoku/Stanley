//
//  NSURL+KSTExtensions.m
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
