//
//  TPSharedTextureAtlas.h
//  tappa
//
//  Created by Igor on 04/11/2017.
//  Copyright © 2017 Igor Rudym. All rights reserved.
//
//  Shared access to textures

#import <Foundation/Foundation.h>
#import <SpriteKit/SpriteKit.h>

@interface TPSharedTextureAtlas : NSObject
+(void) initSharedAtlas;
+(void) addAtlas: (SKTextureAtlas*) atlas WithName: (NSString*)atlasName;
+(SKTextureAtlas*) getAtlasByName: (NSString*)name;

+(SKTextureAtlas*) loadAtlas: (NSString*)atlasName;


@end
