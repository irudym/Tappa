//
//  BugsScene.h
//  tappa Shared
//
//  Created by Igor on 04/11/2017.
//  Copyright © 2017 Igor Rudym. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>
#import "TPSharedTextureAtlas.h"
#import "TPBug.h"

@interface GameScene : SKScene

+ (GameScene *)newGameScene;
- (void)setUpScene;



@end
