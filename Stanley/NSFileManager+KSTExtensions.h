//
//  NSFileManager+KSTExtensions.h
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

@interface NSFileManager (KSTExtensions)

/**
 Returns the NSURL instance representing the application support directory, creating the directory if it does not exist. On macOS, appends the bundle executable name to the returned URL (e.g. <application_support>/<bundle_executable>).
 
 @return The application support NSURL instance
 */
- (NSURL *)KST_applicationSupportDirectoryURL;
/**
 Returns the NSURL instance representing the caches directory. On macOS, appends the bundle identifier to the returned URL (e.g. <caches>/<bundle_identifier>) and creates the directory if it does not already exist. On iOS, the base caches directory will always exist.
 
 @return The caches NSURL instance
 */
- (NSURL *)KST_cachesDirectoryURL;
/**
 Returns the NSURL instance representing the document directory.
 
 @return The document NSURL instance
 */
- (NSURL *)KST_documentDirectoryURL;

@end

NS_ASSUME_NONNULL_END
