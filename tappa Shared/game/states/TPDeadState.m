//
//  TPDeadState.m
//  tappa
//
//  Created by Igor on 07/11/2017.
//  Copyright © 2017 Igor Rudym. All rights reserved.
//

#import "TPDeadState.h"
#import "TPObject.h"

@implementation TPDeadState

+(id) createState {
    TPDeadState* state = [[TPDeadState alloc] init];
    return state;
}

-(id<FSMState>) handleEvent: (TPEvent*)event withObject: (id)object {
    return nil;
}

/**
 * updateWithObject
 * @param object - object which the state controls
 * @return     null - in case no more action
 *              pointer to current state - in case state is in a process
 *              pointer to next state - in case object needs to perform next state after current
 */
-(id<FSMState>) updateWithObject: (id)object {
    return self;
}

-(void) enterWithObject: (id) object {
    TPObject* obj = (TPObject*)object;
    [obj markAsDead];
}


@end
