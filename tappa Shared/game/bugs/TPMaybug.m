//
//  TPMaybug.m
//  tappa
//
//  Created by Igor Rudym (Intel) on 31/07/2018.
//  Copyright © 2018 Igor Rudym. All rights reserved.
//

#import "TPMaybug.h"
#import "../states/TPRunState.h"

@implementation TPMaybug
+ (id)createMaybugAtPosition:(CGPoint)position andAngle:(CGFloat)angle {
    TPBug* bug = [[TPBug alloc] initWithName:@"maybug" AndPosition: position];
    [bug setAngle: angle];
    [bug setObjectSpeed:250.0f];
    
    [[bug stateMachine] pushState:[TPRunState createState]];
    
    bug.zPosition = 1;  // should be on ground, however could overlap with others bugs
    return bug;
}

@end
