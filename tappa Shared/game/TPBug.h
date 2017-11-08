//
//  TPBug.h
//  tappa
//
//  Created by Igor on 04/11/2017.
//  Copyright © 2017 Igor Rudym. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>
#import "TPObject.h"


@interface TPBug : TPObject

//frames
@property NSMutableArray *runFrames;

//actions
@property SKAction *runAction;



-(id) initWithName: (NSString*) name AndPosition: (CGPoint) position;

-(void) load;

//actions
-(void) run;
-(void) turn;
-(void) turnByAngle:(CGFloat)angle;
-(void) die;


@end
