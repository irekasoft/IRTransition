# IRTransition

UIViewController custom modal transition.

* IRRevealAnimationController
* IRMoveAnimationController
* IRZoomTransition
* IRCardAnimationController

---------------

Method:

- copy IRTransition folder. or for specific animation, copy the name '.. AnimationController' + 'IRAnimationController'. 

- add at first vc

`@property (strong, nonatomic) IRAnimationController *animationController;`

- when action

`
SecondVC *vc = [[SecondVC alloc] init];
vc.transitioningDelegate = self;
self.animationController = [[IRZoomTransition alloc] init];
[self presentViewController:vc animated:YES completion:nil];

`

- declare delegate 

`
<UIViewControllerTransitioningDelegate>
`



- add this delegate 

`
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
`

---------------

Developed by iReka Soft in Cyberjaya (www.irekasoft.com)