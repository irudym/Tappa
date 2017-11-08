//
//  BugsScene.h
//  tappa
//
//  Created by Igor on 05/11/2017.
//  Copyright © 2017 Igor Rudym. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>
#import "TPSharedTextureAtlas.h"
#import "TPBug.h"
#import "TPRunState.h"

@interface BugsScene : SKScene
+ (BugsScene *)newGameScene;
- (void)setUpScene;

@end
