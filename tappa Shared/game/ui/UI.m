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
    self.zPosition = 1000.0f;
    
    return self;
}

-(void)addChild:(SKNode *)node {
    [node removeFromParent];
    [super addChild:node];
}

-(void)setForAllChildrenFocus: (BOOL) focus except: (UIComponent*) element {
    for (SKNode* object in self.children) {
        UIComponent* component = (UIComponent*)object;
        if(component != nil && component != element ) {
            if ([component.userData[@"type"] isEqualToString:@"UI"]) {
                [component setFocus:focus];
                //remove all actions in case if unfocusing
                if(!focus) {
                    [component reset];
                }
            }
        }
    }
}

-(void)touchesBegan: (CGPoint)position {
    UIComponent *component = (UIComponent*)[self nodeAtPoint:position];
    if(component != nil) {
        if ([component.userData[@"type"] isEqualToString:@"UI"]) {
            [component onTouchDown:position];
        }
    }
    //remove focuses from all children including previously focused element
    [self setForAllChildrenFocus:NO except: component];
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
