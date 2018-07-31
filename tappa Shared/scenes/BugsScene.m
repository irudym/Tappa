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
#import "../game/ui/UIComponent.h"
#import "../game/ui/TPButton.h"
#import "../game/ui/UI.h"

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
    UI* mainUI;
    
    uint bugCount;
    SKLabelNode* bugCountLabel;
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
    [TPSharedTextureAtlas loadAtlas:@"ui"];
//#endif
    
    [self setMaximumBugs:4];
    
    // Get label node from scene and store it for use later
    //_label = (SKLabelNode *)[self childNodeWithName:@"//helloLabel"];
    //_label.alpha = 0.0;
    //[_label runAction:[SKAction fadeInWithDuration:2.0]];
    
    //setup UI
    //SKTextureAtlas* uiAtlas = [TPSharedTextureAtlas getAtlasByName:@"ui"];
    

    mainUI = [[UI alloc] init];
    TPButton* homeButton = [[TPButton alloc] initWithNode: (SKSpriteNode*)[self childNodeWithName:@"//homeButton"]];
    if(homeButton == nil) {
        NSLog(@"Cannot find home button on the scene!");
    } else {
        [homeButton setFocusable:YES];
        [homeButton setInitialPosition:homeButton.position];
        [mainUI addChild:homeButton];
    }
    
    [self addChild:mainUI];
    
    bugCount = 0;
    bugCountLabel = (SKLabelNode *)[self childNodeWithName:@"//bugCountLabel"];
    [mainUI addChild:bugCountLabel];
    [mainUI addChild:[self childNodeWithName:@"//bugsLabel"]];
    
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

-(void) incBugCount {
    bugCount++;
    bugCountLabel.text = [NSString stringWithFormat:@"%d",bugCount];
    
    //increase amount of bugs on the scene
    if (bugCount == 10) {
        self.maximumBugs++;
    }
    if( bugCount == 20) {
        self.maximumBugs++;
    }
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
    //added to the scene in the same time
    while(self.maximumBugs > self.sceneObjects.count) {
        [self generateBug];
    }
}

-(void)generateBug {
    // change maximum bug number to bring new bug on the screen
    if(bugCount > 20) [bugGenerator setMaximumBugNumber:4];
    else
        if(bugCount > 10) [bugGenerator setMaximumBugNumber:3];
    TPBug *bug  = [bugGenerator generate];
    NSLog(@"Add new bug at position: (%f, %f) with angle: %f", bug.position.x, bug.position.y, bug.objectAngle);
    [self addBug:bug];
}

-(void) tapAtPoint: (CGPoint) point {
    //TODO: return only one node at the tap point, thus it impossible to catch two or more bug in one tap
    NSArray *nodes = [self nodesAtPoint:point];
    for (SKNode* node in nodes) {
        if (node != nil) {
            // NSLog(@"NODE user data: %@", node.userData[@"type"]);
            if ([node.userData[@"type"] isEqualToString:@"bug"]) {
                TPBug* bug = (TPBug*)node;
                [bug handleEvent:[TPEvent createEventByType:EVENT_TAP]];
                
                //suppose an user catches a bug
                [self incBugCount];
            }
        }
    }
}

#if TARGET_OS_IOS || TARGET_OS_TV
// Touch-based event handling

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    for (UITouch *t in touches) {
        CGPoint pos = [t locationInNode: self];
        [self tapAtPoint:pos];
        [mainUI touchesBegan:pos];
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
    for (UITouch *t in touches) {
        CGPoint pos = [t locationInNode: self];
        [mainUI touchesEnded:pos];
    }
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
