//
//  ZoomTransition.m
//
//  Created by Muhammad Hijazi  on 12/11/13.
//  Copyright (c) 2013 iReka Soft. All rights reserved.
//

#import "IRZoomTransition.h"

@implementation IRZoomTransition



- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext fromVC:(UIViewController *)fromVC toVC:(UIViewController *)toVC fromView:(UIView *)fromView toView:(UIView *)toView {
    
    if(self.reverse){
        [self executeReverseAnimation:transitionContext fromVC:fromVC toVC:toVC fromView:fromView toView:toView];
    } else {
        [self executeForwardsAnimation:transitionContext fromVC:fromVC toVC:toVC fromView:fromView toView:toView];
    }
    
}


-(void)executeForwardsAnimation:(id<UIViewControllerContextTransitioning>)transitionContext fromVC:(UIViewController *)fromVC toVC:(UIViewController *)toVC fromView:(UIView *)fromView toView:(UIView *)toView {
    
    
    fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    CGRect frame = [transitionContext initialFrameForViewController:fromVC];
    fromVC.view.frame = frame;
    toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    toVC.view.frame = frame;
    
    [transitionContext.containerView addSubview:fromVC.view];
    [transitionContext.containerView addSubview:toVC.view];
    
    NSTimeInterval interval = [self transitionDuration:transitionContext];

    toVC.view.transform = CGAffineTransformMakeScale(0.2, 0.2);

    [UIView animateWithDuration:interval animations:^{
        toVC.view.transform = CGAffineTransformIdentity;

    } completion:^(BOOL finished) {
        [transitionContext completeTransition:YES];
    }];
}

-(void)executeReverseAnimation:(id<UIViewControllerContextTransitioning>)transitionContext fromVC:(UIViewController *)fromVC toVC:(UIViewController *)toVC fromView:(UIView *)fromView toView:(UIView *)toView {
    
    UIView *inView = [transitionContext containerView];
    
    fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    
    toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    
    
    [inView insertSubview:toVC.view belowSubview:fromVC.view];
    
    
    NSTimeInterval interval = [self transitionDuration:transitionContext];
    
    [UIView animateWithDuration:interval animations:^{

        fromVC.view.transform = CGAffineTransformMakeScale(0.01,0.01);

    } completion:^(BOOL finished) {
        
        [transitionContext completeTransition:YES];
    }];
}

@end
