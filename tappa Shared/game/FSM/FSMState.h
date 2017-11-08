//
//  FSMState.h
//  tappa
//
//  Created by Igor on 07/11/2017.
//  Copyright © 2017 Igor Rudym. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "../TPEvent.h"

@protocol FSMState <NSObject>

-(id<FSMState>) handleEvent: (TPEvent*)event withObject: (id)object;

/**
 * updateWithObject
 * @param object - object which the state controls
 * @return     null - in case no more action
 *              pointer to current state - in case state is in a process
 *              pointer to next state - in case object needs to perform next state after current
 */
-(id<FSMState>) updateWithObject: (id)object;

-(void) enterWithObject: (id) object;
@end
