//
//  DebugNode.h
//  tappa
//
//  Created by Igor on 16/11/2017.
//  Copyright © 2017 Igor Rudym. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>

@interface DebugNode : SKShapeNode


+(id) createWithPosition: (CGPoint)pos andSize: (CGSize) size;
-(id) initWithPosition: (CGPoint)pos andSize: (CGSize) size;


@end
