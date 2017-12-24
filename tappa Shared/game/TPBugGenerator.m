//
//  TPBugGenerator.m
//  tappa
//
//  Created by Igor on 29/11/2017.
//  Copyright © 2017 Igor Rudym. All rights reserved.
//

#import "TPBugGenerator.h"

@implementation TPBugGenerator

-(id) initWithScreenSize: (CGSize) screenSize andScreenAnchor: (CGPoint)screenAnchor andSpriteSize: (CGSize) spriteSize {
    self = [super init];
    if(self == nil) return nil;
    
    self.leftBottomEdge = CGPointMake(-screenSize.width * screenAnchor.x, -screenSize.height * screenAnchor.y);
    self.rightTopEdge = CGPointMake(screenSize.width + self.leftBottomEdge.x, screenSize.height + self.leftBottomEdge.y);
    
    self.spriteSize = spriteSize;
    self.screenSize = screenSize;
    
    self.screenCenter = CGPointMake(screenSize.width*screenAnchor.x + self.leftBottomEdge.x,
    screenSize.height*screenAnchor.y + self.leftBottomEdge.y);
    
    return self;
}

-(CGPoint) getPositionByX: (CGFloat)x {
    CGFloat y = 0.0;
    
    if (x > _leftBottomEdge.x && x < _rightTopEdge.x) {
        y = _leftBottomEdge.y - _spriteSize.height/2 + arc4random_uniform(2)*(_rightTopEdge.y + _spriteSize.height - _leftBottomEdge.y);
    } else {
        y = arc4random_uniform((int)(_screenSize.height - _spriteSize.width*2)) + _leftBottomEdge.y + _spriteSize.width;
    }
    
    return CGPointMake(x,y);
}

-(CGFloat) getAngleByPosition: (CGPoint) position {
    CGFloat angle = arc4random_uniform(46);
    if (position.x <= _screenCenter.x) {
        if(position.x > _leftBottomEdge.x) {
            if(position.y > _screenCenter.y) angle += 180;
            else
                //y <= _screenCentre.y
                angle += 315;
        }
        else {
            //x < bottomLeftEdge.x
            if(position.y <= _screenCenter.y) {
                angle += 270;
            } else angle += 225;
        }
    } else {
        //x > screenCenter.x
        if(position.x < _rightTopEdge.x) {
            if(position.y > _screenCenter.y) angle += 135;
            //else angle += 45;
        } else {
            //x > topRightEdge.x
            if(position.y <= _screenCenter.y) {
                angle += 45;
            } else angle += 90;
        }
    }
    return angle;
}

-(TPBug*) generate {
    TPBug* bug = nil;
    CGPoint position = [self getPositionByX:arc4random_uniform((int)(_screenSize.width + _spriteSize.height)) - _spriteSize.height/2+_leftBottomEdge.x];
    CGFloat angle = [self getAngleByPosition:position];
    //NSLog(@"Generate bug at position: (%f, %f) with angle: %f", position.x, position.y, angle);
    NSUInteger bugId = arc4random_uniform(3);
    switch(bugId) {
        case 0:
            bug = [TPBlueBug createBlueBugAtPosition:position andAngle:angle];
            break;
        case 1:
            bug = [TPRedFly createBlueBugAtPosition:position andAngle:angle];
            break;
        case 2:
            bug = [TPDragonfly createDragonflyAtPosition:position andAngle:angle];
            break;
    }
    return bug;
}

@end
