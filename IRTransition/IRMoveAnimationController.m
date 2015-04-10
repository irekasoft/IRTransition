//
//  IRMoveAnimationController.m
//  IRTransitionDemo
//
//  Created by Hijazi on 11/4/15.
//  Copyright (c) 2015 iReka Soft. All rights reserved.
//

#import "IRMoveAnimationController.h"

@implementation IRMoveAnimationController

- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext fromVC:(UIViewController *)fromVC toVC:(UIViewController *)toVC fromView:(UIView *)fromView toView:(UIView *)toView {
    
    if(self.reverse){
        [self executeReverseAnimation:transitionContext fromVC:fromVC toVC:toVC fromView:fromView toView:toView];
    } else {
        [self executeForwardsAnimation:transitionContext fromVC:fromVC toVC:toVC fromView:fromView toView:toView];
    }
    
}

-(void)executeForwardsAnimation:(id<UIViewControllerContextTransitioning>)transitionContext fromVC:(UIViewController *)fromVC toVC:(UIViewController *)toVC fromView:(UIView *)fromView toView:(UIView *)toView {
    
    UIView* inView = [transitionContext containerView];
    CGRect frame = [transitionContext initialFrameForViewController:fromVC];
    toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    toVC.view.frame = frame;
    [inView addSubview:toVC.view];
    
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
    
    
    toVC.view.center = centerOffScreen;
    [UIView animateWithDuration:self.duration delay:0.0f usingSpringWithDamping:1.2f initialSpringVelocity:1.5f options:UIViewAnimationOptionCurveEaseIn animations:^{
        
        toVC.view.center = inView.center;
        
    } completion:^(BOOL finished) {
        
        [transitionContext completeTransition:YES];
    }];
    
}

-(void)executeReverseAnimation:(id<UIViewControllerContextTransitioning>)transitionContext fromVC:(UIViewController *)fromVC toVC:(UIViewController *)toVC fromView:(UIView *)fromView toView:(UIView *)toView {
    
    
    UIView* inView = [transitionContext containerView];

    fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    
    toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];

    [inView insertSubview:toVC.view belowSubview:fromVC.view];
    
    CGPoint centerOffScreen = CGPointZero;
    //    centerOffScreen.y = (2)*inView.frame.size.height;
    
    NSLog(@"string %@",NSStringFromCGRect(toVC.view.frame));
    
    if (self.movementType == IRMoveFromRight) {
        centerOffScreen.x = 2*toVC.view.frame.size.width;
    }else if (self.movementType == IRMoveFromLeft) {
        centerOffScreen.x = -2*toVC.view.frame.size.width;
    }else if (self.movementType == IRMoveFromTop) {
        centerOffScreen.y = -2*toVC.view.frame.size.height;
        
    }else if (self.movementType == IRMoveFromBottom) {
        centerOffScreen.y = 2*toVC.view.frame.size.height;
        
    }
    

    NSLog(@"string %@",NSStringFromCGPoint(centerOffScreen));

 
    
    
    [UIView animateWithDuration:self.duration delay:0.0f usingSpringWithDamping:1.0f initialSpringVelocity:1.0f options:UIViewAnimationOptionCurveEaseIn animations:^{
        
         fromVC.view.transform = CGAffineTransformMakeTranslation(centerOffScreen.x, centerOffScreen.y);
        
        
    } completion:^(BOOL finished) {
        
        [transitionContext completeTransition:YES];
    }];
    
    
    
}



@end
