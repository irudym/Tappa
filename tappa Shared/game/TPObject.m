//
//  TPObject.m
//  tappa
//
//  Created by Igor on 06/11/2017.
//  Copyright © 2017 Igor Rudym. All rights reserved.
//

#import "TPObject.h"

@implementation TPObject

@synthesize currentDirection;
@synthesize objectSpeed;
@synthesize stateMachine;

/*
-(id) init {
    self = [super init];
    if (self == nil) return nil;
    self.stateMachine = [FSMStackMachine createWithObject:self];
    
    return self;
}
 */

-(void) setFrame: (SKTexture*) frame {
    //NSLog(@"Call setFrame...");
    [self setTexture:frame];
    [self setSize: [frame size]];
}

-(void) setAngle:(CGFloat)angle {
    [self setObjectAngle:angle];
    [self setCurrentDirection: [TPObject rotateVector:self.currentDirection ByAngle:angle*3.1427/180]];
    [self setZRotation: angle*3.1427/180];
}

#pragma mark State Machine operation

-(void) handleEvent:(TPEvent*)event {
    [stateMachine handleEvent:event];
}

-(void) update {
    [stateMachine update];
}

//actions
#pragma mark Actions
-(void) run {
}

-(void) turnByAngle:(CGFloat)angle {
}

-(void) die {
}

-(void) markAsDead {
    self.deadMark = TRUE;
}

-(BOOL) isDead {
    return self.deadMark;
}

//DEPRECATED
-(void)fixPosition {
    NSLog(@"TPObject: fix position from (%f,%f)", self.position.x, self.position.y);
    NSLog(@"TPObject: fix position with direction: (%f,%f)", currentDirection.dx, currentDirection.dy);
    float nx = currentDirection.dx*10 + self.position.x;
    float ny = currentDirection.dy*10 + self.position.y;
    NSLog(@"TPObject: fix position to (%f,%f)", nx, ny);
    [self setPosition:CGPointMake(nx, ny)];
    
}

//instances
#pragma mark Instances methods

+(CGVector) rotateVector: (CGVector)vec ByAngle:(float)angle {
    float x = vec.dx;
    float y = vec.dy;
    return CGVectorMake(x*cosf(angle) - y*sinf(angle), x*sinf(angle) + y*cosf(angle));
}

@end
