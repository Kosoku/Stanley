//
//  KSTGeometryFunctions.h
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

#import <TargetConditionals.h>

#import <Foundation/Foundation.h>
#import <CoreGraphics/CGGeometry.h>

NS_ASSUME_NONNULL_BEGIN

/**
 Returns a new CGSize by rounding both the width and height of the original using the ceil function.
 
 For example, KSTCGSizeIntegral(CGSizeMake(1.5, 2.1)) would return CGSizeMake(2, 3).
 
 @param size The size to round using ceil
 @return The new size
 */
FOUNDATION_EXTERN CGSize KSTCGSizeIntegral(CGSize size);

/**
 Creates and returns a `CGRect` by centering *rect_to_center* within *in_rect*.
 
 @param rect_to_center The rectangle to center
 @param in_rect The bounding rectangle
 @return The centered rect
 */
FOUNDATION_EXTERN CGRect KSTCGRectCenterInRect(CGRect rect_to_center, CGRect in_rect);
/**
 Calls KSTCGRectCenterInRect() and restores the resulting rectangle origin.y to its original value. This centers the rectangle horizontally.
 
 @param rect_to_center The rectangle to center
 @param in_rect The bounding rectangle
 @return The centered rectangle
 */
FOUNDATION_EXTERN CGRect KSTCGRectCenterInRectHorizontally(CGRect rect_to_center, CGRect in_rect);
/**
 Calls KSTCGRectCenterInRect() and restores the resulting rectangle origin.x to its original value. This centers the rectangle vertically.
 
 @param rect_to_center The rectangle to center
 @param in_rect The bounding rectangle
 @return The centered rectangle
 */
FOUNDATION_EXTERN CGRect KSTCGRectCenterInRectVertically(CGRect rect_to_center, CGRect in_rect);

#if (TARGET_OS_OSX)
/**
 Returns a new NSSize by rounding both the width and height of the original using the ceil function.
 
 For example, KSTNSSizeIntegral(NSMakeSize(1.5, 2.1)) would return NSMakeSize(2, 3).
 
 @param size The size to round using ceil
 @return The new size
 */
FOUNDATION_EXTERN NSSize KSTNSSizeIntegral(NSSize size);

/**
 Creates and returns a `NSRect` by centering *rect_to_center* within *in_rect*.
 
 @param rect_to_center The rectangle to center
 @param in_rect The bounding rectangle
 @return The centered rect
 */
FOUNDATION_EXTERN NSRect KSTNSRectCenterInRect(NSRect rect_to_center, NSRect in_rect);
/**
 Calls KSTNSRectCenterInRect() and restores the resulting rectangle origin.y to its original value. This centers the rectangle horizontally.
 
 @param rect_to_center The rectangle to center
 @param in_rect The bounding rectangle
 @return The centered rectangle
 */
FOUNDATION_EXTERN NSRect KSTNSRectCenterInRectHorizontally(NSRect rect_to_center, NSRect in_rect);
/**
 Calls KSTNSRectCenterInRect() and restores the resulting rectangle origin.x to its original value. This centers the rectangle vertically.
 
 @param rect_to_center The rectangle to center
 @param in_rect The bounding rectangle
 @return The centered rectangle
 */
FOUNDATION_EXTERN NSRect KSTNSRectCenterInRectVertically(NSRect rect_to_center, NSRect in_rect);
#endif

NS_ASSUME_NONNULL_END
