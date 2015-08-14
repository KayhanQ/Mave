//
//  Game.m
//  Skater
//
//  Created by Kayhan Qaiser on 2015-08-12.
//  Copyright (c) 2015 Kayhan Qaiser. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Game.h"
#import "SparrowTiled.h"
#import "LevelEngine.h"

@implementation Game

-(id)init
{
    if ((self = [super init])) {
        
        // This is where the code of your game will start;
        // in this sample, we add just a simple quad to see if it works.
        
        SPQuad *quad = [SPQuad quadWithWidth:100 height:100];
        quad.color = 0xffffff;
        quad.x = 50;
        quad.y = 50;
        [self addChild:quad];

        LevelEngine* newLevel = [[LevelEngine alloc] initWithName:@"Level_1.tmx"];
        [self addChild:newLevel];
        
    }
    return self;
}

@end