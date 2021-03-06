//
//  GameScene.m
//  tappa Shared
//
//  Created by Igor on 04/11/2017.
//  Copyright © 2017 Igor Rudym. All rights reserved.
//

#import "GameScene.h"

@implementation GameScene {
    SKShapeNode *_spinnyNode;
    SKLabelNode *_label;
    NSArray* bugs;
}

+ (GameScene *)newGameScene {
    /*
    // Load 'BugsScene.sks' as an SKScene.
    GameScene *scene = (GameScene *)[SKScene nodeWithFileNamed:@"BugsScene"];
    if (!scene) {
        NSLog(@"Failed to load BugsScene.sks");
        abort();
    }
    
    // Set the scale mode to scale to fit the window
    scene.scaleMode = SKSceneScaleModeAspectFill;
    
    return scene;
     */
    return nil;
}

- (void)setUpScene {
    
    //load textures
    /*
    [TPSharedTextureAtlas loadAtlas:@"Bugs"];
    
    green_bug = [[TPBug alloc] initWithName:@"green-bug" AndPosition:CGPointMake(100, 100)];
    [green_bug setAngle:-45*3.1427/180];
    [self addChild:green_bug];
    
    TPBug *bug2 = [[TPBug alloc] initWithName:@"green-bug" AndPosition:CGPointMake(-100, 0)];
    [bug2 setAngle:-90*3.1427/180];
    [self addChild:bug2];
    
    // Get label node from scene and store it for use later
    //_label = (SKLabelNode *)[self childNodeWithName:@"//helloLabel"];
    //_label.alpha = 0.0;
    //[_label runAction:[SKAction fadeInWithDuration:2.0]];
    */
    

#if TARGET_OS_WATCH
#endif
    
}

#if TARGET_OS_WATCH
- (void)sceneDidLoad {
    [self setUpScene];
}
#else
- (void)didMoveToView:(SKView *)view {
    [self setUpScene];
}
#endif

- (void)makeSpinnyAtPoint:(CGPoint)pos color:(SKColor *)color {
    SKShapeNode *spinny = [_spinnyNode copy];
    spinny.position = pos;
    spinny.strokeColor = color;
    [self addChild:spinny];
}

-(void)update:(CFTimeInterval)currentTime {
    // Called before each frame is rendered
}

#if TARGET_OS_IOS || TARGET_OS_TV
// Touch-based event handling

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    //[_label runAction:[SKAction actionNamed:@"Pulse"] withKey:@"fadeInOut"];
    
    //for (UITouch *t in touches) {
    //    [self makeSpinnyAtPoint:[t locationInNode:self] color:[SKColor greenColor]];
    //}
}
- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event{
    //for (UITouch *t in touches) {
    //    [self makeSpinnyAtPoint:[t locationInNode:self] color:[SKColor blueColor]];
    //}
}
- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    //for (UITouch *t in touches) {
    //    [self makeSpinnyAtPoint:[t locationInNode:self] color:[SKColor redColor]];
    //}
}
- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event {
    //for (UITouch *t in touches) {
    //    [self makeSpinnyAtPoint:[t locationInNode:self] color:[SKColor redColor]];
    //}
}
#endif

#if TARGET_OS_OSX
// Mouse-based event handling

- (void)mouseDown:(NSEvent *)event {
    //[_label runAction:[SKAction actionNamed:@"Pulse"] withKey:@"fadeInOut"];
    
    //[self makeSpinnyAtPoint:[event locationInNode:self] color:[SKColor greenColor]];
}

- (void)mouseDragged:(NSEvent *)event {
    //[self makeSpinnyAtPoint:[event locationInNode:self] color:[SKColor blueColor]];
}

- (void)mouseUp:(NSEvent *)event {
    //[self makeSpinnyAtPoint:[event locationInNode:self] color:[SKColor redColor]];
}

#endif

@end
