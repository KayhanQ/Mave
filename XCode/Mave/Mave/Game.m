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
#import "LevelsMenu.h"
#import "LevelEngine.h"
#import "GameEvents.h"

@implementation Game
{
    LevelEngine* _currentLevel;
    SPSprite* _levelSprite;
}

-(id)init
{
    if ((self = [super init])) {
        
        // This is where the code of your game will start;
        // in this sample, we add just a simple quad to see if it works.

        LevelsMenu* menu = [[LevelsMenu alloc] initWithName:@"world1"];
        [self addChild:menu];
        
        _levelSprite = [[SPSprite alloc] init];
        [self addChild:_levelSprite];
        
        [self addEventListener:@selector(loadLevel:) atObject:self forType:EVENT_TYPE_LOAD_LEVEL];
        [self addEventListener:@selector(levelCompleted:) atObject:self forType:EVENT_TYPE_LEVEL_COMPLETED];

    }
    return self;
}

- (void)loadLevel:(LoadLevelEvent*)event
{
    LevelEngine* newLevel = [[LevelEngine alloc] initWithName:event.levelName];
    [_levelSprite addChild:newLevel];
}

- (void)levelCompleted:(LevelCompletedEvent*)event
{
    [_levelSprite removeAllChildren];
}


@end