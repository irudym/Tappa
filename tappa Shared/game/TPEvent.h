//
//  TPEvent.h
//  tappa
//
//  Created by Igor on 06/11/2017.
//  Copyright © 2017 Igor Rudym. All rights reserved.
//

#import <Foundation/Foundation.h>

#if TARGET_OS_IOS || TARGET_OS_TV
#import <UIKit/UIKit.h>
#endif

typedef enum {
    EVENT_TAP,
    EVENT_OVER_EDGE,
} EventTypes;

@interface TPEvent : NSObject

@property EventTypes type;
@property CGPoint point;
@property CGFloat angle;

-(id) initWithType: (EventTypes) type;
+(id) createEventByType: (EventTypes) type;

@end
