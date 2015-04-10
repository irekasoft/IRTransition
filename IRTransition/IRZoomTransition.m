//
//  ZoomTransition.m
//  Sirah25Rasul
//
//  Created by Muhammad Hijazi  on 12/11/13.
//  Copyright (c) 2013 iReka Soft. All rights reserved.
//

#import "ZoomTransition.h"

@implementation ZoomTransition

- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext {
    return 0.25;
}

- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext {
    
    if(self.isPresenting){
        [self executePresentationAnimation:transitionContext];
    }
    else{
        [self executeDismissalAnimation:transitionContext];
    }
}

-(void)executePresentationAnimation:(id<UIViewControllerContextTransitioning>)transitionContext{
    UIViewController *fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    
    UIViewController *toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
   
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

-(void)executeDismissalAnimation:(id<UIViewControllerContextTransitioning>)transitionContext{
    
    UIView *inView = [transitionContext containerView];
    
    UIViewController *fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    
    UIViewController *toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    
    
    [inView insertSubview:toVC.view belowSubview:fromVC.view];
    
    
    NSTimeInterval interval = [self transitionDuration:transitionContext];
    
    [UIView animateWithDuration:interval animations:^{

        fromVC.view.transform = CGAffineTransformMakeScale(0.01,0.01);

    } completion:^(BOOL finished) {
        
        [transitionContext completeTransition:YES];
    }];
}

@end
