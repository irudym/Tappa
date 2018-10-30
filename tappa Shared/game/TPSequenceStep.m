//
//  TPSequenceStep.m
//  tappa
//
//  Created by Igor Rudym (Intel) on 25/10/2018.
//  Copyright © 2018 Igor Rudym. All rights reserved.
//

#import "TPSequenceStep.h"

@implementation TPSequenceStep
@synthesize bugName;
@synthesize duration;

- (int)decreaseDuration { 
    duration--;
    return duration;
}

+ (nonnull id)createWithName:(nonnull NSString *)name andDuration:(int)duration { 
    TPSequenceStep* step = [[TPSequenceStep alloc] init];
    [step setBugName:name];
    [step setDuration:duration];
    return step;
}

@end
