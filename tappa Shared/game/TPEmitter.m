//
//  TPEmitter.m
//  tappa
//
//  Created by Igor on 17/11/2017.
//  Copyright © 2017 Igor Rudym. All rights reserved.
//

#import "TPEmitter.h"

@implementation TPEmitter

+(id) createEmitterWithName:(NSString *)name andPosition:(CGPoint)position andParent: (SKNode*)node {
    NSString *path = [[NSBundle mainBundle] pathForResource:name ofType:@"sks"];
    TPEmitter *emitter = [NSKeyedUnarchiver unarchiveObjectWithFile:path];
    
    emitter.position = position;
    emitter.name = name;
    emitter.numParticlesToEmit = 10;
    emitter.targetNode = node;
    [node addChild: emitter];
    
    SKAction* removeNode = [SKAction removeFromParent];
    SKAction* waitForSecs = [SKAction waitForDuration: 2];
    SKAction* sequence = [SKAction sequence:@[waitForSecs, removeNode]];
    [emitter runAction:sequence];
    return emitter;
}

@end
