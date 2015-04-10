//
//  IRAnimationController.h
//  IRTransitionDemo
//
//  Created by Hijazi on 11/4/15.
//  Copyright (c) 2015 iReka Soft. All rights reserved.
//

// based from https://github.com/ColinEberhardt/VCTransitionsLibrary
//
//

#import <UIKit/UIKit.h>

@interface IRAnimationController : NSObject <UIViewControllerAnimatedTransitioning>



@property (nonatomic, assign) BOOL reverse;
@property (nonatomic, assign) NSTimeInterval duration;

- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext fromVC:(UIViewController *)fromVC toVC:(UIViewController *)toVC fromView:(UIView *)fromView toView:(UIView *)toView;

@end
