//
//  UIComponent.m
//  animatrix
//
//  Created by Igor on 25/12/2017.
//  Copyright © 2017 Igor Rudym. All rights reserved.
//

#import "UIComponent.h"

@implementation UIComponent
@synthesize focusable;
@synthesize focus;

+(id) createWithTexture: (SKTexture*) texture {
    UIComponent* component = [[UIComponent alloc] initWithTexture:texture];
    if(component == nil) return nil;
    
    return component;
}

-(id) initWithTexture:(SKTexture *)texture {
    self = [super initWithTexture:texture];
    if (self == nil) return nil;
    self.anchorPoint = CGPointMake(0.5, 0.5);
    self.userData = [NSMutableDictionary dictionary];
    [self.userData setObject:@"UI" forKey:@"type"];
    [self setAction:^{
        NSLog(@"No action set");
    }];
    
    self.color = [SKColor whiteColor];
    self.colorBlendFactor = 0.0;
    self.focus = NO;
    self.focusable = NO;
    
    return self;
}

-(void)performAction {
    self.action();
    //CGPoint pos = self.position;
    //[self setPosition:CGPointMake(pos.x-2, pos.y+2)];
}

-(void)onTouchDown:(CGPoint)mouse {
    //NSLog(@"set blend mode");
    //self.colorBlendFactor = 1;
    CGPoint pos = self.position;
    [self setPosition:CGPointMake(pos.x+2, pos.y-2)];
}

-(void)onTouchUp:(CGPoint)mouse {
    CGPoint pos = self.position;
    [self setPosition:CGPointMake(pos.x-2, pos.y+2)];
    if(focusable) {
        if(!focus) {
            [self setFocus:true];
            NSLog(@"Set focus!");
        }
    }
}

-(BOOL)isFocusable {
    return self.focusable;
}

@end
