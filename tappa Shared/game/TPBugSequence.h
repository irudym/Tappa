//
//  TBBugSequence.h
//  tappa
//
//  Created by Igor Rudym (Intel) on 25/10/2018.
//  Copyright © 2018 Igor Rudym. All rights reserved.
//

#import "Stack.h"

NS_ASSUME_NONNULL_BEGIN

@interface TPBugSequence : Stack

-(void) putStepWithBug: (NSString*)name andDuration: (int)duration;
-(int) decreaseCurrentDuration;

@end

NS_ASSUME_NONNULL_END
