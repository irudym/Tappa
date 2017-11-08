//
//  TPRunState.m
//  tappa
//
//  Created by Igor on 06/11/2017.
//  Copyright © 2017 Igor Rudym. All rights reserved.
//

#import "TPRunState.h"
#import "TPTurnState.h"
#import "TPDieState.h"
#import "TPObject.h"

@implementation TPRunState

+(id) createState {
    TPRunState* state = [[TPRunState alloc] init];
    return state;
}


-(id<FSMState>) handleEvent: (TPEvent*)event withObject: (id)object {
    if (event.type == EVENT_TAP) {
        //the bug must die!
        return [TPDieState createState];
    }
    if (event.type == EVENT_OVER_EDGE) {
        return [TPTurnState createState];
    }
    return nil;
}

-(id<FSMState>) updateWithObject: (id)object {
    return self;
}

-(void) enterWithObject: (id) object {
    TPObject* obj = (TPObject*)object;
    [obj run];
}

@end
