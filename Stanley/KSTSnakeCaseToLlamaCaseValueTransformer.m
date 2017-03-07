//
//  KSTSnakeCaseToLlamaCaseValueTransformer.m
//  Stanley
//
//  Created by William Towe on 3/7/17.
//  Copyright (c) 2017 Kosoku Interactive, LLC. All rights reserved.
//
//  Redistribution and use in source and binary forms, with or without modification, are permitted provided that the following conditions are met:
//
//  1. Redistributions of source code must retain the above copyright notice, this list of conditions and the following disclaimer.
//
//  2. Redistributions in binary form must reproduce the above copyright notice, this list of conditions and the following disclaimer in the documentation and/or other materials provided with the distribution.
//
//  THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.

#import "KSTSnakeCaseToLlamaCaseValueTransformer.h"

NSString *const KSTSnakeCaseToLlamaCaseValueTransformerName = @"KSTSnakeCaseToLlamaCaseValueTransformerName";

@implementation KSTSnakeCaseToLlamaCaseValueTransformer

+ (void)load {
    [NSValueTransformer setValueTransformer:[[KSTSnakeCaseToLlamaCaseValueTransformer alloc] init] forName:KSTSnakeCaseToLlamaCaseValueTransformerName];
}

+ (Class)transformedValueClass {
    return [NSString class];
}

+ (BOOL)allowsReverseTransformation {
    return YES;
}

- (id)transformedValue:(id)value {
    if ([value isKindOfClass:[NSString class]]) {
        NSArray *comps = [[value stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] componentsSeparatedByString:@"_"];
        NSMutableString *retval = [[NSMutableString alloc] init];
        
        /**
         This covers the case of names already being in camel case, for example, without this special case @"firstName" -> @"firstname". We expect @"firstName" -> @"firstName".
         
         This also covers the case of @"First" -> @"first", as expected.
         */
        if (comps.count == 1 &&
            [comps.firstObject rangeOfCharacterFromSet:[NSCharacterSet uppercaseLetterCharacterSet]].length > 0 &&
            [comps.firstObject rangeOfCharacterFromSet:[NSCharacterSet uppercaseLetterCharacterSet]].location != 0) {
            
            [retval appendString:comps.firstObject];
        }
        /**
         Otherwise, do the normal thing with each component.
         */
        else {
            [comps enumerateObjectsUsingBlock:^(NSString *obj, NSUInteger idx, BOOL *stop) {
                if (idx == 0) {
                    [retval appendString:obj.lowercaseString];
                }
                else {
                    [retval appendString:obj.capitalizedString];
                }
            }];
        }
        
        return [retval copy];
    }
    return nil;
}
- (id)reverseTransformedValue:(id)value {
    if ([value isKindOfClass:[NSString class]]) {
        NSString *retval = [[value stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] stringByReplacingOccurrencesOfString:@"([a-z])([A-Z])" withString:@"$1_$2" options:NSRegularExpressionSearch range:NSMakeRange(0, [value length])].lowercaseString;
        
        return retval;
    }
    return nil;
}

@end
