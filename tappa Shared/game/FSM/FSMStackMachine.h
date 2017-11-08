//
//  FSMStackMachine.h
//  tappa
//
//  Created by Igor on 07/11/2017.
//  Copyright © 2017 Igor Rudym. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "../TPEvent.h"
#import "FSMState.h"

@interface FSMStackMachine : NSObject

@property id object;

-(id) initWithObject: (id)object;

+(id) createWithObject: (id)object;

-(void) update;
-(void) handleEvent:(TPEvent*)event;

-(void) pushState:(id<FSMState>)state;
-(id<FSMState>) popState;
-(id<FSMState>) getCurrentState;

@end
