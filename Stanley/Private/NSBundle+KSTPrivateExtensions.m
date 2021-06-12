//
//  NSBundle+KSTPrivateExtensions.m
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

#import "NSBundle+KSTPrivateExtensions.h"

@implementation NSBundle (KSTPrivateExtensions)

+ (NSBundle *)KST_frameworkBundle; {
    return [self bundleWithIdentifier:@"com.kosoku.stanley"] ?: [self bundleWithURL:[[[NSBundle mainBundle].privateFrameworksURL URLByAppendingPathComponent:@"Stanley.framework" isDirectory:YES] URLByAppendingPathComponent:@"Stanley.bundle" isDirectory:YES]] ?: [self bundleWithURL:[[NSBundle mainBundle] URLForResource:@"Stanley" withExtension:@"bundle"]];
}

@end
