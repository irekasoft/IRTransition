//
//  IRRevealAnimationController.m
//  IRTransitionDemo
//
//  Created by Hijazi on 11/4/15.
//  Copyright (c) 2015 iReka Soft. All rights reserved.
//

#import "IRRevealAnimationController.h"

@implementation IRRevealAnimationController
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

    toVC.view.frame = frame;// important to make frame layout updated.
    
    [inView insertSubview:toView belowSubview:fromView];
   
    
    CGPoint centerOffScreen = CGPointZero;
    
    if (self.revealType == IRRevealToRight) {
        centerOffScreen.x = (2)*inView.frame.size.width;
        
    }else if (self.revealType == IRRevealToLeft) {
        centerOffScreen.x = -(2)*inView.frame.size.width;
        
    }else if (self.revealType == IRRevealToTop) {
        centerOffScreen.y = -2.0*inView.frame.size.height;
        
    }else if (self.revealType == IRRevealToBottom) {
        centerOffScreen.y = (2)*inView.frame.size.height;
        
    }
    
    
    [UIView animateWithDuration:self.duration delay:0.0f usingSpringWithDamping:1.0f initialSpringVelocity:1.0f options:UIViewAnimationOptionCurveEaseIn animations:^{
        
        fromVC.view.transform = CGAffineTransformMakeTranslation(centerOffScreen.x, centerOffScreen.y);
        
        
    } completion:^(BOOL finished) {
        
        [transitionContext completeTransition:YES];
    }];
    
}

-(void)executeReverseAnimation:(id<UIViewControllerContextTransitioning>)transitionContext fromVC:(UIViewController *)fromVC toVC:(UIViewController *)toVC fromView:(UIView *)fromView toView:(UIView *)toView {
    
    UIView* inView = [transitionContext containerView];
    
    toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    [inView addSubview:toVC.view];
    
    CGPoint centerOffScreen = inView.center;
    toVC.view.center = centerOffScreen;
    
   

    [UIView animateWithDuration:self.duration delay:0.0f usingSpringWithDamping:1.2f initialSpringVelocity:1.5f options:UIViewAnimationOptionCurveEaseIn animations:^{
        
        toVC.view.transform = CGAffineTransformIdentity;
        
    } completion:^(BOOL finished) {
        
        [transitionContext completeTransition:YES];
    }];
    
    
    
}
@end
