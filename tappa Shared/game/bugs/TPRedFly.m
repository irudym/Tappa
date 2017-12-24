//
//  TPRedFly.m
//  tappa
//
//  Created by Igor on 22/11/2017.
//  Copyright © 2017 Igor Rudym. All rights reserved.
//

#import "TPRedFly.h"
#import "../states/TPRunState.h"

@implementation TPRedFly

+(id) createBlueBugAtPosition: (CGPoint) position andAngle: (CGFloat) angle {
    TPBug* bug = [[TPBug alloc] initWithName:@"bug2" AndPosition: position];
    [bug setAngle: angle];
    [bug setObjectSpeed:650.0f];
    
    [[bug stateMachine] pushState:[TPRunState createState]];
    return bug;
}

@end
