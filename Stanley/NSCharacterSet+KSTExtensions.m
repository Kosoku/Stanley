//
//  NSCharacterSet+KSTExtensions.m
//  Stanley
//
//  Created by William Towe on 3/15/18.
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

#import "NSCharacterSet+KSTExtensions.h"

@implementation NSCharacterSet (KSTExtensions)

- (NSArray<NSString *> *)KST_allStrings {
    NSMutableArray *strings = [[NSMutableArray alloc] init];
    
    for (int plane = 0; plane <= 16; plane++) {
        if ([self hasMemberInPlane:plane]) {
            UTF32Char c;
            for (c = plane << 16; c < (plane+1) << 16; c++) {
                if ([self longCharacterIsMember:c]) {
                    UTF32Char c1 = OSSwapHostToLittleInt32(c);
                    NSString *s = [[NSString alloc] initWithBytes:&c1 length:4 encoding:NSUTF32LittleEndianStringEncoding];
                    
                    [strings addObject:s];
                }
            }
        }
    }
    
    return strings;
}

@end
