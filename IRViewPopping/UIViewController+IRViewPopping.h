//
//  UIViewController+IRViewPopping.h
//  IRTransitionDemo
//
//  Created by Hijazi on 14/4/15.
//  Copyright (c) 2015 iReka Soft. All rights reserved.
//
//  This is based on MaryPopin

#import <UIKit/UIKit.h>



/**
 * Object to customize blurry background
 */
@interface IRBlurParameters : NSObject
/**
 *  Property to customize background view alpha.
 */
@property (assign, nonatomic) CGFloat alpha;
/**
 *  Property to customize background view blur radius.
 */
@property (assign, nonatomic) CGFloat radius;
/**
 *  Property to customize background view blur saturation factor.
 *  A value of 1.0 is neutral. Below it is desaturated and above it is more saturated.
 */
@property (assign, nonatomic) CGFloat saturationDeltaFactor;
/**
 *  Property to customize blur tint color. Default is clear color.
 */
@property (strong, nonatomic) UIColor *tintColor;

@end

/**
 *  Transition styles available when presenting popin view controllers.
 *  @since v1.0
 */
typedef NS_ENUM(NSInteger, IRPopinTransitionStyle) {
    /**
     *  When the view controller is presented, its view slide in the parent view controller and slide out on dismiss
     */
    IRPopinTransitionStyleSlide,
    /**
     *  When the view controller is presented, its view fade in and fade out on dismiss. Transition direction is ignored for this kind of transition.
     */
    IRPopinTransitionStyleCrossDissolve,
    /**
     *  When the view controller is presented, its view fade in with a zoom out effect and fade out with a zoom in effect on dismiss. Transition direction is ignored for this kind of transition.
     */
    IRPopinTransitionStyleZoom,
    /**
     *  When the view controller is presented, its view slide in with a bounce effect and slide out on dismiss.
     */
    IRPopinTransitionStyleSpringySlide,
    /**
     *  When the view controller is presented, its view zoom and fade in with a bounce effect. Transition direction is ignored for this kind of transition.
     */
    IRPopinTransitionStyleSpringyZoom,
    /**
     *  When the view controller is presented, its view has a undefined behavior.
     */
    //UIDynamics transition styles
    IRPopinTransitionStyleSnap,
    /**
     *  When the view controller is presented, its view has a custom animation.
     */
    IRPopinTransitionStyleCustom
};

/**
 *  Transition direction when presenting popins. Default is IRPopinTransitionDirectionBottom.
 *  @since v1.0
 */
typedef NS_ENUM(NSInteger, IRPopinTransitionDirection) {
    /**
     *  Presentation transition will start from the bottom of the parent view. Respectively, dismiss transition will end to the bottom of the parent view.
     */
    IRPopinTransitionDirectionBottom = 0,
    /**
     *  Presentation transition will start from the top of the parent view. Respectively, dismiss transition will end to the top of the parent view.
     */
    IRPopinTransitionDirectionTop,
    /**
     *  Presentation transition will start from the left of the parent view. Respectively, dismiss transition will end to the left of the parent view.
     */
    IRPopinTransitionDirectionLeft,
    /**
     *  Presentation transition will start from the right of the parent view. Respectively, dismiss transition will end to the right of the parent view.
     */
    IRPopinTransitionDirectionRight
};

/**
 *  Options to configure popin behavior to user related events. The following options are compoundables.
 *  @since v1.0
 */
typedef NS_OPTIONS(NSUInteger, IRPopinOption) {
    /**
     *  Default behaviour
     */
    IRPopinDefault = 0,
    /**
     *  Disable popin reaction to keyboard notifications
     */
    IRPopinIgnoreKeyboardNotification = 1 << 0,
    /**
     *  Disable auto dismiss when touching outside of the popin view
     */
    IRPopinDisableAutoDismiss = 1 << 1,
    /**
     *  Takes a screenshot of presenting view, blurs it and uses it as dimming view. Available only on ios 7.x.
     */
    IRPopinBlurryDimmingView = 1 << 2,
    /**
     *  Disable parallax effect on iOS7
     */
    IRPopinDisableParallaxEffect = 1 << 3,
    /**
     *  Set a background dimming view with a clear color. Default is a semi-transparent black background
     */
    IRPopinDimmingViewStyleNone = 1 << 16,
};

