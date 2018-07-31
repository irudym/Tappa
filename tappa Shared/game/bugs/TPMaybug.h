//
//  TPMaybug.h
//  tappa
//
//  Created by Igor Rudym (Intel) on 31/07/2018.
//  Copyright © 2018 Igor Rudym. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "../TPBug.h"

@interface TPMaybug : NSObject
+(id) createMaybugAtPosition: (CGPoint) position andAngle: (CGFloat) angle;
@end
