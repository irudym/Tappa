//
//  BugsScene.m
//  tappa
//
//  Created by Igor on 05/11/2017.
//  Copyright © 2017 Igor Rudym. All rights reserved.
//

#import "BugsScene.h"
#import "../game/states/TPRunState.h"

@implementation BugsScene

{
    TPBug *bug1, *bug2;
    NSMutableArray* bugs;
}

+ (BugsScene *)newGameScene {
    // Load 'BugsScene.sks' as an SKScene.
    BugsScene *scene = (BugsScene *)[SKScene nodeWithFileNamed:@"BugsScene"];
    if (!scene) {
        NSLog(@"Failed to load BugsScene.sks");
        abort();
    }
    
    // Set the scale mode to scale to fit the window
    scene.scaleMode = SKSceneScaleModeAspectFill;
    return scene;
}

- (void)setUpScene {
    
    NSLog(@"BugScene: setUpScene");
    
    //load textures
    [TPSharedTextureAtlas loadAtlas:@"Bugs"];
    
    bugs = [NSMutableArray array];
    
    bug1 = [[TPBug alloc] initWithName:@"green-bug" AndPosition:CGPointMake(100, 100)];
    [bug1 setAngle:-90*3.1427/180];
    [[bug1 stateMachine] pushState:[TPRunState createState]];
    [self addChild:bug1];
    
    bug2 = [[TPBug alloc] initWithName:@"green-bug" AndPosition:CGPointMake(-100, 0)];
    [bug2 setAngle:-45*3.1427/180];
    [[bug2 stateMachine] pushState:[TPRunState createState]];
    [self addChild:bug2];
    
    TPBug* bug3 = [[TPBug alloc] initWithName:@"green-bug" AndPosition:CGPointMake(0, 0)];
    [bug3 setAngle:-85*3.1427/180];
    [[bug3 stateMachine] pushState:[TPRunState createState]];
    [self addChild:bug3];
    
    [bugs addObjectsFromArray:@[bug1, bug2, bug3]];
    
    
    // Get label node from scene and store it for use later
    //_label = (SKLabelNode *)[self childNodeWithName:@"//helloLabel"];
    //_label.alpha = 0.0;
    //[_label runAction:[SKAction fadeInWithDuration:2.0]];
    
    
    
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


-(void)update:(CFTimeInterval)currentTime {
    // Called before each frame is rendered
    for(TPBug* bug in bugs) {
        [bug update];
        if (bug.position.x > 400 || bug.position.y > 300 || bug.position.y < -300 || bug.position.x < -400) [bug handleEvent:[TPEvent createEventByType:EVENT_OVER_EDGE]];
    }
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
    
    //check if click in node
    SKNode *node = [self nodeAtPoint:[event locationInNode:self]];
    if (node != nil) {
        TPBug* bug = (TPBug*)node;
        [bug handleEvent:[TPEvent createEventByType:EVENT_TAP]];
    }
}

- (void)mouseDragged:(NSEvent *)event {
    //[self makeSpinnyAtPoint:[event locationInNode:self] color:[SKColor blueColor]];
}

- (void)mouseUp:(NSEvent *)event {
    //[self makeSpinnyAtPoint:[event locationInNode:self] color:[SKColor redColor]];
}

#endif

@end
