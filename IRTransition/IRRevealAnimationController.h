//
//  IRRevealAnimationController.h
//  IRTransitionDemo
//
//  Created by Hijazi on 11/4/15.
//  Copyright (c) 2015 iReka Soft. All rights reserved.
//

#import "IRAnimationController.h"

enum IRReveal {
    
    IRRevealToRight = 0,
    IRRevealToLeft,
    IRRevealToTop,
    IRRevealToBottom,
    
};




@interface IRRevealAnimationController : IRAnimationController

@property (assign) enum IRReveal revealType;

@end
