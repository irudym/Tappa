//
//  TPSharedTextureAtlas.m
//  tappa
//
//  Created by Igor on 04/11/2017.
//  Copyright © 2017 Igor Rudym. All rights reserved.
//

#import "TPSharedTextureAtlas.h"

extern NSMutableDictionary* gSharedTextures = nil;

@implementation TPSharedTextureAtlas

+(void) initSharedAtlas {
    gSharedTextures = [[NSMutableDictionary alloc] init];
}

+(void) addAtlas: (SKTextureAtlas*) atlas WithName: (NSString*)atlasName {
    if(!gSharedTextures) [TPSharedTextureAtlas initSharedAtlas];
    [gSharedTextures setObject: atlas forKey: atlasName];
}

+(SKTextureAtlas*) getAtlasByName: (NSString*) name {
    return gSharedTextures[name];
}

+(SKTextureAtlas*) loadAtlas:(NSString *)atlasName {
    SKTextureAtlas* atlas = [SKTextureAtlas atlasNamed:atlasName];
    if(atlas) [TPSharedTextureAtlas addAtlas:atlas WithName:atlasName];
    return atlas;
}

@end
