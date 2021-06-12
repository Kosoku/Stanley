//
//  KSTGeometryFunctions.m
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

#import "KSTGeometryFunctions.h"

CGSize KSTCGSizeIntegral(CGSize size) {
    return CGSizeMake(ceil(size.width), ceil(size.height));
}

CGRect KSTCGRectCenterInRect(CGRect rect_to_center, CGRect in_rect) {
    return CGRectMake(floor(CGRectGetMinX(in_rect) + (CGRectGetWidth(in_rect) * 0.5) - (CGRectGetWidth(rect_to_center) * 0.5)),
                      floor(CGRectGetMinY(in_rect) + (CGRectGetHeight(in_rect) * 0.5) - (CGRectGetHeight(rect_to_center) * 0.5)),
                      CGRectGetWidth(rect_to_center),
                      CGRectGetHeight(rect_to_center));
}
CGRect KSTCGRectCenterInRectHorizontally(CGRect rect_to_center, CGRect in_rect) {
    CGRect new_rect = KSTCGRectCenterInRect(rect_to_center, in_rect);
    
    new_rect.origin.y = rect_to_center.origin.y;
    
    return new_rect;
}
CGRect KSTCGRectCenterInRectVertically(CGRect rect_to_center, CGRect in_rect) {
    CGRect new_rect = KSTCGRectCenterInRect(rect_to_center, in_rect);
    
    new_rect.origin.x = rect_to_center.origin.x;
    
    return new_rect;
}

#if (TARGET_OS_OSX)
NSSize KSTNSSizeIntegral(NSSize size) {
    return NSMakeSize(ceil(size.width), ceil(size.height));
}

NSRect KSTNSRectCenterInRect(NSRect rect_to_center, NSRect in_rect) {
    return NSMakeRect(floor(NSMinX(in_rect) + (NSWidth(in_rect) * 0.5) - (NSWidth(rect_to_center) * 0.5)),
                      floor(NSMinY(in_rect) + (NSHeight(in_rect) * 0.5) - (NSHeight(rect_to_center) * 0.5)),
                      NSWidth(rect_to_center),
                      NSHeight(rect_to_center));
}
NSRect KSTNSRectCenterInRectHorizontally(NSRect rect_to_center, NSRect in_rect) {
    NSRect new_rect = KSTNSRectCenterInRect(rect_to_center, in_rect);
    
    new_rect.origin.y = rect_to_center.origin.y;
    
    return new_rect;
}
NSRect KSTNSRectCenterInRectVertically(NSRect rect_to_center, NSRect in_rect) {
    NSRect new_rect = KSTNSRectCenterInRect(rect_to_center, in_rect);
    
    new_rect.origin.x = rect_to_center.origin.x;
    
    return new_rect;
}
#endif
