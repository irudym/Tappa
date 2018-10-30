//
//  TPSequenceStep.h
//  tappa
//
//  Created by Igor Rudym (Intel) on 25/10/2018.
//  Copyright © 2018 Igor Rudym. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface TPSequenceStep : NSObject

@property NSString* bugName;
@property int duration;

+(id) createWithName: (NSString*)name andDuration: (int) duration;

-(int) decreaseDuration;

@end

NS_ASSUME_NONNULL_END
