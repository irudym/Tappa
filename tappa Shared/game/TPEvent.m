//
//  TPEvent.m
//  tappa
//
//  Created by Igor on 06/11/2017.
//  Copyright © 2017 Igor Rudym. All rights reserved.
//

#import "TPEvent.h"

@implementation TPEvent

@synthesize type;
@synthesize point;
@synthesize angle;

-(id) initWithType:(EventTypes)type {
    self = [super init];
    if (self!=nil) {
        [self setType:type];
    }
    return self;
}

+(id) createEventByType:(EventTypes)type {
    TPEvent *event  = [[TPEvent alloc] initWithType:type];
    return event;
}

@end
