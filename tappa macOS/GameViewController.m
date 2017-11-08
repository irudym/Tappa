//
//  GameViewController.m
//  tappa macOS
//
//  Created by Igor on 04/11/2017.
//  Copyright © 2017 Igor Rudym. All rights reserved.
//

#import "GameViewController.h"
#import "BugsScene.h"

@implementation GameViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    //GameScene *sceneNode = [GameScene newGameScene];
    BugsScene *sceneNode = [BugsScene newGameScene];
    
    // Present the scene
    SKView *skView = (SKView *)self.view;
    [skView presentScene:sceneNode];
    
    skView.ignoresSiblingOrder = YES;
    skView.showsFPS = YES;
    skView.showsNodeCount = YES;
}

@end
