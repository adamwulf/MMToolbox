//
//  UIView+Animations.h
//  ShapeShifter
//
//  Created by Adam Wulf on 6/13/14.
//  Copyright (c) 2014 Milestone Made, LLC. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface UIView (AnchorPoint)

// changes the anchor point for the input view
// without moving the image on screen. The position
// of the view will also be changed so that the view
// remains visually in the same place
+ (void)setAnchorPoint:(CGPoint)anchorPoint forView:(UIView *)view;

@property(nonatomic, assign) CGPoint anchorPoint;

@end
