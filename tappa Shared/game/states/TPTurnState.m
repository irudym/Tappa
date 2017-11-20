//
//  TPTurnState.m
//  tappa
//
//  Created by Igor on 07/11/2017.
//  Copyright © 2017 Igor Rudym. All rights reserved.
//

#import "TPTurnState.h"
#import "TPDieState.h"
#import "TPObject.h"

@implementation TPTurnState

+(id) createState {
    TPTurnState* state = [[TPTurnState alloc] init];
    return state;
}

-(id<FSMState>) handleEvent: (TPEvent*)event withObject: (id)object {
    if (event.type == EVENT_TAP) {
        //the bug must die!
        return [TPDieState createState];
    }
    return nil;
}

/**
 * updateWithObject
 * @param object - object which the state controls
 * @return     null - in case no more actions
 *              pointer to current state - in case state is in a process
 *              pointer to next state - in case object needs to perform next state after current
 */
-(id<FSMState>) updateWithObject: (id)object {
    //check if object action is done, and return null otherwise return pointer to class
    TPObject* obj = (TPObject*)object;
    if ([obj actionForKey:@"turning"] != nil) return self;
    
    //move the object a little bit, otherwise it gets OVER_EDGE event again
    //TODO: raise OVER_EDGE event in case an object is going to cross edge in the next update (position.x + direction.dx*dx > edge.max_x)
    //DEPRECATED
    // [obj fixPosition];
    return nil;
}

-(void) enterWithObject: (id) object {
    TPObject* obj = (TPObject*)object;
    [obj turnByAngle:3.1427];
}

@end
