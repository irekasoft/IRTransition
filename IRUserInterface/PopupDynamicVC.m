//
//  PopupDynamicVC.m
//  DynamicToss
//
//  Created by Hijazi on 16/3/15.
//  Copyright (c) 2015 iReka Soft. All rights reserved.
//

#import "PopupDynamicVC.h"

@interface PopupDynamicVC ()

@end

@implementation PopupDynamicVC
- (IBAction)dismiss:(id)sender {
    NSLog(@"%s",__PRETTY_FUNCTION__);

    [self dismiss];
}

- (void)show
{
    UIWindow* window = [[UIApplication sharedApplication] keyWindow];
    
//    if ([[UIDevice currentDevice].systemVersion integerValue] >= 8)
//    {
//        //For iOS 8
//        self.providesPresentationContextTransitionStyle = YES;
//        self.definesPresentationContext = YES;
//        self.modalPresentationStyle = UIModalPresentationOverCurrentContext;
//    }
//    else
//    {
//        //For iOS 7
//        self.modalPresentationStyle = UIModalPresentationCurrentContext;
//    }
    
    
    self.transitioningDelegate = self;
    self.modalPresentationStyle = UIModalPresentationCustom;
    
    self.view.backgroundColor = [UIColor colorWithWhite:0 alpha:0.7f];
    
    [window.rootViewController presentViewController:self animated:NO completion:nil];
    
    
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Do any additional setup after loading the view, typically from a nib.
    self.animator = [[UIDynamicAnimator alloc] initWithReferenceView:self.view];
    self.view_message.layer.cornerRadius = 5;
    
    
}


- (void)viewWillLayoutSubviews{
    [super viewWillLayoutSubviews];
    
    self.view_message.center = CGPointMake(self.view.frame.size.width/2, self.view.frame.size.height/2);
    self.view_message.hidden = YES;
    self.originalBounds = self.view_message.bounds;
    self.originalCenter = self.view_message.center;
}

// Radians to degree
#define RADIANS_TO_DEGREES(radians) ((radians) * (180.0 / M_PI))
// Degrees to radians
#define DEGREES_TO_RADIANS(angle) ((angle) / 180.0 * M_PI)

// setup the view when first appear
- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    self.view_message.hidden = NO;
    CGFloat random = 1+arc4random()%4;
    self.view_message.center = CGPointMake(self.view.frame.size.width/random, -200);
    CGFloat angle = arc4random()%360;
    angle = DEGREES_TO_RADIANS(angle);
    self.view_message.transform = CGAffineTransformMakeRotation(angle);
    
    [UIView animateWithDuration:1.45 delay:0 usingSpringWithDamping:0.7 initialSpringVelocity:1.2 options:0 animations:^{
        
        self.view_message.bounds = self.originalBounds;
        self.view_message.center = self.originalCenter;
        self.view_message.transform = CGAffineTransformIdentity;
        
    } completion:nil];
    
}


#pragma mark - UIViewControllerTransitioningDelegate

-(NSTimeInterval) transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext
{
    return 0.35;
}

-(void) animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext
{
    NSLog(@"iii");

}

static const CGFloat ThrowingThreshold = 1000;
static const CGFloat ThrowingVelocityPadding = 35;

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)tapHandler:(UITapGestureRecognizer *)sender {
    
//    [self dismiss];
    
}

- (IBAction)handlePanGesture:(UIPanGestureRecognizer *)gesture {
    
    CGPoint location = [gesture locationInView:self.view];
    CGPoint boxLocation = [gesture locationInView:self.view_message];
    
    switch (gesture.state) {
        case UIGestureRecognizerStateBegan:{
            NSLog(@"you touch started position %@",NSStringFromCGPoint(location));
            NSLog(@"location in image started is %@",NSStringFromCGPoint(boxLocation));
            
            // 1
            [self.animator removeAllBehaviors];
            
            // 2
            UIOffset centerOffset = UIOffsetMake(boxLocation.x - CGRectGetMidX(self.view_message.bounds),
                                                 boxLocation.y - CGRectGetMidY(self.view_message.bounds));
            self.attachmentBehavior = [[UIAttachmentBehavior alloc] initWithItem:self.view_message
                                                                offsetFromCenter:centerOffset
                                                                attachedToAnchor:location];
            // 3
//            self.redSquare.center = self.attachmentBehavior.anchorPoint;
//            self.blueSquare.center = location;
            
            // 4
            [self.animator addBehavior:self.attachmentBehavior];
            
            break;
        }
        case UIGestureRecognizerStateEnded: {
            [self.animator removeBehavior:self.attachmentBehavior];
            
            //1
            CGPoint velocity = [gesture velocityInView:self.view];
            CGFloat magnitude = sqrtf((velocity.x * velocity.x) + (velocity.y * velocity.y));
            
            if (magnitude > ThrowingThreshold) {
                //2
                UIPushBehavior *pushBehavior = [[UIPushBehavior alloc]
                                                initWithItems:@[self.view_message]
                                                mode:UIPushBehaviorModeInstantaneous];
                pushBehavior.pushDirection = CGVectorMake((velocity.x / 2) , (velocity.y / 2));
                pushBehavior.magnitude = magnitude / ThrowingVelocityPadding;
                
                self.pushBehavior = pushBehavior;
                [self.animator addBehavior:self.pushBehavior];
                
                //3
                NSInteger angle = 1.2;// arc4random_uniform(20) - 10;
                
                self.itemBehavior = [[UIDynamicItemBehavior alloc] initWithItems:@[self.view_message]];
                self.itemBehavior.friction = 0.2;
                self.itemBehavior.allowsRotation = YES;
                [self.itemBehavior addAngularVelocity:angle forItem:self.view_message];
                [self.animator addBehavior:self.itemBehavior];
                
                //4
                [self performSelector:@selector(dismiss) withObject:nil afterDelay:0.4];
            }
            
            else {
                [self resetDemo];
            }
            
            break;
        }
        default:
            
            [self.attachmentBehavior setAnchorPoint:[gesture locationInView:self.view]];
            self.redSquare.center = self.attachmentBehavior.anchorPoint;
            
            
            break;
    }
    
}

- (void)dismiss{
    self.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    [self dismissViewControllerAnimated:YES completion:nil];
    
}
- (IBAction)close:(id)sender {
    [self dismiss];
}

- (void)resetDemo
{
    [self.animator removeAllBehaviors];
    
    
    [UIView animateWithDuration:1.5 delay:0 usingSpringWithDamping:0.7 initialSpringVelocity:1.2 options:0 animations:^{
        
        
        self.view_message.bounds = self.originalBounds;
        self.view_message.center = self.originalCenter;
        self.view_message.transform = CGAffineTransformIdentity;
        
    } completion:nil];
    
}

@end
