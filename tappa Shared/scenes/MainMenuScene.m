//
//  MainMenuScene.m
//  tappa
//
//  Created by Igor Rudym (Intel) on 02/08/2018.
//  Copyright © 2018 Igor Rudym. All rights reserved.
//

#import "MainMenuScene.h"
#import "BugsScene.h"

@implementation MainMenuScene


+ (MainMenuScene *)newGameScene { 
    // Load 'MainMenuScene.sks' as an SKScene.
    MainMenuScene *scene = (MainMenuScene *)[SKScene nodeWithFileNamed:@"MainMenuScene"];
    if (!scene) {
        NSLog(@"Failed to load MainMenuScene.sks");
        abort();
    }
    
    
    // Set the scale mode to scale to fit the window
    //#if TARGET_OS_OSX
    scene.scaleMode = SKSceneScaleModeAspectFill;
    //#endif
    
    return scene;
}



- (void)setUpScene { 
    NSLog(@"MainMenuScene: setUpScene");
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


-(void) tapAtPoint: (CGPoint) point {
    SKNode *node = [self nodeAtPoint:point];
    if (node != nil) {
        if ([node.userData[@"type"] isEqualToString:@"start"]) {
            NSLog(@"Start Catch the Bug");
            SKTransition *reveal = [SKTransition revealWithDirection:SKTransitionDirectionUp duration:0.5];
            BugsScene *gameScene = [BugsScene newGameScene];
            [self.scene.view presentScene: gameScene transition: reveal];
        }
    }
}


#if TARGET_OS_IOS || TARGET_OS_TV
// Touch-based event handling

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    NSLog(@"TouchesBegan");
    for (UITouch *t in touches) {
        CGPoint pos = [t locationInNode: self];
        [self tapAtPoint:pos];
    }
    
}
- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event{
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
}

- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event {
}
#endif

#if TARGET_OS_OSX
// Mouse-based event handling

- (void)mouseDown:(NSEvent *)event {
    [self tapAtPoint: [event locationInNode:self]];
}

- (void)mouseDragged:(NSEvent *)event {
}

- (void)mouseUp:(NSEvent *)event {
}

#endif

@end
