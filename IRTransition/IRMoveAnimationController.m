//
//  IRMoveAnimationController.m
//  IRTransitionDemo
//
//  Created by Hijazi on 11/4/15.
//  Copyright (c) 2015 iReka Soft. All rights reserved.
//

#import "IRMoveAnimationController.h"

@implementation IRMoveAnimationController

-(void)executePresentationAnimation:(id<UIViewControllerContextTransitioning>)transitionContext{
    
    UIView* inView = [transitionContext containerView];
    
    UIViewController* toViewController = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    
    [inView addSubview:toViewController.view];
    
    CGPoint centerOffScreen = inView.center;
    
    //    centerOffScreen.y = (2)*inView.frame.size.height;
    
    if (self.movementType == IRMoveFromRight) {
        centerOffScreen.x = (2)*inView.frame.size.width;
        
    }else if (self.movementType == IRMoveFromLeft) {
        centerOffScreen.x = -(2)*inView.frame.size.width;

    }else if (self.movementType == IRMoveFromTop) {
        centerOffScreen.y = -(2)*inView.frame.size.height;

    }else if (self.movementType == IRMoveFromBottom) {
        centerOffScreen.y = (2)*inView.frame.size.height;

    }
    
    
    toViewController.view.center = centerOffScreen;
    [UIView animateWithDuration:self.duration delay:0.0f usingSpringWithDamping:1.2f initialSpringVelocity:10.0f options:UIViewAnimationOptionCurveEaseIn animations:^{
        
        toViewController.view.center = inView.center;
        
    } completion:^(BOOL finished) {
        
        [transitionContext completeTransition:YES];
    }];
    
}

-(void)executeDismissalAnimation:(id<UIViewControllerContextTransitioning>)transitionContext{
    
    UIView* inView = [transitionContext containerView];
    
    UIViewController* toViewController = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    
    UIViewController* fromViewController = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    
    [inView insertSubview:toViewController.view belowSubview:fromViewController.view];
    
    CGPoint centerOffScreen = inView.center;
    //    centerOffScreen.y = (2)*inView.frame.size.height;
    
    if (self.movementType == IRMoveFromRight) {
        centerOffScreen.x = (2)*inView.frame.size.width;
    }else if (self.movementType == IRMoveFromLeft) {
        centerOffScreen.x = -(2)*inView.frame.size.width;
    }else if (self.movementType == IRMoveFromTop) {
        centerOffScreen.y = -(2)*inView.frame.size.height;
        
    }else if (self.movementType == IRMoveFromBottom) {
        centerOffScreen.y = (2)*inView.frame.size.height;
        
    }
    
    
    
    
    
    [UIView animateWithDuration:self.duration delay:0.0f usingSpringWithDamping:0.4f initialSpringVelocity:6.0f options:UIViewAnimationOptionCurveEaseIn animations:^{
        
        fromViewController.view.center = centerOffScreen;
        
    } completion:^(BOOL finished) {
        
        [transitionContext completeTransition:YES];
    }];
    
    
    
}

- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext {
    
    if(!self.reverse){
        [self executePresentationAnimation:transitionContext];
    }
    else{
        [self executeDismissalAnimation:transitionContext];
    }
    
    
}

@end
