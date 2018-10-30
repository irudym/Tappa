//
//  TPBlueBug.m
//  tappa
//
//  Created by Igor on 21/11/2017.
//  Copyright © 2017 Igor Rudym. All rights reserved.
//

#import "TPBlueBug.h"
#import "../states/TPRunState.h"

@implementation TPBlueBug

+(id) createBlueBugAtPosition: (CGPoint) position andAngle: (CGFloat) angle {
    TPBug* bug = [[TPBug alloc] initWithName:@"bug1" AndPosition: position];
    [bug setAngle: angle];
    [[bug stateMachine] pushState:[TPRunState createState]];
    bug.zPosition = 1;
    
    [bug addSoundNamed:@"bell1"];
    
    
    return bug;
}

@end
