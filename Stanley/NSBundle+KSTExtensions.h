//
//  NSBundle+KSTExtensions.h
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

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSBundle (KSTExtensions)

/**
 Returns the current bundle based on the calling context. For example, if you call this property within a framework, it will return the framework bundle. If you call this property in the main app, it will return the main bundle.
 */
@property (class,readonly,nonatomic) NSBundle *KST_currentBundle;

/**
 Returns the bundle identifier. For example, "com.mycompany.app".
 
 @return The bundle identifier
 */
- (NSString *)KST_bundleIdentifier;
/**
 Returns the bundle display name. For example, "App". This value is localized.
 
 @return The bundle display name
 */
- (nullable NSString *)KST_bundleDisplayName;
/**
 Returns the bundle executable. For example, "App". This value is not localized.
 
 @return The bundle executable
 */
- (NSString *)KST_bundleExecutable;
/**
 Returns the bundle short version string. For example, "1.0.0".
 
 @return The bundle short version string
 */
- (NSString *)KST_bundleShortVersionString;
/**
 Returns the bundle version. For example, "1".
 
 @return The bundle version
 */
- (NSString *)KST_bundleVersion;

@end

NS_ASSUME_NONNULL_END
