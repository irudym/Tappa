//
//  TBBugSequence.m
//  tappa
//
//  Created by Igor Rudym (Intel) on 25/10/2018.
//  Copyright © 2018 Igor Rudym. All rights reserved.
//

#import "TPBugSequence.h"
#import "TPSequenceStep.h"

@implementation TPBugSequence

- (void)putStepWithBug:(nonnull NSString *)name andDuration:(int)duration { 
    TPSequenceStep *step = [TPSequenceStep createWithName:name andDuration:duration];
    [self pushObject:step];
}

- (int)decreaseCurrentDuration { 
    return [[self peekObject] decreaseDuration];
}

@end
