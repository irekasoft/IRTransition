//
//  FirstViewController.m
//  IRTransitionDemo
//
//  Created by Hijazi on 11/4/15.
//  Copyright (c) 2015 iReka Soft. All rights reserved.
//

#import "FirstViewController.h"

@interface FirstViewController ()


@property (nonatomic, getter = isDismissable) BOOL dismissable;
@property (nonatomic, assign) NSInteger selectedAlignementOption;

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

#pragma mark - view popping

- (IBAction)viewPopping:(id)sender {
    
    TestPopinViewController *popin = [[TestPopinViewController alloc] init];
    [popin setPopinTransitionStyle:IRPopinTransitionStyleSlide];

    if ([self isDismissable]) {
        [popin setPopinOptions:IRPopinDefault];
    } else {
        [popin setPopinOptions:IRPopinDisableAutoDismiss];
    }
    
    //Set popin alignement according to value in segmented control
    [popin setPopinAlignment:self.selectedAlignementOption];
    
    
    
    //Create a blur parameters object to configure background blur
    IRBlurParameters *blurParameters = [IRBlurParameters new];
    blurParameters.alpha = 1.0f;
    blurParameters.radius = 8.0f;
    blurParameters.saturationDeltaFactor = 1.8f;
    blurParameters.tintColor = [[UIColor whiteColor] colorWithAlphaComponent:0.2];
    [popin setBlurParameters:blurParameters];
    
    //Add option for a blurry background
    [popin setPopinOptions:[popin popinOptions]|IRPopinBlurryDimmingView];
    
    //Define a custom transition style
    if (popin.popinTransitionStyle == IRPopinTransitionStyleCustom)
    {
        [popin setPopinCustomInAnimation:^(UIViewController *popinController, CGRect initialFrame, CGRect finalFrame) {
            
            popinController.view.frame = finalFrame;
            popinController.view.transform = CGAffineTransformMakeRotation(M_PI_4 / 2);
            
        }];
        
        [popin setPopinCustomOutAnimation:^(UIViewController *popinController, CGRect initialFrame, CGRect finalFrame) {
            
            popinController.view.frame = finalFrame;
            popinController.view.transform = CGAffineTransformMakeRotation(M_PI_2);
            
        }];
    }
    
    [popin setPreferedPopinContentSize:CGSizeMake(300.0, 240.0)];
    
    //Set popin transition direction
    [popin setPopinTransitionDirection:IRPopinTransitionDirectionTop];
    [self presentPopinController:popin animated:YES completion:^{
        NSLog(@"Popin presented !");
    }];
    
}


- (IBAction)popUpDynamic:(id)sender {
    self.popupDynamic = [[PopupDynamicVC alloc] init];
    [self.popupDynamic show];
    
}

- (IBAction)portalTransition:(id)sender {

    SecondVC *vc = [[SecondVC alloc] init];
    vc.transitioningDelegate = self;
    self.animationController = [[IRPortalAnimationController alloc] init];
    [self presentViewController:vc animated:YES completion:nil];
    
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
