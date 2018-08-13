//
//  MainMenuScene.h
//  tappa
//
//  Created by Igor Rudym (Intel) on 02/08/2018.
//  Copyright © 2018 Igor Rudym. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <SpriteKit/SpriteKit.h>
#import "TPSharedTextureAtlas.h"


@interface MainMenuScene : SKScene
+ (MainMenuScene *)newGameScene;
- (void)setUpScene;

-(void) tapAtPoint: (CGPoint) point;

@end