/**
 *  Options to quickly configure popin alignment in its container. Default is centered.
 *  @see -popinAlignement
 *  @since v1.3
 */
typedef NS_ENUM(NSInteger, IRPopinAlignementOption) {
    /**
     *  Popin will be centered in container
     */
    IRPopinAlignementOptionCentered = 0,
    /**
     *  Popin will be stuck to top in container
     */
    IRPopinAlignementOptionUp       = 1,
    /**
     *  Popin will be left-aligned in container
     */
    IRPopinAlignementOptionLeft     = 2,
    /**
     *  Default will be stuck to bottom in container
     */
    IRPopinAlignementOptionDown     = 3,
    /**
     *  Popin will be right-aligned in container
     */
    IRPopinAlignementOptionRight    = 4
};

/**
 * `MaryPopin` is a category allowing modal-like presentation of view controllers but with more configuration options.
 * Configuration options include popin size, transition style, transition direction, response to keyboard notifications and auto dismiss.
 * @since v1.0
 */

@interface UIViewController (IRViewPopping) <UIDynamicAnimatorDelegate>

///---------------------
/// @name Presentation and dismiss
///---------------------

/**
 *  Present a popin controller as a child of the receiver. By default the popin keep its size when presented. If it is bigger than parent controller, the popin is resized to fit inside its parent.
 *
 *  @param popinController The controller to present as a popin.
 *  @param animated        Pass `YES` to animate the presentation. Otherwise, pass `NO`.
 *  @param completion      A completion handler, or `NULL`.
 *  @see -presentPopinController:fromRect:animated:completion:
 *  @since v1.0
 */
- (void)presentPopinController:(UIViewController *)popinController animated:(BOOL)animated
                    completion:(void(^)(void))completion;

/**
 *  Present a popin controller as a child of the receiver, centered inside an arbitrary rect.
 *
 *  @param popinController The controller to present as a popin.
 *  @param rect            An arbitrary rect in which the popin should be centered.
 *  @param animated        Pass `YES` to animate the presentation. Otherwise, pass `NO`.
 *  @param completion      A completion handler, or `NULL`.
 *  @since v1.0
 */
- (void)presentPopinController:(UIViewController *)popinController fromRect:(CGRect)rect animated:(BOOL)animated
                    completion:(void(^)(void))completion;

/**
 *  Dismiss the visible popin if any.
 *
 *  @param animated Pass `YES` to animate the dismiss. Otherwise, pass `NO`.
 *  @see dismissCurrentPopinControllerAnimated:completion:
 *  @since v1.0
 */
- (void)dismissCurrentPopinControllerAnimated:(BOOL)animated;

/**
 *  Dismiss the visible popin if any.
 *
 *  @param animated   Pass `YES` to animate the dismiss. Otherwise, pass `NO`.
 *  @param completion A completion handler, or `NULL`.
 *  @since v1.0
 */
- (void)dismissCurrentPopinControllerAnimated:(BOOL)animated completion:(void(^)(void))completion;

///---------------------
/// @name Properties accessors
///---------------------

/**
 *  A reference to the popin presented as a child controller.
 *
 *  @return The controller presented as a popin or `nil`.
 *  @see -presentingPopinViewController
 *  @since v1.0
 */
- (UIViewController *)presentedPopinViewController;

/**
 *  A reference to the parent presenting the popin.
 *
 *  @return The controller presenting the popin, or `nil`.
 *  @see -presentedPopinViewController
 *  @since v1.0
 */
- (UIViewController *)presentingPopinViewController;

/**
 *  Get desired size for popin.
 *
 *  @return The desired size for this controller when presented as a popin. Or `CGSizeZero` if not set.
 *  @see -setPreferedPopinContentSize:
 *  @since v1.0
 */
- (CGSize)preferedPopinContentSize;

/**
 *  Set the desired size for popin. This value may not be respected if popin is bigger than the presenting controller view.
 *  If not set, the default size will be the controller view size.
 *
 *  @param preferredSize The desired size for this controller when presented as a popin.
 *  @since v1.0
 */
- (void)setPreferedPopinContentSize:(CGSize)preferredSize;

