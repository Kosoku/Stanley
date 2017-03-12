//
//  KSTGeometryFunctions.h
//  Stanley
//
//  Created by William Towe on 3/7/17.
//  Copyright (c) 2017 Kosoku Interactive, LLC. All rights reserved.
//
//  Redistribution and use in source and binary forms, with or without modification, are permitted provided that the following conditions are met:
//
//  1. Redistributions of source code must retain the above copyright notice, this list of conditions and the following disclaimer.
//
//  2. Redistributions in binary form must reproduce the above copyright notice, this list of conditions and the following disclaimer in the documentation and/or other materials provided with the distribution.
//
//  THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.

#import <TargetConditionals.h>

#import <Foundation/Foundation.h>
#import <CoreGraphics/CGGeometry.h>

NS_ASSUME_NONNULL_BEGIN

/**
 Creates and returns a `CGRect` by centering *rect_to_center* within *in_rect*.
 
 @param rect_to_center The rectangle to center
 @param in_rect The bounding rectangle
 @return The centered rect
 */
FOUNDATION_EXPORT CGRect KSTCGRectCenterInRect(CGRect rect_to_center, CGRect in_rect);
/**
 Calls KSTCGRectCenterInRect() and restores the resulting rectangle origin.y to its original value. This centers the rectangle horizontally.
 
 @param rect_to_center The rectangle to center
 @param in_rect The bounding rectangle
 @return The centered rectangle
 */
FOUNDATION_EXPORT CGRect KSTCGRectCenterInRectHorizontally(CGRect rect_to_center, CGRect in_rect);
/**
 Calls KSTCGRectCenterInRect() and restores the resulting rectangle origin.x to its original value. This centers the rectangle vertically.
 
 @param rect_to_center The rectangle to center
 @param in_rect The bounding rectangle
 @return The centered rectangle
 */
FOUNDATION_EXPORT CGRect KSTCGRectCenterInRectVertically(CGRect rect_to_center, CGRect in_rect);

#if (TARGET_OS_OSX)
/**
 Creates and returns a `NSRect` by centering *rect_to_center* within *in_rect*.
 
 @param rect_to_center The rectangle to center
 @param in_rect The bounding rectangle
 @return The centered rect
 */
FOUNDATION_EXPORT NSRect KSTNSRectCenterInRect(NSRect rect_to_center, NSRect in_rect);
/**
 Calls KSTNSRectCenterInRect() and restores the resulting rectangle origin.y to its original value. This centers the rectangle horizontally.
 
 @param rect_to_center The rectangle to center
 @param in_rect The bounding rectangle
 @return The centered rectangle
 */
FOUNDATION_EXPORT NSRect KSTNSRectCenterInRectHorizontally(NSRect rect_to_center, NSRect in_rect);
/**
 Calls KSTNSRectCenterInRect() and restores the resulting rectangle origin.x to its original value. This centers the rectangle vertically.
 
 @param rect_to_center The rectangle to center
 @param in_rect The bounding rectangle
 @return The centered rectangle
 */
FOUNDATION_EXPORT NSRect KSTNSRectCenterInRectVertically(NSRect rect_to_center, NSRect in_rect);
#endif

NS_ASSUME_NONNULL_END
