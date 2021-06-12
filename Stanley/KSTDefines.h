//
//  KSTDefines.h
//  Stanley
//
//  Created by William Towe on 9/7/18.
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

#ifndef __KST_DEFINES__
#define __KST_DEFINES__

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

/**
 Typedef for a block that takes zero parameters and returns void.
 */
typedef void(^KSTVoidBlock)(void);
/**
 Typedef for a block that takes a single value as its only parameter and returns void.
 
 @param value The block value
 */
typedef void(^KSTValueBlock)(id _Nullable value);
/**
 Typedef for a block that takes a value and an error as its parameters and returns void.
 
 @param value The block value
 @param error The block error
 */
typedef void(^KSTValueErrorBlock)(id _Nullable value, NSError * _Nullable error);

NS_ASSUME_NONNULL_END

#endif
