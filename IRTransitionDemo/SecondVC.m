//
//  SecondVC.m
//  DynamicToss
//
//  Created by Hijazi on 10/4/15.
//  Copyright (c) 2015 iReka Soft. All rights reserved.
//

#import "SecondVC.h"

@interface SecondVC ()

@end

@implementation SecondVC
- (UIStatusBarStyle)preferredStatusBarStyle{
    return UIStatusBarStyleLightContent;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
- (IBAction)close:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (IBAction)panHandler:(UIPanGestureRecognizer *)gesture {

// todo: move uiview
//    CGPoint location = [gesture locationInView:self.view];
//    NSLog(@"you touch started position %@",NSStringFromCGPoint(location));
//    CGPoint startPoint = CGPointMake(0, 0);
//    
//    switch (gesture.state) {
//        case UIGestureRecognizerStateBegan:{
//            startPoint = location;
//            break;
//        }
//        case UIGestureRecognizerStateChanged:{
//            
//            self.view.transform = CGAffineTransformMakeTranslation(0, startPoint.y - location.y);
//            
////            NSLog(@"you touch started position %f",location.y + startPoint.y);
//            break;
//        }
//        case UIGestureRecognizerStateEnded: {
//            
//            self.view.transform = CGAffineTransformIdentity;
//            break;
//            
//        }
//        default:{
//            
//            break;
//        }
//            
//    }

            



}

@end
