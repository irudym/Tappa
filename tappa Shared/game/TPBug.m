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
#import "TPEmitter.h"

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
    self = [super initWithColor: [NSColor colorWithRed:1 green:1 blue:1 alpha:1] size:CGSizeMake(239, 272)];
#endif
    if(!self) return nil;
    
    atlas = [TPSharedTextureAtlas getAtlasByName:@"Bugs"];
    [self setName:name];
    [self setPosition:position];
    [self load];
    [self setCurrentDirection: CGVectorMake(0,1)]; // UP
    self.anchorPoint = CGPointMake(0.5,0.5);
    [self setObjectSpeed:400.0f];
    
    self.deadMark = FALSE;
    
    //init state machine
    self.stateMachine = [FSMStackMachine createWithObject:self];
    //[self.stateMachine pushState:[TPRunState createState]];
    self.userData = [NSMutableDictionary dictionary];
    [self.userData setObject:@"bug" forKey:@"type"];
    
    return self;
}

-(void) load {
    
    SKTexture* frame;
    _runFrames = [NSMutableArray array];
    for(int i=1; i<9; i++) {
        //NSLog(@"load image: %@-run-%d.png", self.name, i);
        frame = [atlas textureNamed: [NSString stringWithFormat:@"%@-run-%d.png", self.name, i]];
        //frame.filteringMode = SKTextureFilteringNearest;
        [_runFrames addObject:frame];
        //NSLog(@"==> OK!");
    }
    
    //define actions
    _runAction = [SKAction animateWithTextures:_runFrames timePerFrame:0.05f];
    
    [self setFrame:_runFrames[0]];
}

#pragma mark Action methods

-(void) run {
    float x = 3000;
    float dx = self.currentDirection.dx*x;
    float dy = self.currentDirection.dy*x;
    // NSLog(@"Run BUG by direction (%f, %f) by (%f, %f)",self.currentDirection.dx, self.currentDirection.dy, dx, dy);
    // NSLog(@"BUG: [%@] run with speed: %f", self.name, self.objectSpeed);
    
    [self runAction: [SKAction moveBy:CGVectorMake(dx, dy) duration: x/self.objectSpeed]];
    [self runAction: [SKAction repeatActionForever: _runAction]];
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
    
    //emit particles
    [TPEmitter createEmitterWithName:@"bug-tap" andPosition:self.position andParent:self.parent];
    [TPEmitter createEmitterWithName:@"bug-tap2" andPosition:self.position andParent:self.parent];
    
    //play die animation
    [self runAction: [SKAction fadeOutWithDuration:1.0] withKey:@"dying"];
    
    //play sound
    [self runAction:[SKAction playSoundFileNamed: [self soundName] waitForCompletion: NO]];
}

@end
