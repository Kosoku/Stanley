//
//  NSDictionary+KSTExtensions.h
//  Stanley
//
//  Created by William Towe on 10/11/18.
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

@interface NSDictionary<__covariant KeyType, __covariant ObjectType> (KSTExtensions)

/**
 Returns a new dictionary by adding the entries from *dictionary* to the receiver.
 
 @param dictionary The dictionary whose entries should be added
 @return The new dictionary
 */
- (NSDictionary<KeyType, ObjectType> *)KST_dictionaryByAddingDictionaryEntries:(NSDictionary<KeyType, ObjectType> *)dictionary;

@end

NS_ASSUME_NONNULL_END
