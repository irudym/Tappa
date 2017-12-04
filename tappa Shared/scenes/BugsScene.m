//
//  BugsScene.m
//  tappa
//
//  Created by Igor on 05/11/2017.
//  Copyright © 2017 Igor Rudym. All rights reserved.
//

#import "BugsScene.h"
#import "../game/states/TPRunState.h"
#import "TPBugGenerator.h"

#import "DebugNode.h"

@implementation BugsScene
{
    TPBug *bug1, *bug2;
    NSMutableArray* bugs;
    DebugNode* debugNode;
    CGPoint leftBottomEdge;
    CGPoint rightTopEdge;
    CGPoint screenCenter;
    CGSize bugSize;
    TPBugGenerator *bugGenerator;
}

@synthesize maximumBugs;

+ (BugsScene *)newGameScene {
    // Load 'BugsScene.sks' as an SKScene.
    BugsScene *scene = (BugsScene *)[SKScene nodeWithFileNamed:@"BugsScene"];
    if (!scene) {
        NSLog(@"Failed to load BugsScene.sks");
        abort();
    }
    
    //allocate obects array
    scene.sceneObjects = [NSMutableArray array];
    
    // Set the scale mode to scale to fit the window
//#if TARGET_OS_OSX
    scene.scaleMode = SKSceneScaleModeAspectFill;
//#endif
    
    return scene;
}

- (void)setUpScene {
    
    NSLog(@"BugScene: setUpScene");
    
    //setup screen coordinates
    leftBottomEdge = CGPointMake(-self.size.width*self.anchorPoint.x, -self.size.height*self.anchorPoint.y);
    rightTopEdge = CGPointMake(self.size.width*self.anchorPoint.x, self.size.height*self.anchorPoint.y);
    screenCenter = CGPointMake(leftBottomEdge.x + self.size.width/2,
                               leftBottomEdge.y + self.size.height/2);
    
    //TODO: need to load a sample sprite and set actual size
    bugSize = CGSizeMake(416, 500);
    
    //Initialize bug generator
    bugGenerator = [[TPBugGenerator alloc] initWithScreenSize:self.size andScreenAnchor:self.anchorPoint andSpriteSize:bugSize];
    
    
    NSLog(@"Scene position: (%f, %f) and size: (%f, %f)", self.position.x, self.position.y, self.size.width, self.size.height);
    debugNode = [DebugNode createWithPosition:CGPointMake(-self.size.width/2+1, -self.size.height/2+1) andSize:CGSizeMake(self.size.width-1, self.size.height-1)];
    [self addChild:debugNode];
    
    //load textures
//#if TARGET_OS_OSX
    [TPSharedTextureAtlas loadAtlas:@"Bugs"];
    //[TPSharedTextureAtlas loadAtlas:@"Bugs"];
//#endif
    
    /*
    bug2 = [[TPBug alloc] initWithName:@"bug2" AndPosition:CGPointMake(0, 0)];
    [bug2 setAngle:90];
    [[bug2 stateMachine] pushState:[TPRunState createState]];
    [bug2 setObjectSpeed:850.0f];
    
    [self addBug:bug2];
     */
    
    [self setMaximumBugs:4];
    
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

-(void) addBug: (TPBug*) bug {
    [self addChild:bug];
    [_sceneObjects addObject:bug];
}


-(void)update:(CFTimeInterval)currentTime {
    
    //TODO: need to put dead check into cuncurrent threads
    NSMutableIndexSet* deadIndexes = [NSMutableIndexSet indexSet];
    //concurrent implementation
    NSUInteger count = [self.sceneObjects count];
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_apply(count, queue, ^(size_t i) {
        TPObject *obj = self.sceneObjects[i];
        [obj update];
        
        //check over the edge position, generate an event only in case the object is over edges and its direction vector points out the screen
        //if (obj.position.x > 500 || obj.position.y > 400 || obj.position.y < -400 || obj.position.x < -500) [obj handleEvent:[TPEvent createEventByType:EVENT_OVER_EDGE]];
        if ((obj.position.x < leftBottomEdge.x && obj.currentDirection.dx < 0) ||
            (obj.position.y < leftBottomEdge.y && obj.currentDirection.dy < 0) ||
            (obj.position.x > rightTopEdge.x && obj.currentDirection.dx > 0) ||
            (obj.position.y > rightTopEdge.y && obj.currentDirection.dy > 0)) {
            //send turn event to the object
            [obj handleEvent:[TPEvent createEventByType:EVENT_OVER_EDGE]];
        }
        
    });
    
    //clean up
    for(NSUInteger i=0; i< [self.sceneObjects count]; i++) {
        TPObject* obj = self.sceneObjects[i];
        if ([obj isDead]) {
            NSLog(@"Remove object: %@ from scene", obj.name);
            [deadIndexes addIndex:i];
            
            //deattach the object from the scene
            [obj removeFromParent];
        }
    }
    
    if ([deadIndexes count] >0) [self.sceneObjects removeObjectsAtIndexes: deadIndexes];
    
    //add new bugs
    //TODO: it could be implemented mutu-threaded, however it's a rare case when two or more bugs should be
    //added to the scene
    while(self.maximumBugs > self.sceneObjects.count) {
        [self generateBug];
    }
}

-(void)generateBug {
    TPBug *bug  = [bugGenerator generate];
    NSLog(@"Add new bug at position: (%f, %f) with angle: %f", bug.position.x, bug.position.y, bug.objectAngle);
    [self addBug:bug];
}

-(void) tapAtPoint: (CGPoint) point {
    SKNode *node = [self nodeAtPoint:point];
    if (node != nil) {
        // NSLog(@"NODE user data: %@", node.userData[@"type"]);
        if ([node.userData[@"type"] isEqualToString:@"bug"]) {
            TPBug* bug = (TPBug*)node;
            [bug handleEvent:[TPEvent createEventByType:EVENT_TAP]];
        }
    }
}

#if TARGET_OS_IOS || TARGET_OS_TV
// Touch-based event handling

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    for (UITouch *t in touches) {
        [self tapAtPoint:[t locationInNode: self]];
    }
    
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
    
    [self tapAtPoint: [event locationInNode:self]];
}

- (void)mouseDragged:(NSEvent *)event {
    //[self makeSpinnyAtPoint:[event locationInNode:self] color:[SKColor blueColor]];
}

- (void)mouseUp:(NSEvent *)event {
    //[self makeSpinnyAtPoint:[event locationInNode:self] color:[SKColor redColor]];
}

#endif

@end
