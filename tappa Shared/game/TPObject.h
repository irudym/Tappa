//
//  TPObject.h
//  tappa
//
//  Created by Igor on 06/11/2017.
//  Copyright © 2017 Igor Rudym. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>
#import "TPEvent.h"
#import "FSM/FSMStackMachine.h"

@interface TPObject : SKSpriteNode

@property CGVector currentDirection;
@property CGFloat objectSpeed;
@property BOOL deadMark;
@property CGFloat objectAngle;

//stateMachine
@property FSMStackMachine* stateMachine;

-(void) setFrame: (SKTexture*) frame;

//process events
-(void) handleEvent: (TPEvent*) event;

//update the object and its state machine
-(void) update;

//instances
+(CGVector) rotateVector:(CGVector)vec ByAngle:(float)angle;

//actions
-(void) run;
-(void) turnByAngle: (CGFloat) angle;
-(void) die;
-(void) markAsDead;

-(void) fixPosition;

-(void) setAngle: (CGFloat)angle;

//utils
-(BOOL) isDead;


@end
