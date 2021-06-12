//
//  NSDate+KSTExtensions.m
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

#import "NSDate+KSTExtensions.h"

@implementation NSDate (KSTExtensions)

- (NSInteger)KST_day; {
    NSDateComponents *comps = [[NSCalendar currentCalendar] components:NSCalendarUnitDay fromDate:self];
    
    return comps.day;
}
- (NSInteger)KST_month; {
    NSDateComponents *comps = [[NSCalendar currentCalendar] components:NSCalendarUnitMonth fromDate:self];
    
    return comps.month;
}
- (NSInteger)KST_year; {
    NSDateComponents *comps = [[NSCalendar currentCalendar] components:NSCalendarUnitYear fromDate:self];
    
    return comps.year;
}

- (NSDate *)KST_beginningOfDay; {
    NSDateComponents *comps = [[NSCalendar currentCalendar] components:NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay fromDate:self];
    NSDate *retval = [[NSCalendar currentCalendar] dateFromComponents:comps];
    
    return retval;
}
- (NSDate *)KST_endOfDay; {
    NSDateComponents *comps = [[NSDateComponents alloc] init];
    
    [comps setDay:1];
    
    NSDate *retval = [[[NSCalendar currentCalendar] dateByAddingComponents:comps toDate:[self KST_beginningOfDay] options:0] dateByAddingTimeInterval:-1.0];
    
    return retval;
}

@end
