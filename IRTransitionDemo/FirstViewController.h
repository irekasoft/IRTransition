//
//  FirstViewController.h
//  IRTransitionDemo
//
//  Created by Hijazi on 11/4/15.
//  Copyright (c) 2015 iReka Soft. All rights reserved.
//

#import "IRZoomTransition.h"
#import "PopupDynamicVC.h"
#import "SecondVC.h"
#import "IRAnimationController.h"
#import "IRCardAnimationController.h"

#import <UIKit/UIKit.h>

@interface FirstViewController : UIViewController <UIViewControllerTransitioningDelegate>

@property (nonatomic, strong) PopupDynamicVC *popupDynamic;

@property (strong, nonatomic) IRAnimationController *animationController;


@end

