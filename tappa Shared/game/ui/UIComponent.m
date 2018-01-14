//
//  UIComponent.m
//  animatrix
//
//  Created by Igor on 25/12/2017.
//  Copyright © 2017 Igor Rudym. All rights reserved.
//

#import "UIComponent.h"

@implementation UIComponent
{
    SKTexture* initialTexture;
}
@synthesize focusable;
@synthesize focus;

+(id) createWithTexture: (SKTexture*) texture {
    UIComponent* component = [[UIComponent alloc] initWithTexture:texture];
    if(component == nil) return nil;
    
    return component;
}

+(id) createWithNode:(SKSpriteNode *)node {

    UIComponent* component = [[UIComponent alloc] initWithNode:node];
    return component;
}

-(id) initWithNode: (SKSpriteNode*) node {
    //remove the node from the scene as we expect to substite it with new created UIComponent
    
    [node removeFromParent];
    self = [self initWithTexture:node.texture];
    if(self == nil) return nil;
    
    self.position = node.position;
    self.anchorPoint = node.anchorPoint;
    
    return self;
}


-(id) initWithTexture:(SKTexture *)texture {
    NSLog(@"Call UIComponent::initWithTexture");
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
    initialTexture = texture;
    
    return self;
}

- (instancetype)initWithImageNamed:(NSString *)name {
    NSLog(@"Call UIComponent::initWithImageNamed: %@", name);
    self = [super initWithImageNamed:name];
    return self;
}

-(void)performAction {
    self.action();
}

-(void)onTouchDown:(CGPoint)mouse {
}

-(void)onTouchUp:(CGPoint)mouse {
}

-(BOOL)isFocusable {
    return self.focusable;
}

-(void)reset {
    [self removeAllActions];

    [self setTexture:initialTexture];
    [self setSize: [initialTexture size]];

    self.position = self.initialPosition;
}

@end
