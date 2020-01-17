//
//  NSThread+BlockAdditions.h
//  Loose Leaf
//
//  Created by Adam Wulf on 9/7/12.
//  Copyright (c) 2012 Milestone Made, LLC. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface NSThread (BlockAdditions)

+ (CGFloat)timeBlock:(void (^)(void))block;

- (void)performBlock:(void (^)(void))block;
- (void)performBlock:(void (^)(void))block waitUntilDone:(BOOL)wait;
+ (void)performBlockInBackground:(void (^)(void))block;
+ (void)performBlockOnMainThread:(void (^)(void))block;
+ (void)performBlockOnMainThreadSync:(void (^)(void))block;
- (void)performBlock:(void (^)(void))block afterDelay:(NSTimeInterval)delay;
@end
