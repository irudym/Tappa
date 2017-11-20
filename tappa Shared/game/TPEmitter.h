//
//  TPEmitter.h
//  tappa
//
//  Created by Igor on 17/11/2017.
//  Copyright © 2017 Igor Rudym. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>

@interface TPEmitter : SKEmitterNode

+(id) createEmitterWithName: (NSString*)name andPosition: (CGPoint)position andParent: (SKNode*)node;

@end
