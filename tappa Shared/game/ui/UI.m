//
//  UI.m
//  tappa
//
//  Created by Igor on 11/01/2018.
//  Copyright © 2018 Igor Rudym. All rights reserved.
//

#import "UI.h"

@implementation UI

-(id) init {
    self = [super init];
    if(self == nil) return nil;
    
    [self.userData setObject:@"UI" forKey:@"type"];
    
    return self;
}

-(void)setFoaAllChildrenFocus: (BOOL) focus {
    for (SKNode* object in self.children) {
        UIComponent* component = (UIComponent*)object;
        if(component != nil) {
            if ([component.userData[@"type"] isEqualToString:@"UI"]) {
                [component setFocus:focus];
            }
        }
    }
}

-(void)touchesBegan: (CGPoint)position {
    //remove focuses from all children
    [self setFoaAllChildrenFocus:NO];
    UIComponent *component = (UIComponent*)[self nodeAtPoint:position];
    if(component != nil) {
        if ([component.userData[@"type"] isEqualToString:@"UI"]) {
            [component onTouchDown:position];
        }
    }
}

-(void)touchesEnded: (CGPoint)position {
    UIComponent *component = (UIComponent*)[self nodeAtPoint:position];
    if(component != nil) {
        if ([component.userData[@"type"] isEqualToString:@"UI"]) {
            [component onTouchUp:position];
        }
    }
}

@end
