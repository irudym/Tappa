//
//  TPDragonfly.m
//  tappa
//
//  Created by Igor on 23/12/2017.
//  Copyright © 2017 Igor Rudym. All rights reserved.
//

#import "TPDragonfly.h"
#import "../states/TPRunState.h"

@implementation TPDragonfly

+ (id)createDragonflyAtPosition:(CGPoint)position andAngle:(CGFloat)angle {
    TPBug* bug = [[TPBug alloc] initWithName:@"dragonfly" AndPosition: position];
    [bug setAngle: angle];
    [bug setObjectSpeed:350.0f];
    
    [[bug stateMachine] pushState:[TPRunState createState]];
    
    bug.zPosition = 3;
    
    [bug addSoundNamed:@"bell3"];
    
    return bug;
}

@end
