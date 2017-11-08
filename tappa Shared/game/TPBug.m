//
//  TPBug.m
//  Tappa
//
//  Created by Igor on 04/11/2017.
//  Copyright © 2017 Igor Rudym. All rights reserved.
//
//  Bug object

#import "TPBug.h"
#import "TPSharedTextureAtlas.h"
#import "states/TPRunState.h"

@implementation TPBug
{
    SKTextureAtlas* atlas;
    SKSpriteNode *leg_left_front;
}

-(id) initWithName: (NSString*) name AndPosition: (CGPoint) position {
#if TARGET_OS_IOS || TARGET_OS_TV
    self = [super initWithColor: [UIColor colorWithRed:1 green:1 blue:1 alpha:1] size:CGSizeMake(185, 195)];
#endif
#if TARGET_OS_OSX
    self = [super initWithColor: [NSColor colorWithRed:1 green:1 blue:1 alpha:1] size:CGSizeMake(185, 195)];
#endif
    if(!self) return nil;
    
    atlas = [TPSharedTextureAtlas getAtlasByName:@"Bugs"];
    [self setName:name];
    [self setPosition:position];
    [self load];
    [self setCurrentDirection: CGVectorMake(0,1)]; // UP
    self.anchorPoint = CGPointMake(0.5,0.5);
    [self setObjectSpeed:1.0f];
    
    self.deadMark = FALSE;
    
    //init state machine
    self.stateMachine = [FSMStackMachine createWithObject:self];
    //[self.stateMachine pushState:[TPRunState createState]];
    
    return self;
}

-(void) load {
    
    SKTexture* frame;
    _runFrames = [NSMutableArray array];
    for(int i=1; i<2; i++) {
        NSLog(@"Trying to load: %@-run-%d.png ...", self.name, i);
        frame = [atlas textureNamed: [NSString stringWithFormat:@"%@-run-%d.png", self.name, i]];
        if(frame) NSLog(@"Ok!");
        //frame.filteringMode = SKTextureFilteringNearest;
        [_runFrames addObject:frame];
    }
    
    //define actions
    _runAction = [SKAction animateWithTextures:_runFrames timePerFrame:0.1f];
    
    [self setFrame:_runFrames[0]];
}

#pragma mark Action methods

-(void) run {
    float x = 1000;
    float y = 1000;
    float dx = self.currentDirection.dx*x;
    float dy = self.currentDirection.dy*y;
    NSLog(@"Run BUG by direction (%f, %f) by (%f, %f)",self.currentDirection.dx, self.currentDirection.dy, dx, dy);
    [self runAction: [SKAction moveBy:CGVectorMake(dx, dy) duration: 2]];
    //[self runAction: [SKAction repeatActionForever: _runAction]];
}

-(void) turn {
}

-(void) turnByAngle:(CGFloat)angle {
    //cancel all actions
    [self removeAllActions];
    [self runAction: [SKAction rotateByAngle:angle duration:.5] withKey:@"turning"];
    
    self.currentDirection = [TPObject rotateVector:self.currentDirection ByAngle:angle];
    //animation?
}

-(void) die {
    //cancel all actions
    [self removeAllActions];
    
    //play die animation
    [self runAction: [SKAction fadeOutWithDuration:0.5] withKey:@"dying"];
}

@end
