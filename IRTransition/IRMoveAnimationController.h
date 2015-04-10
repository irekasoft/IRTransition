//
//  IRMoveAnimationController.h
//  IRTransitionDemo
//
//  Created by Hijazi on 11/4/15.
//  Copyright (c) 2015 iReka Soft. All rights reserved.
//

#import "IRAnimationController.h"


enum IRMove {
    
    IRMoveFromRight = 0,
    IRMoveFromLeft,
    IRMoveFromTop,
    IRMoveFromBottom,

};

//
@interface IRMoveAnimationController : IRAnimationController

@property (assign) enum IRMove movementType;

@end
