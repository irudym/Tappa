//
//  UIProtocol.h
//  Tappa[tushka]
//
//  Created by Igor on 25/12/2017.
//  Copyright © 2017 Igor Rudym. All rights reserved.
//

#ifndef UIProtocol_h
#define UIProtocol_h

@protocol UIProtocol

-(void)performAction;
-(void)onTouchDown: (CGPoint)mouse;
-(void)onTouchUp: (CGPoint)mouse;
-(void)setFocusable: (BOOL)focus;
-(BOOL)isFocusable;

/**
 *  set default texture and position
 **/
-(void)reset;

@end


#endif /* UIProtocol_h */