/**
 *  The transition style to use when presenting a popin. Default value is `IRPopinTransitionStyleSlide`.
 *
 *  @return A IRPopinTransitionStyle value.
 *  @see -setPopinTransitionStyle:
 *  @since v1.0
 */
- (IRPopinTransitionStyle)popinTransitionStyle;

/**
 *  The transition style to use when presenting a popin. For a list of possible transition style, see `IRPopinTransitionStyle`.
 *
 *  @param transitionStyle A IRPopinTransitionStyle value.
 *  @since v1.0
 */
- (void)setPopinTransitionStyle:(IRPopinTransitionStyle)transitionStyle;

/**
 *  The transition direction to use when presenting a popin. Default value is `IRPopinTransitionDirectionBottom`.
 *
 *  @return A IRPopinTransitionDirection value.
 *  @see -setPopinTransitionDirection:
 *  @since v1.0
 */
- (IRPopinTransitionDirection)popinTransitionDirection;

/**
 *  The transition direction to use when presenting a popin. For a list of possible transition direction, see IRPopinTransitionDirection
 *
 *  @param transitionDirection A IRPopinTransitionDirection value.
 *  @since v1.0
 */
- (void)setPopinTransitionDirection:(IRPopinTransitionDirection)transitionDirection;

/**
 *  The options to apply to the popin. Default value is `IRPopinDefault`.
 *
 *  @return The IRPopinOption values as a bit field.
 *  @see -setPopinOptions:
 *  @since v1.0
 */
- (IRPopinOption)popinOptions;

/**
 *  The options to apply to the popin. For a list of possible options, see IRPopinOption
 *
 *  @param popinOptions The IRPopinOption values separated by | character.
 *  @since v1.0
 */
- (void)setPopinOptions:(IRPopinOption)popinOptions;


/**
 *  Get the custom in animation block. Default value is nil.
 *
 *  @return The In animation block.
 *  @see -setPopinCustomInAnimation:
 *  @since v1.3
 */
- (void (^)(UIViewController * popinController,CGRect initialFrame,CGRect finalFrame))popinCustomInAnimation;

/**
 *  The popinCustomAnimation let you pass an custom in animation. The popInController frame must be the finalFrame in the end of the animation.
 *
 *  @param customInAnimation The Block with animation.
 *  @since v1.3
 */
- (void)setPopinCustomInAnimation:(void (^)(UIViewController * popinController,CGRect initialFrame,CGRect finalFrame))customInAnimation;

/**
 *  Get the custom out animation block. Default value is nil.
 *
 *  @return The Out animation block.
 *  @see -setPopinCustomOutAnimation:
 *  @since v1.3
 */
- (void (^)(UIViewController * popinController,CGRect initialFrame,CGRect finalFrame))popinCustomOutAnimation;

/**
 *  The popinCustomOutAnimation let's you pass an custom out animation. The popInController frame must be the finalFrame in the end of the animation.
 *
 *  @param customOutAnimation The Block with animation.
 *  @since v1.3
 */
- (void)setPopinCustomOutAnimation:(void (^)(UIViewController * popinController,CGRect initialFrame,CGRect finalFrame))customOutAnimation;

/**
 *  The options to apply to the popin. Default value is `IRPopinAlignementOptionCentered`.
 *
 *  @return The IRPopinAlignementOption values as a bit field.
 *  @see -setPopinAlignement:
 *  @since v1.3
 */
- (IRPopinAlignementOption)popinAlignment;

/**
 *  The options to apply to the popin. For a list of possible options, see IRPopinAlignementOption
 *
 *  @param popinAlignement The IRPopinAlignementOption values separated by | character.
 *  @since v1.3
 */
- (void)setPopinAlignment:(IRPopinAlignementOption)popinAlignment;

/**
 *  An object used to configure the blurred background.
 *
 *  @return The blur parameters object.
 *  @see -setBlurParameters:
 *  @since v1.4
 */
- (IRBlurParameters *)blurParameters;

/**
 *  An object used to configure the blurred background.
 *
 *  @param blurParameters The blur parameters object.
 *  @sicne v1.4
 */
- (void)setBlurParameters:(IRBlurParameters *)blurParameters;

@end
