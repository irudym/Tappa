//
//  UI.h
//  tappa
//
//  Created by Igor on 11/01/2018.
//  Copyright © 2018 Igor Rudym. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>
#import "UIComponent.h"

@interface UI : SKNode

-(id)init;

-(void)addChild:(SKNode *)node;

-(void)touchesBegan: (CGPoint)position;
-(void)touchesEnded: (CGPoint)position;
@end
