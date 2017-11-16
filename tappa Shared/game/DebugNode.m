//
//  DebugNode.m
//  tappa
//
//  Created by Igor on 16/11/2017.
//  Copyright © 2017 Igor Rudym. All rights reserved.
//

#import "DebugNode.h"

@implementation DebugNode

+(id) createWithPosition:(CGPoint)pos andSize:(CGSize)size {
    DebugNode *node = [[DebugNode alloc] initWithPosition:pos andSize:size];
    return node;
}

-(id) initWithPosition:(CGPoint)pos andSize: (CGSize) size{
    self =  [super init];
    if (self == nil) return nil;
    
    [self setPosition:pos];
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathAddRect(path, nil, CGRectMake(0, 0, size.width, size.width));
    
    self.path = path;
    self.lineWidth = 1.0;
    self.strokeColor = [SKColor redColor];
    
    return self;
}
@end
