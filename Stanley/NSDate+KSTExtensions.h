//
//  NSDate+KSTExtensions.h
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

@interface NSDate (KSTExtensions)

/**
 Returns the day component from a NSDateComponents created from the receiver.
 
 @return The day of the receiver
 */
- (NSInteger)KST_day;
/**
 Returns the month component from a NSDateComponents created from the receiver.
 
 @return The month of the receiver
 */
- (NSInteger)KST_month;
/**
 Returns the year component from a NSDateComponents created from the receiver.
 
 @return The year of the receiver
 */
- (NSInteger)KST_year;

/**
 Returns a NSDate representing the beginning of the day, which is 12:00:00 AM.
 
 @return The beginning of the day date
 */
- (NSDate *)KST_beginningOfDay;
/**
 Returns a NSDate representing the end of the day, which is 11:59:59 PM.
 
 @return The end of the day date
 */
- (NSDate *)KST_endOfDay;

@end

NS_ASSUME_NONNULL_END
