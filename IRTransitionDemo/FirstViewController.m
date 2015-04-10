//
//  FirstViewController.m
//  IRTransitionDemo
//
//  Created by Hijazi on 11/4/15.
//  Copyright (c) 2015 iReka Soft. All rights reserved.
//

#import "FirstViewController.h"

@interface FirstViewController ()

@end

@implementation FirstViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)popUpDynamic:(id)sender {
    self.popupDynamic = [[PopupDynamicVC alloc] init];
    [self.popupDynamic show];
    
}


- (IBAction)openVC:(id)sender {
    SecondVC *vc = [[SecondVC alloc] init];
    vc.transitioningDelegate = self;
    self.animationController = [[IRZoomTransition alloc] init];
    [self presentViewController:vc animated:YES completion:nil];
    
}

- (IBAction)cardTransition:(id)sender {
    
    SecondVC *vc = [[SecondVC alloc] init];
    vc.transitioningDelegate = self;
    self.animationController = [[IRCardAnimationController alloc] init];
    [self presentViewController:vc animated:YES completion:nil];
    
}

- (IBAction)moveTransition:(id)sender {
    
    SecondVC *vc = [[SecondVC alloc] init];
    vc.transitioningDelegate = self;
    IRMoveAnimationController *moveController = [[IRMoveAnimationController alloc] init];
    moveController.movementType = IRMoveFromTop;
    self.animationController = moveController;
    [self presentViewController:vc animated:YES completion:nil];
    
    
}
- (IBAction)revealTransition:(id)sender {
    
    SecondVC *vc = [[SecondVC alloc] init];
    vc.transitioningDelegate = self;
    IRRevealAnimationController *moveController = [[IRRevealAnimationController alloc] init];
    moveController.revealType = IRRevealToLeft;
    self.animationController = moveController;
    [self presentViewController:vc animated:YES completion:nil];
    
    
}

#pragma mark - UIViewControllerTransitioningDelegate
- (id <UIViewControllerAnimatedTransitioning>) animationControllerForPresentedController:(UIViewController *)presented
                                                                    presentingController:(UIViewController *)presenting
                                                                        sourceController:(UIViewController *)source
{
    
    self.animationController.reverse = NO;
    return self.animationController;
}

- (id <UIViewControllerAnimatedTransitioning>) animationControllerForDismissedController:(UIViewController *)dismissed {
    
    self.animationController.reverse = YES;
    return self.animationController;
}


@end
