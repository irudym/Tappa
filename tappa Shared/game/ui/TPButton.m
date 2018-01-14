//
//  TPButton.m
//  tappa
//
//  Created by Igor on 12/01/2018.
//  Copyright © 2018 Igor Rudym. All rights reserved.
//

#import "TPButton.h"

@implementation TPButton

-(id) initWithNode: (SKSpriteNode*) node {
    self = [super initWithNode: node];
    return self;
}

-(void)onTouchDown:(CGPoint)mouse {
    //NSLog(@"set blend mode");
    //self.colorBlendFactor = 1;
    //CGPoint pos = self.position;
    //[self setPosition:CGPointMake(pos.x+2, pos.y-2)];
}

-(void)onTouchUp:(CGPoint)mouse {
    //CGPoint pos = self.position;
    //[self setPosition:CGPointMake(pos.x-2, pos.y+2)];
    if(self.focusable) {
        if(!self.focus) {
            [self setFocus:YES];
            NSLog(@"Set focus!");
            [self runAction:[SKAction repeatActionForever:[SKAction actionNamed:@"Jump"]]];
        } else {
            [self reset];
            [self setFocus:NO];
            [self performAction];
        }
    }
}
@end
