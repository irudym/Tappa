//
//  TPBugGenerator.h
//  tappa
//
//  Created by Igor on 29/11/2017.
//  Copyright © 2017 Igor Rudym. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "TPBug.h"
#import "bugs/TPBlueBug.h"
#import "bugs/TPRedFly.h"
#import "bugs/TPDragonfly.h"
#import "bugs/TPMaybug.h"

@interface TPBugGenerator : NSObject

@property CGPoint screenCenter;
@property CGSize screenSize;
@property CGSize spriteSize;
@property CGPoint leftBottomEdge;
@property CGPoint rightTopEdge;
@property uint maximumBugNumber;

-(id) initWithScreenSize: (CGSize) screenSize andScreenAnchor: (CGPoint)anchor andSpriteSize: (CGSize) spriteSize;

-(CGPoint) getPositionByX: (CGFloat)x;
-(CGFloat) getAngleByPosition: (CGPoint) position;

-(TPBug*) generate;

@end
