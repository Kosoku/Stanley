//
//  KSTSnakeCaseToLlamaCaseValueTransformer.m
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
