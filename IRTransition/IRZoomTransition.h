//
//  ZoomTransition.h
//  Sirah25Rasul
//
//  Created by Muhammad Hijazi  on 12/11/13.
//  Copyright (c) 2013 iReka Soft. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZoomTransition : NSObject <UIViewControllerAnimatedTransitioning>

@property BOOL isPresenting;

@end

@interface ZoomTransitionContext : NSObject <UIViewControllerContextTransitioning>

@end
